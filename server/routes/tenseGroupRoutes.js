import { Router } from 'express';

export function createTenseGroupRoutes(controller) {
  const router = Router();

  router.get('/', controller.getAll);

  return router;
}
