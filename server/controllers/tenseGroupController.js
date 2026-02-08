export class TenseGroupController {
  constructor(tenseGroupRepo) {
    this.tenseGroupRepo = tenseGroupRepo;
  }

  getAll = async () => {
    const groups = await this.tenseGroupRepo.findAllWithLessonCount();
    return { data: groups };
  };
}
