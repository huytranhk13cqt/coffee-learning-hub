import { GoogleGenAI } from '@google/genai';

// Internal routing map: which Gemini sub-API to use per model
const GEMINI_TYPE = {
  'gemini-2.5-flash-image': 'gemini',
  'gemini-3.1-flash-image-preview': 'gemini',
  'imagen-4.0-fast-generate-001': 'imagen',
  'imagen-4.0-generate-001': 'imagen',
  'imagen-4.0-ultra-generate-001': 'imagen',
};

export class GeminiService {
  #apiKey = null;
  #client = null;

  setApiKey(key) {
    this.#apiKey = key;
    this.#client = key ? new GoogleGenAI({ apiKey: key }) : null;
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
   * Generate images using Gemini (Nano Banana) models.
   * These models return inline images alongside text via generateContent.
   */
  async generateWithGemini(model, prompt, config = {}) {
    if (!this.#client) throw new Error('Gemini API key not configured');

    const response = await this.#client.models.generateContent({
      model,
      contents: prompt,
      config: {
        responseModalities: ['TEXT', 'IMAGE'],
        ...(config.aspectRatio && {
          imageConfig: {
            aspectRatio: config.aspectRatio,
          },
        }),
      },
    });

    const images = [];
    const textParts = [];

    for (const part of response.candidates[0].content.parts) {
      if (part.inlineData) {
        images.push({
          data: part.inlineData.data,
          mimeType: part.inlineData.mimeType || 'image/png',
        });
      } else if (part.text) {
        textParts.push(part.text);
      }
    }

    return { images, text: textParts.join('\n') };
  }

  /**
   * Generate images using Imagen models.
   * These models use the dedicated generateImages API.
   */
  async generateWithImagen(model, prompt, config = {}) {
    if (!this.#client) throw new Error('Gemini API key not configured');

    const response = await this.#client.models.generateImages({
      model,
      prompt,
      config: {
        numberOfImages: config.numberOfImages || 1,
        aspectRatio: config.aspectRatio || '1:1',
      },
    });

    return {
      images: response.generatedImages.map((img) => ({
        data: img.image.imageBytes,
        mimeType: 'image/png',
      })),
      text: '',
    };
  }

  /**
   * Unified generate method — routes to the correct API based on model name.
   */
  async generate(model, prompt, config = {}) {
    const type = GEMINI_TYPE[model];
    if (!type) throw new Error(`Unknown Gemini model: ${model}`);

    if (type === 'imagen') {
      return this.generateWithImagen(model, prompt, config);
    }
    return this.generateWithGemini(model, prompt, config);
  }
}
