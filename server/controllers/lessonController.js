export class LessonController {
  constructor(lessonRepo) {
    this.lessonRepo = lessonRepo;
  }

  getBySlug = async (req, res, next) => {
    try {
      const lesson = await this.lessonRepo.findFullBySlug(req.params.slug);
      res.json({ data: lesson });
    } catch (err) {
      next(err);
    }
  };

  getByGroup = async (req, res, next) => {
    try {
      const lessons = await this.lessonRepo.findByGroup(req.params.groupId);
      res.json({ data: lessons });
    } catch (err) {
      next(err);
    }
  };
}
