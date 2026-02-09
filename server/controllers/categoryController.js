export class CategoryController {
  constructor(categoryRepo) {
    this.categoryRepo = categoryRepo;
  }

  getAll = async () => {
    const groups = await this.categoryRepo.findAllWithLessonCount();
    return { data: groups };
  };
}
