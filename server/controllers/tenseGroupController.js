export class TenseGroupController {
  constructor(tenseGroupRepo) {
    this.tenseGroupRepo = tenseGroupRepo;
  }

  getAll = async (req, res, next) => {
    try {
      const groups = await this.tenseGroupRepo.findAllWithLessonCount();
      res.json({ data: groups });
    } catch (err) {
      next(err);
    }
  };
}
