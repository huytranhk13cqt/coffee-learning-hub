import { GoogleGenAI } from '@google/genai';

const GEMINI_MODELS = {
  'gemini-2.5-flash-image': {
    name: 'Nano Banana (Free)',
    type: 'gemini',
    free: true,
  },
  'gemini-3.1-flash-image-preview': {
    name: 'Nano Banana 2',
    type: 'gemini',
    free: false,
  },
  'imagen-4.0-fast-generate-001': {
    name: 'Imagen 4 Fast',
    type: 'imagen',
    free: false,
  },
  'imagen-4.0-generate-001': {
    name: 'Imagen 4 Standard',
    type: 'imagen',
    free: false,
  },
  'imagen-4.0-ultra-generate-001': {
    name: 'Imagen 4 Ultra',
    type: 'imagen',
    free: false,
  },
};

export { GEMINI_MODELS };

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
    const modelInfo = GEMINI_MODELS[model];
    if (!modelInfo) throw new Error(`Unknown model: ${model}`);

    if (modelInfo.type === 'imagen') {
      return this.generateWithImagen(model, prompt, config);
    }
    return this.generateWithGemini(model, prompt, config);
  }
}
