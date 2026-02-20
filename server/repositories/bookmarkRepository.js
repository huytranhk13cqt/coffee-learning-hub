export function bookmarkRepository(sql) {
  return {
    async getBySession(sessionId) {
      return sql`
        SELECT 
          b.id as bookmark_id,
          b.lesson_id,
          b.section_type,
          b.section_id,
          b.note,
          b.created_at,
          l.name_vi as lesson_name_vi,
          l.slug as lesson_slug,
          g.name_vi as group_name_vi,
          g.color as group_color
        FROM bookmark b
        JOIN lesson l ON b.lesson_id = l.id
        JOIN tense_group g ON l.group_id = g.id
        WHERE b.session_id = ${sessionId}
        ORDER BY b.created_at DESC
      `;
    },

    async check(sessionId, lessonId, sectionType = null, sectionId = null) {
      const results = await sql`
        SELECT id FROM bookmark
        WHERE session_id = ${sessionId}
          AND lesson_id = ${lessonId}
          AND (section_type = ${sectionType} OR (${sectionType} IS NULL AND section_type IS NULL))
          AND (section_id = ${sectionId} OR (${sectionId} IS NULL AND section_id IS NULL))
        LIMIT 1
      `;
      return results.length > 0;
    },

    async add(
      sessionId,
      lessonId,
      sectionType = null,
      sectionId = null,
      note = null,
    ) {
      return sql`
        INSERT INTO bookmark (session_id, lesson_id, section_type, section_id, note)
        VALUES (${sessionId}, ${lessonId}, ${sectionType}, ${sectionId}, ${note})
        ON CONFLICT (session_id, lesson_id, section_type, section_id) 
        DO UPDATE SET note = EXCLUDED.note
        RETURNING id
      `;
    },

    async remove(sessionId, lessonId, sectionType = null, sectionId = null) {
      return sql`
        DELETE FROM bookmark
        WHERE session_id = ${sessionId}
          AND lesson_id = ${lessonId}
          AND (section_type = ${sectionType} OR (${sectionType} IS NULL AND section_type IS NULL))
          AND (section_id = ${sectionId} OR (${sectionId} IS NULL AND section_id IS NULL))
      `;
    },

    async removeById(sessionId, id) {
      return sql`
        DELETE FROM bookmark
        WHERE id = ${id} AND session_id = ${sessionId}
      `;
    },
  };
}
