// Exercises by lesson: GET /api/lessons/:lessonId/exercises, GET /api/lessons/:lessonId/results
export function lessonExerciseRoutes(controller) {
  return async function (fastify) {
    fastify.get('/:lessonId/exercises', controller.getByLesson);
    fastify.get('/:lessonId/results', controller.getResults);
  };
}

// Submit answer: POST /api/exercises/:exerciseId/submit
export function exerciseSubmitRoutes(controller) {
  return async function (fastify) {
    fastify.post('/:exerciseId/submit', controller.submit);
  };
}
