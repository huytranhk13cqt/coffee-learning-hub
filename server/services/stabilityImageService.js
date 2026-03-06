const STABILITY_BASE =
  'https://api.stability.ai/v2beta/stable-image/generate/sd3';

export class StabilityImageService {
  #apiKey = null;

  setApiKey(key) {
    this.#apiKey = key;
  }

  removeApiKey() {
    this.#apiKey = null;
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
   * Generate images using Stability AI's SD3 REST API.
   * Models: sd3.5-large, sd3.5-medium.
   * Only 1 image per request (API limitation).
   */
  async generate(model, prompt, config = {}) {
    if (!this.#apiKey) throw new Error('Stability AI API key not configured');

    const formData = new FormData();
    formData.append('prompt', prompt);
    formData.append('model', model);
    formData.append('output_format', 'png');

    if (config.aspectRatio) {
      formData.append('aspect_ratio', config.aspectRatio);
    }
    if (config.negativePrompt) {
      formData.append('negative_prompt', config.negativePrompt);
    }

    const response = await fetch(STABILITY_BASE, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${this.#apiKey}`,
        Accept: 'application/json',
      },
      body: formData,
    });

    if (!response.ok) {
      const body = await response.json().catch(() => ({}));
      const msg =
        body.message || body.name || `Stability API error ${response.status}`;
      throw new Error(msg);
    }

    const data = await response.json();

    return {
      images: [
        {
          data: data.image,
          mimeType: 'image/png',
        },
      ],
      text: '',
    };
  }
}
