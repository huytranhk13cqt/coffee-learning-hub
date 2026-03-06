import OpenAI from 'openai';

export class OpenAIImageService {
  #apiKey = null;
  #client = null;

  setApiKey(key) {
    this.#apiKey = key;
    this.#client = key ? new OpenAI({ apiKey: key }) : null;
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
   * Generate images using OpenAI's Images API.
   * Supports gpt-image-1 and dall-e-3.
   */
  async generate(model, prompt, config = {}) {
    if (!this.#client) throw new Error('OpenAI API key not configured');

    const params = {
      model,
      prompt,
      response_format: 'b64_json',
    };

    if (model === 'gpt-image-1') {
      params.size = config.size || '1024x1024';
      params.quality = config.quality || 'auto';
      params.n = Math.min(config.numberOfImages || 1, 4);
    } else {
      // dall-e-3: only n=1, sizes 1024x1024 / 1024x1792 / 1792x1024
      params.size = config.size || '1024x1024';
      params.quality = config.quality || 'standard';
      params.n = 1;
    }

    const response = await this.#client.images.generate(params);

    return {
      images: response.data.map((img) => ({
        data: img.b64_json,
        mimeType: 'image/png',
      })),
      text: '',
    };
  }
}
