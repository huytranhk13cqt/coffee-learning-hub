/**
 * Image Provider Registry — unified model catalog + provider lookup.
 *
 * Single source of truth for all image generation models across providers.
 * Frontend mirrors this list for display (model selector chips).
 */

// ─── Model Catalog ──────────────────────────────────────────

export const IMAGE_MODELS = {
  // ── Google Gemini ──
  'gemini-2.5-flash-image': {
    name: 'Nano Banana (Free)',
    provider: 'gemini',
    free: true,
    price: 'FREE',
  },
  'gemini-3.1-flash-image-preview': {
    name: 'Nano Banana 2',
    provider: 'gemini',
    free: false,
    price: '$0.067/img',
  },
  'imagen-4.0-fast-generate-001': {
    name: 'Imagen 4 Fast',
    provider: 'gemini',
    free: false,
    price: '$0.02/img',
  },
  'imagen-4.0-generate-001': {
    name: 'Imagen 4 Standard',
    provider: 'gemini',
    free: false,
    price: '$0.04/img',
  },
  'imagen-4.0-ultra-generate-001': {
    name: 'Imagen 4 Ultra',
    provider: 'gemini',
    free: false,
    price: '$0.06/img',
  },

  // ── OpenAI ──
  'gpt-image-1': {
    name: 'GPT Image 1',
    provider: 'openai',
    free: false,
    price: '$0.02–0.19/img',
  },
  'dall-e-3': {
    name: 'DALL-E 3',
    provider: 'openai',
    free: false,
    price: '$0.04–0.12/img',
  },

  // ── Stability AI ──
  'sd3.5-large': {
    name: 'SD 3.5 Large',
    provider: 'stability',
    free: false,
    price: '$0.065/img',
  },
  'sd3.5-medium': {
    name: 'SD 3.5 Medium',
    provider: 'stability',
    free: false,
    price: '$0.035/img',
  },
};

export const PROVIDER_NAMES = {
  gemini: 'Google Gemini',
  openai: 'OpenAI',
  stability: 'Stability AI',
};

// ─── Registry ───────────────────────────────────────────────

export class ImageProviderRegistry {
  #providers = new Map();

  register(name, service) {
    this.#providers.set(name, service);
  }

  getProvider(name) {
    return this.#providers.get(name) || null;
  }

  getProviderForModel(modelId) {
    const info = IMAGE_MODELS[modelId];
    if (!info) return null;
    return this.#providers.get(info.provider) || null;
  }

  getAllStatus() {
    const status = {};
    for (const [name, service] of this.#providers) {
      status[name] = {
        configured: service.isConfigured(),
        maskedKey: service.getMaskedKey(),
      };
    }
    return status;
  }

  getProviderNames() {
    return [...this.#providers.keys()];
  }
}
