import { tryExtractSessionId } from '../utils/session.js';

export class CategoryController {
  constructor(categoryRepo) {
    this.categoryRepo = categoryRepo;
  }

  getAll = async () => {
    const groups = await this.categoryRepo.findAllWithLessonCount();
    return { data: groups };
  };

  /** BFF: groups + lessons + progress in one round-trip. */
  getHomePage = async (request) => {
    const sessionId = tryExtractSessionId(request);
    const rows = await this.categoryRepo.findHomePageData(sessionId);

    // Group flat rows into nested { groups: [{ ...group, lessons: [...] }] }
    const groupMap = new Map();
    for (const row of rows) {
      if (!groupMap.has(row.group_id)) {
        groupMap.set(row.group_id, {
          id: row.group_id,
          name: row.group_name,
          name_vi: row.group_name_vi,
          color: row.group_color,
          lessons: [],
        });
      }
      // LEFT JOIN may produce a row with lesson_id=NULL for empty categories
      if (row.lesson_id) {
        groupMap.get(row.group_id).lessons.push({
          id: row.lesson_id,
          name: row.lesson_name,
          name_vi: row.lesson_name_vi,
          slug: row.lesson_slug,
          difficulty: row.lesson_difficulty,
          status: row.progress_status,
          best_score: row.best_score,
        });
      }
    }

    return { data: { groups: [...groupMap.values()] } };
  };
}
