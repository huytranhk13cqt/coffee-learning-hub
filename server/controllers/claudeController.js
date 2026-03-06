import { ValidationError } from '../errors/AppError.js';

const ALLOWED_MODELS = [
  'claude-opus-4-6',
  'claude-sonnet-4-6',
  'claude-haiku-4-5-20251001',
];

export class ClaudeController {
  constructor(claudeService, adminRepo) {
    this.claudeService = claudeService;
    this.adminRepo = adminRepo;
  }

  generate = async (request, reply) => {
    if (!this.claudeService.isConfigured()) {
      throw new ValidationError(
        'Claude API key not configured. Set it in Settings.',
      );
    }

    const { model, prompt, systemPrompt, thinking, webSearch, maxTokens } =
      request.body;

    if (!ALLOWED_MODELS.includes(model)) {
      throw new ValidationError(
        `Invalid model. Must be one of: ${ALLOWED_MODELS.join(', ')}`,
      );
    }
    if (!prompt?.trim()) {
      throw new ValidationError('prompt is required');
    }

    // Take over the response for SSE streaming
    reply.hijack();

    reply.raw.writeHead(200, {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      Connection: 'keep-alive',
      'X-Accel-Buffering': 'no',
    });

    try {
      for await (const chunk of this.claudeService.streamGenerate({
        model,
        prompt: prompt.trim(),
        systemPrompt: systemPrompt?.trim() || undefined,
        thinking: !!thinking,
        webSearch: !!webSearch,
        maxTokens: maxTokens || 4096,
      })) {
        reply.raw.write(
          `event: ${chunk.event}\ndata: ${JSON.stringify(chunk.data)}\n\n`,
        );
      }
    } catch (err) {
      reply.raw.write(
        `event: error\ndata: ${JSON.stringify({
          error: err.message,
          type: err.error?.type || 'server_error',
        })}\n\n`,
      );
    }

    reply.raw.end();

    // Fire-and-forget audit log
    this.adminRepo.logAction({
      action: 'generate',
      entityType: 'content',
      metadata: { model, thinking: !!thinking, webSearch: !!webSearch },
      ipAddress: request.ip,
    });
  };
}
