import Anthropic from '@anthropic-ai/sdk';

export class ClaudeService {
  #apiKey = null;
  #client = null;

  setApiKey(key) {
    this.#apiKey = key;
    this.#client = key ? new Anthropic({ apiKey: key }) : null;
  }

  removeApiKey() {
    this.#apiKey = null;
    this.#client = null;
  }

  isConfigured() {
    return !!this.#apiKey;
  }

  getMaskedKey() {
    if (!this.#apiKey) return null;
    const k = this.#apiKey;
    return k.slice(0, 6) + '...' + k.slice(-4);
  }

  /**
   * Stream a message from Claude API.
   * Async generator yielding SSE-style events.
   *
   * @param {Object} params
   * @param {string} params.model
   * @param {string} params.prompt
   * @param {string} [params.systemPrompt]
   * @param {boolean} [params.thinking]
   * @param {boolean} [params.webSearch]
   * @param {number} [params.maxTokens]
   */
  async *streamGenerate({
    model,
    prompt,
    systemPrompt,
    thinking,
    webSearch,
    maxTokens = 4096,
  }) {
    if (!this.#client) throw new Error('API key not configured');

    const messages = [{ role: 'user', content: prompt }];
    const params = { model, messages, max_tokens: maxTokens };

    if (systemPrompt) {
      params.system = systemPrompt;
    }

    // Model-specific thinking configuration
    if (thinking) {
      if (model === 'claude-haiku-4-5-20251001') {
        params.thinking = {
          type: 'enabled',
          budget_tokens: Math.min(maxTokens * 2, 10000),
        };
      } else {
        // Opus 4.6 and Sonnet 4.6 both support adaptive
        params.thinking = { type: 'adaptive' };
      }
    }

    // Web search tool
    if (webSearch) {
      params.tools = [{ type: 'web_search_20250305', name: 'web_search' }];
    }

    const stream = await this.#client.messages.create({
      ...params,
      stream: true,
    });

    for await (const event of stream) {
      if (event.type === 'content_block_start') {
        const block = event.content_block;
        if (block.type === 'thinking') {
          yield { event: 'thinking_start', data: {} };
        } else if (block.type === 'text') {
          yield { event: 'text_start', data: {} };
        }
      }

      if (event.type === 'content_block_delta') {
        const delta = event.delta;
        if (delta.type === 'thinking_delta') {
          yield { event: 'thinking', data: { text: delta.thinking } };
        } else if (delta.type === 'text_delta') {
          yield { event: 'text', data: { text: delta.text } };
        }
      }

      if (event.type === 'message_delta') {
        yield {
          event: 'done',
          data: { stop_reason: event.delta?.stop_reason },
        };
      }

      if (event.type === 'message_start') {
        const usage = event.message?.usage;
        if (usage) {
          yield { event: 'usage', data: usage };
        }
      }
    }
  }
}
