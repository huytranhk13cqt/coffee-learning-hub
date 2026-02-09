export class LessonController {
  constructor(lessonRepo) {
    this.lessonRepo = lessonRepo;
  }

  // GET /api/lessons/search?q=keyword
  search = async (request) => {
    const q = request.query.q?.trim();
    if (!q || q.length > 128) return { data: [] };
    const lessons = await this.lessonRepo.search(q);
    return { data: lessons };
  };

  getBySlug = async (request) => {
    const lesson = await this.lessonRepo.findFullBySlug(request.params.slug);
    return { data: lesson };
  };

  getByGroup = async (request) => {
    const lessons = await this.lessonRepo.findByGroup(request.params.groupId);
    return { data: lessons };
  };
}
