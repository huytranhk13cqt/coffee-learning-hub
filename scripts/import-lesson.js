#!/usr/bin/env node
// ============================================================================
// import-lesson.js — CLI tool to import lesson/learning-path YAML into the DB
//
// Usage:
//   node scripts/import-lesson.js path/to/file.yaml [--dry-run]
//   node scripts/import-lesson.js path/to/directory/  [--dry-run]
// ============================================================================

import { readFileSync, readdirSync, statSync, existsSync } from 'fs'
import { createRequire } from 'module'
import { fileURLToPath } from 'url'
import { dirname, join, resolve, extname } from 'path'
import yaml from 'js-yaml'
import { validateLesson, validateLearningPath } from './lesson-schema.js'

// Resolve postgres from server/node_modules (not installed at root)
const __dirname = dirname(fileURLToPath(import.meta.url))
const serverRequire = createRequire(join(__dirname, '..', 'server', 'node_modules', '_'))
const postgres = serverRequire('postgres')

// ---------------------------------------------------------------------------
// Setup — load .env manually (avoids dotenv dependency at root)
// ---------------------------------------------------------------------------

function loadEnvFile(filePath) {
  if (!existsSync(filePath)) return
  const lines = readFileSync(filePath, 'utf-8').split('\n')
  for (const line of lines) {
    const trimmed = line.trim()
    if (!trimmed || trimmed.startsWith('#')) continue
    const eqIdx = trimmed.indexOf('=')
    if (eqIdx === -1) continue
    const key = trimmed.slice(0, eqIdx).trim()
    let val = trimmed.slice(eqIdx + 1).trim()
    // Strip surrounding quotes
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
      val = val.slice(1, -1)
    }
    if (!(key in process.env)) process.env[key] = val
  }
}

loadEnvFile(join(__dirname, '..', '.env'))

const args = process.argv.slice(2)
const dryRun = args.includes('--dry-run')
const filePaths = args.filter(a => a !== '--dry-run')

if (filePaths.length === 0) {
  console.error('Usage: node scripts/import-lesson.js <file.yaml|directory> [--dry-run]')
  process.exit(1)
}

const sql = postgres({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT, 10) || 5432,
  user: process.env.DB_USER || 'relax_user',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'knowledge_learning',
  max: 5,
  idle_timeout: 10,
  connect_timeout: 10,
})

// ---------------------------------------------------------------------------
// File resolution — single file or directory
// ---------------------------------------------------------------------------

function resolveFiles(inputPath) {
  const resolved = resolve(inputPath)
  const stat = statSync(resolved)

  if (stat.isDirectory()) {
    return readdirSync(resolved)
      .filter(f => ['.yaml', '.yml'].includes(extname(f).toLowerCase()))
      .sort()
      .map(f => join(resolved, f))
  }

  return [resolved]
}

// ---------------------------------------------------------------------------
// Import a single YAML file
// ---------------------------------------------------------------------------

async function importFile(filePath) {
  console.log(`\n✓ Importing: ${filePath}`)

  const raw = readFileSync(filePath, 'utf-8')
  const data = yaml.load(raw)

  if (!data || typeof data !== 'object') {
    console.error(`  ✗ Invalid YAML in ${filePath}`)
    return false
  }

  // Route to lesson or learning path handler
  if (data.type === 'learning_path') {
    return importLearningPath(data)
  }
  return importLesson(data)
}

// ---------------------------------------------------------------------------
// Import lesson
// ---------------------------------------------------------------------------

async function importLesson(data) {
  // 1. Validate
  const errors = validateLesson(data)
  if (errors.length > 0) {
    console.error('  ✗ Validation errors:')
    errors.forEach(e => console.error(`    - ${e}`))
    return false
  }

  if (dryRun) {
    console.log('  ✓ Validation passed — dry run, no changes made')
    return true
  }

  // 2. Lookup category
  const [category] = await sql`SELECT id FROM category WHERE name = ${data.category}`
  if (!category) {
    console.error(`  ✗ Category not found: "${data.category}"`)
    return false
  }
  console.log(`  ✓ Category found: "${data.category}" (id=${category.id})`)

  // 3. Transaction — upsert lesson + related data
  await sql.begin(async tx => {
    // 3a. Upsert lesson
    const [lesson] = await tx`
      INSERT INTO lesson (slug, group_id, name, name_vi, difficulty, estimated_time, order_index, is_published)
      VALUES (
        ${data.slug},
        ${category.id},
        ${data.name},
        ${data.name_vi},
        ${data.difficulty},
        ${data.estimated_time},
        ${data.order_index},
        ${data.is_published !== false}
      )
      ON CONFLICT (slug) DO UPDATE SET
        group_id       = EXCLUDED.group_id,
        name           = EXCLUDED.name,
        name_vi        = EXCLUDED.name_vi,
        difficulty     = EXCLUDED.difficulty,
        estimated_time = EXCLUDED.estimated_time,
        order_index    = EXCLUDED.order_index,
        is_published   = EXCLUDED.is_published
      RETURNING id
    `
    const lessonId = lesson.id
    console.log(`  ✓ Lesson upserted: "${data.slug}" (id=${lessonId})`)

    // 3b. Delete existing related data (simpler than upserting ordered data)
    await tx`DELETE FROM lesson_usage WHERE lesson_id = ${lessonId}`
    await tx`DELETE FROM lesson_section WHERE lesson_id = ${lessonId}`
    // Exercises cascade-delete exercise_options
    await tx`DELETE FROM exercise WHERE lesson_id = ${lessonId}`

    // 3c. Insert usages
    const usages = data.usages || []
    for (let i = 0; i < usages.length; i++) {
      const u = usages[i]
      await tx`
        INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index)
        VALUES (${lessonId}, ${u.title}, ${u.title_vi || null}, ${u.description}, ${u.description_vi || null}, ${i})
      `
    }

    // 3d. Insert sections
    const sections = data.sections || []
    for (let i = 0; i < sections.length; i++) {
      const s = sections[i]
      await tx`
        INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
        VALUES (
          ${lessonId},
          ${s.type},
          ${s.title || null},
          ${s.title_vi || null},
          ${s.content || null},
          ${s.content_vi || null},
          ${JSON.stringify(s.metadata || {})},
          ${i}
        )
      `
    }

    // 3e. Insert exercises + options
    const exercises = data.exercises || []
    for (let i = 0; i < exercises.length; i++) {
      const ex = exercises[i]
      const [inserted] = await tx`
        INSERT INTO exercise (
          lesson_id, type, difficulty, question, question_vi,
          correct_answer, word_bank, explanation, explanation_vi,
          points, time_limit, order_index, is_active
        )
        VALUES (
          ${lessonId},
          ${ex.type},
          ${ex.difficulty},
          ${ex.question},
          ${ex.question_vi || null},
          ${ex.correct_answer || null},
          ${ex.word_bank ? JSON.stringify(ex.word_bank) : null},
          ${ex.explanation || null},
          ${ex.explanation_vi || null},
          ${ex.points || 10},
          ${ex.time_limit || null},
          ${i},
          ${ex.is_active !== false}
        )
        RETURNING id
      `

      // Insert options for multiple_choice
      if (ex.type === 'multiple_choice' && Array.isArray(ex.options)) {
        const labels = ['A', 'B', 'C', 'D', 'E', 'F']
        for (let j = 0; j < ex.options.length; j++) {
          const opt = ex.options[j]
          await tx`
            INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
            VALUES (
              ${inserted.id},
              ${opt.label || labels[j]},
              ${opt.content},
              ${opt.content_vi || null},
              ${opt.is_correct === true},
              ${opt.explanation || null},
              ${opt.explanation_vi || null},
              ${j}
            )
          `
        }
      }
    }

    console.log(`  ✓ Inserted ${usages.length} usages, ${sections.length} sections, ${exercises.length} exercises`)
  })

  return true
}

// ---------------------------------------------------------------------------
// Import learning path
// ---------------------------------------------------------------------------

async function importLearningPath(data) {
  // 1. Validate
  const errors = validateLearningPath(data)
  if (errors.length > 0) {
    console.error('  ✗ Validation errors:')
    errors.forEach(e => console.error(`    - ${e}`))
    return false
  }

  if (dryRun) {
    console.log('  ✓ Validation passed — dry run, no changes made')
    return true
  }

  // 2. Transaction — upsert learning path + steps
  try {
    await sql.begin(async tx => {
      // 2a. Upsert learning path
      const [path] = await tx`
        INSERT INTO learning_path (slug, name, name_vi, description, description_vi, icon, color, estimated_days, is_featured, order_index)
        VALUES (
          ${data.slug},
          ${data.name},
          ${data.name_vi},
          ${data.description || null},
          ${data.description_vi || null},
          ${data.icon || null},
          ${data.color || '#6366f1'},
          ${data.estimated_days || null},
          ${data.is_featured === true},
          ${data.order_index || 0}
        )
        ON CONFLICT (slug) DO UPDATE SET
          name            = EXCLUDED.name,
          name_vi         = EXCLUDED.name_vi,
          description     = EXCLUDED.description,
          description_vi  = EXCLUDED.description_vi,
          icon            = EXCLUDED.icon,
          color           = EXCLUDED.color,
          estimated_days  = EXCLUDED.estimated_days,
          is_featured     = EXCLUDED.is_featured,
          order_index     = EXCLUDED.order_index
        RETURNING id
      `
      console.log(`  ✓ Learning path upserted: "${data.slug}" (id=${path.id})`)

      // 2b. Delete existing steps
      await tx`DELETE FROM learning_path_step WHERE path_id = ${path.id}`

      // 2c. Resolve lesson slugs and insert steps
      for (let i = 0; i < data.steps.length; i++) {
        const step = data.steps[i]
        const [lesson] = await tx`SELECT id FROM lesson WHERE slug = ${step.lesson}`
        if (!lesson) {
          throw new Error(`Lesson slug not found: "${step.lesson}" (step ${i})`)
        }
        await tx`
          INSERT INTO learning_path_step (path_id, lesson_id, order_index)
          VALUES (${path.id}, ${lesson.id}, ${i})
        `
      }

      console.log(`  ✓ Inserted ${data.steps.length} path steps`)
    })
  } catch (err) {
    // Check if the learning_path table doesn't exist yet
    if (err.code === '42P01') {
      console.error(`  ✗ Table "learning_path" does not exist. Run migration 021 first.`)
      console.error(`    Hint: Check database/migrations/ for the learning_path migration.`)
      return false
    }
    throw err
  }

  return true
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

async function main() {
  let allFiles = []
  for (const inputPath of filePaths) {
    try {
      allFiles.push(...resolveFiles(inputPath))
    } catch (err) {
      console.error(`✗ Cannot resolve path: ${inputPath} — ${err.message}`)
      process.exit(1)
    }
  }

  if (allFiles.length === 0) {
    console.error('✗ No .yaml/.yml files found')
    process.exit(1)
  }

  if (dryRun) {
    console.log(`[DRY RUN] Validating ${allFiles.length} file(s)...\n`)
  } else {
    console.log(`Importing ${allFiles.length} file(s)...\n`)
  }

  let success = 0
  let failed = 0

  for (const file of allFiles) {
    try {
      const ok = await importFile(file)
      if (ok) success++
      else failed++
    } catch (err) {
      console.error(`  ✗ Error: ${err.message}`)
      failed++
    }
  }

  console.log(`\n${'='.repeat(50)}`)
  if (dryRun) {
    console.log(`Dry run complete: ${success} valid, ${failed} invalid`)
  } else {
    console.log(`Import complete: ${success} succeeded, ${failed} failed`)
  }

  await sql.end()
  process.exit(failed > 0 ? 1 : 0)
}

main().catch(err => {
  console.error('Fatal error:', err)
  sql.end().finally(() => process.exit(1))
})
