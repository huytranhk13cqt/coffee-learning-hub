import { tryExtractSessionId } from '../utils/session.js';

export class CategoryController {
  constructor(categoryRepo) {
    this.categoryRepo = categoryRepo;
  }

  getAll = async () => {
    const groups = await this.categoryRepo.findAllWithLessonCount();
    return { data: groups };
  };

  /**
   * BFF: topics → groups → lessons → progress in one round-trip.
   *
   * Flat SQL rows are reshaped into a 3-level nested structure:
   *   { topics: [{ id, name, ..., groups: [{ id, name, ..., lessons: [...] }] }] }
   *
   * Categories without a topic_id are grouped under a synthetic "Other" topic at the end.
   */
  getHomePage = async (request) => {
    const sessionId = tryExtractSessionId(request);
    const rows = await this.categoryRepo.findHomePageData(sessionId);

    // Two-pass grouping: topic → group → lesson using Maps for O(1) lookups
    const topicMap = new Map();

    for (const row of rows) {
      const topicKey = row.topic_id ?? 0;

      if (!topicMap.has(topicKey)) {
        topicMap.set(topicKey, {
          id: row.topic_id,
          name: row.topic_name ?? 'Other',
          name_vi: row.topic_name_vi ?? 'Khác',
          icon: row.topic_icon,
          color: row.topic_color ?? '#78716c',
          _groups: new Map(),
        });
      }

      const topic = topicMap.get(topicKey);

      if (!topic._groups.has(row.group_id)) {
        topic._groups.set(row.group_id, {
          id: row.group_id,
          name: row.group_name,
          name_vi: row.group_name_vi,
          color: row.group_color,
          lessons: [],
        });
      }

      // LEFT JOIN may produce a row with lesson_id=NULL for empty categories
      if (row.lesson_id) {
        topic._groups.get(row.group_id).lessons.push({
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

    // Convert internal Maps to arrays for JSON serialization
    const topics = [...topicMap.values()].map(({ _groups, ...topic }) => ({
      ...topic,
      groups: [..._groups.values()],
    }));

    return { data: { topics } };
  };
}
