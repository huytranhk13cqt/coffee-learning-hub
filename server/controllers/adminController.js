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
}
