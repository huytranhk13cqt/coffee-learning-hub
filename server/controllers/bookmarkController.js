export function bookmarkController(repository) {
  return {
    async getAll(request, reply) {
      const sessionId = request.headers['x-session-id'];
      if (!sessionId)
        return reply.status(400).send({ error: 'Missing Session ID' });

      const bookmarks = await repository.getBySession(sessionId);
      return bookmarks;
    },

    async add(request, reply) {
      const sessionId = request.headers['x-session-id'];
      if (!sessionId)
        return reply.status(400).send({ error: 'Missing Session ID' });

      const { lessonId, sectionType, sectionId, note } = request.body;
      if (!lessonId)
        return reply.status(400).send({ error: 'Missing Lesson ID' });

      const result = await repository.add(
        sessionId,
        lessonId,
        sectionType,
        sectionId,
        note,
      );
      return reply.status(201).send(result[0]);
    },

    async remove(request, reply) {
      const sessionId = request.headers['x-session-id'];
      if (!sessionId)
        return reply.status(400).send({ error: 'Missing Session ID' });

      const { lessonId, sectionType, sectionId } = request.query;
      if (!lessonId)
        return reply.status(400).send({ error: 'Missing Lesson ID' });

      await repository.remove(
        sessionId,
        parseInt(lessonId),
        sectionType || null,
        sectionId ? parseInt(sectionId) : null,
      );
      return reply.status(204).send();
    },

    async removeById(request, reply) {
      const sessionId = request.headers['x-session-id'];
      if (!sessionId)
        return reply.status(400).send({ error: 'Missing Session ID' });

      const { id } = request.params;
      await repository.removeById(sessionId, parseInt(id));
      return reply.status(204).send();
    },

    async check(request, reply) {
      const sessionId = request.headers['x-session-id'];
      if (!sessionId)
        return reply.status(400).send({ error: 'Missing Session ID' });

      const { lessonId, sectionType, sectionId } = request.query;
      if (!lessonId)
        return reply.status(400).send({ error: 'Missing Lesson ID' });

      const isBookmarked = await repository.check(
        sessionId,
        parseInt(lessonId),
        sectionType || null,
        sectionId ? parseInt(sectionId) : null,
      );
      return { isBookmarked };
    },
  };
}
