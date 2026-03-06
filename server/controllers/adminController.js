export class AdminController {
  constructor(adminRepo) {
    this.adminRepo = adminRepo;
  }

  /** GET /api/admin/stats — aggregate counts + exercise type breakdown */
  getStats = async () => {
    const [stats, exerciseTypes] = await Promise.all([
      this.adminRepo.getStats(),
      this.adminRepo.getExerciseTypeBreakdown(),
    ]);

    // Convert exercise type rows to object
    const exercise_types = {};
    for (const row of exerciseTypes) {
      exercise_types[row.type] = row.count;
    }

    return { data: { ...stats, exercise_types } };
  };

  /** GET /api/admin/activity — recent content changes */
  getActivity = async (request) => {
    const limit = Math.min(parseInt(request.query.limit, 10) || 20, 100);
    const data = await this.adminRepo.getRecentActivity(limit);
    return { data };
  };

  /** GET /api/admin/content-health — orphans + health score */
  getContentHealth = async () => {
    const [
      lessons_without_exercises,
      lessons_without_sections,
      categories_without_lessons,
      topics_without_categories,
      unpublished_lessons,
    ] = await Promise.all([
      this.adminRepo.getLessonsWithoutExercises(),
      this.adminRepo.getLessonsWithoutSections(),
      this.adminRepo.getCategoriesWithoutLessons(),
      this.adminRepo.getTopicsWithoutCategories(),
      this.adminRepo.getUnpublishedLessons(),
    ]);

    const total_issues =
      lessons_without_exercises.length +
      lessons_without_sections.length +
      categories_without_lessons.length +
      topics_without_categories.length +
      unpublished_lessons.length;

    const level =
      total_issues === 0
        ? 'healthy'
        : total_issues <= 5
          ? 'warning'
          : 'critical';

    return {
      data: {
        lessons_without_exercises,
        lessons_without_sections,
        categories_without_lessons,
        topics_without_categories,
        unpublished_lessons,
        score: { total_issues, level },
      },
    };
  };

  /** GET /api/admin/drafts — incomplete lessons */
  getDrafts = async () => {
    const data = await this.adminRepo.getDrafts();
    return { data };
  };

  /** GET /api/admin/content-breakdown — type distributions */
  getContentBreakdown = async () => {
    const [exercises_by_type, sections_by_type, lessons_per_category] =
      await Promise.all([
        this.adminRepo.getExerciseTypeBreakdown(),
        this.adminRepo.getSectionTypeBreakdown(),
        this.adminRepo.getLessonsPerCategory(),
      ]);

    return {
      data: { exercises_by_type, sections_by_type, lessons_per_category },
    };
  };

  /** GET /api/admin/activity-log — paginated action logs */
  listActionLogs = async (request) => {
    const page = parseInt(request.query.page, 10) || 1;
    const pageSize = [25, 50, 100].includes(
      parseInt(request.query.pageSize, 10),
    )
      ? parseInt(request.query.pageSize, 10)
      : 25;
    const action = request.query.action || null;
    const entityType = request.query.entityType || null;
    const from = request.query.from || null;
    const to = request.query.to || null;
    const search = request.query.search?.trim() || null;

    const filters = { action, entityType, from, to, search };
    const [data, total] = await Promise.all([
      this.adminRepo.findActionLogs({ page, pageSize, ...filters }),
      this.adminRepo.countActionLogs(filters),
    ]);

    return {
      data,
      pagination: {
        page,
        pageSize,
        total,
        totalPages: Math.ceil(total / pageSize),
      },
    };
  };

  /** GET /api/admin/review-stats — aggregate SM-2 stats */
  getReviewStats = async () => {
    const data = await this.adminRepo.getReviewAggregateStats();
    return { data };
  };

  /** GET /api/admin/weak-spots-aggregate — cross-session weak spots */
  getWeakSpots = async (request) => {
    const minAttempts = parseInt(request.query.minAttempts, 10) || 5;
    const type = request.query.type || null;
    const lessonId = request.query.lessonId
      ? parseInt(request.query.lessonId, 10)
      : null;
    const categoryId = request.query.categoryId
      ? parseInt(request.query.categoryId, 10)
      : null;
    const limit = parseInt(request.query.limit, 10) || 50;
    const data = await this.adminRepo.getWeakSpotsAggregate({
      minAttempts,
      type,
      lessonId,
      categoryId,
      limit,
    });
    return { data };
  };
}
