import { Router } from 'express';

export function createLessonRoutes(controller) {
  const router = Router();

  router.get('/:slug', controller.getBySlug);

  return router;
}

export function createGroupLessonRoutes(controller) {
  const router = Router();

  router.get('/:groupId/lessons', controller.getByGroup);

  return router;
}
