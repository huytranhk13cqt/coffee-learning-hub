export class LessonController {
  constructor(lessonRepo) {
    this.lessonRepo = lessonRepo;
  }

  getBySlug = async (request) => {
    const lesson = await this.lessonRepo.findFullBySlug(request.params.slug);
    return { data: lesson };
  };

  getByGroup = async (request) => {
    const lessons = await this.lessonRepo.findByGroup(request.params.groupId);
    return { data: lessons };
  };
}
