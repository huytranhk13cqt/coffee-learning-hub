// ═══════════════════════════════════════════════════════════
// Pixel Art Utility Library
// CSS-only techniques for pixel-perfect retro UI
// ═══════════════════════════════════════════════════════════

// ── Font Stacks ────────────────────────────────────────────
// Hierarchy: Silkscreen (headings/UI chrome) → VT323 (body/data)
//            → Inter/system (lesson content, long reading)

export const FONT = {
  pixel: '"Silkscreen", cursive',
  mono: '"VT323", "Courier New", monospace',
  reading:
    '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
  display: '"Press Start 2P", "Silkscreen", cursive',
};

// ── Pixel Border via box-shadow ────────────────────────────
// Multi-layer box-shadow creates a crisp pixel border without
// rounding or anti-aliasing. Classic technique from retro CSS.

export function pixelBorder(color, size = 2) {
  return `
    ${size}px 0 0 0 ${color},
    -${size}px 0 0 0 ${color},
    0 ${size}px 0 0 ${color},
    0 -${size}px 0 0 ${color}
  `.trim();
}

// Corner-filled pixel border (8-directional) — no gap at corners
export function pixelBorderFull(color, size = 2) {
  return `
    ${size}px 0 0 0 ${color},
    -${size}px 0 0 0 ${color},
    0 ${size}px 0 0 ${color},
    0 -${size}px 0 0 ${color},
    ${size}px ${size}px 0 0 ${color},
    -${size}px ${size}px 0 0 ${color},
    ${size}px -${size}px 0 0 ${color},
    -${size}px -${size}px 0 0 ${color}
  `.trim();
}

// Pixel inset shadow (pressed state)
export function pixelInset(color, size = 2) {
  return `inset ${size}px ${size}px 0 0 ${color}`;
}

// ── Pixel Drop Shadow ──────────────────────────────────────
// Classic pixel art offset shadow — sharp, no blur

export function pixelDropShadow(color = 'rgba(0,0,0,0.15)', offset = 3) {
  return `${offset}px ${offset}px 0 0 ${color}`;
}

// ── Dithering Patterns ─────────────────────────────────────
// CSS background-image patterns that simulate pixel dithering

export const DITHER = {
  // Subtle dot grid (4px spacing)
  dots: {
    light: 'radial-gradient(circle, rgba(44,42,53,0.04) 1px, transparent 1px)',
    dark: 'radial-gradient(circle, rgba(232,228,220,0.025) 1px, transparent 1px)',
    size: '4px 4px',
  },

  // Crosshatch pattern (8px spacing)
  crosshatch: {
    light: `repeating-linear-gradient(
      45deg,
      transparent,
      transparent 3px,
      rgba(44,42,53,0.03) 3px,
      rgba(44,42,53,0.03) 4px
    )`,
    dark: `repeating-linear-gradient(
      45deg,
      transparent,
      transparent 3px,
      rgba(232,228,220,0.02) 3px,
      rgba(232,228,220,0.02) 4px
    )`,
    size: 'auto',
  },

  // Scanline overlay
  scanlines: {
    light:
      'repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(44,42,53,0.015) 2px, rgba(44,42,53,0.015) 4px)',
    dark: 'repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(232,228,220,0.01) 2px, rgba(232,228,220,0.01) 4px)',
    size: 'auto',
  },
};

// ── Animation Timing ───────────────────────────────────────
// steps() creates frame-by-frame animation — the pixel art way.
// Smooth easing looks wrong in pixel contexts.

export const TIMING = {
  // UI interactions — snappy pixel response
  press: 'steps(2, end) 0.1s',
  hover: 'steps(3, end) 0.15s',
  focus: 'steps(4, end) 0.2s',

  // Transitions — subtle pixel stepping
  short: 'steps(4, end) 0.2s',
  medium: 'steps(6, end) 0.3s',
  long: 'steps(8, end) 0.5s',

  // Idle animations — slower, atmospheric
  idle: 'steps(4, end) 1s infinite',
  breathe: 'steps(8, end) 2s ease-in-out infinite alternate',
  float: 'steps(6, end) 3s ease-in-out infinite alternate',

  // Page transitions
  pageIn: 'steps(5, end) 0.25s',
  pageOut: 'steps(3, end) 0.15s',
};

// ── Keyframes (as CSS strings for sx injection) ────────────

export const KEYFRAMES = {
  pixelFadeIn: {
    '@keyframes pixelFadeIn': {
      '0%': { opacity: 0, transform: 'translateY(4px)' },
      '50%': { opacity: 0.5, transform: 'translateY(2px)' },
      '100%': { opacity: 1, transform: 'translateY(0)' },
    },
  },
  pixelPulse: {
    '@keyframes pixelPulse': {
      '0%, 100%': { opacity: 1 },
      '50%': { opacity: 0.7 },
    },
  },
  pixelBounce: {
    '@keyframes pixelBounce': {
      '0%, 100%': { transform: 'translateY(0)' },
      '50%': { transform: 'translateY(-3px)' },
    },
  },
  pixelShimmer: {
    '@keyframes pixelShimmer': {
      '0%': { backgroundPosition: '-200% 0' },
      '100%': { backgroundPosition: '200% 0' },
    },
  },

  // ── Commit 9: Entrance & idle animations ──────────────
  pixelSlideUp: {
    '@keyframes pixelSlideUp': {
      '0%': { opacity: 0, transform: 'translateY(8px)' },
      '33%': { opacity: 0.5, transform: 'translateY(4px)' },
      '66%': { opacity: 0.85, transform: 'translateY(2px)' },
      '100%': { opacity: 1, transform: 'translateY(0)' },
    },
  },
  pixelScaleIn: {
    '@keyframes pixelScaleIn': {
      '0%': { opacity: 0, transform: 'scale(0.85)' },
      '50%': { opacity: 0.8, transform: 'scale(1.03)' },
      '100%': { opacity: 1, transform: 'scale(1)' },
    },
  },
  pixelFloat: {
    '@keyframes pixelFloat': {
      '0%, 100%': { transform: 'translateY(0)' },
      '50%': { transform: 'translateY(-4px)' },
    },
  },
  pixelGlowPulse: {
    '@keyframes pixelGlowPulse': {
      '0%, 100%': { filter: 'brightness(1)' },
      '50%': { filter: 'brightness(1.15)' },
    },
  },
};

// ── Animation Presets ────────────────────────────────────
// Ready-to-spread sx objects. Each includes keyframe + animation property.
// Usage: sx={{ ...ANIMATION.fadeIn }}
//        sx={{ ...ANIMATION.stagger(2) }}

export const ANIMATION = {
  // Entrances — play once on mount
  fadeIn: {
    ...KEYFRAMES.pixelFadeIn,
    animation: 'pixelFadeIn 0.3s steps(5, end) both',
  },
  slideUp: {
    ...KEYFRAMES.pixelSlideUp,
    animation: 'pixelSlideUp 0.3s steps(4, end) both',
  },
  scaleIn: {
    ...KEYFRAMES.pixelScaleIn,
    animation: 'pixelScaleIn 0.3s steps(4, end) both',
  },

  // Idle loops — continuous atmospheric motion
  float: {
    ...KEYFRAMES.pixelFloat,
    animation: 'pixelFloat 3s steps(6, end) infinite alternate',
  },
  pulse: {
    ...KEYFRAMES.pixelPulse,
    animation: 'pixelPulse 2s steps(8, end) infinite alternate',
  },
  bounce: {
    ...KEYFRAMES.pixelBounce,
    animation: 'pixelBounce 2s steps(6, end) infinite alternate',
  },
  glowPulse: {
    ...KEYFRAMES.pixelGlowPulse,
    animation: 'pixelGlowPulse 2s steps(8, end) infinite alternate',
  },

  // Stagger helper — cascading list entrance
  stagger(index, gap = 60) {
    return {
      ...KEYFRAMES.pixelFadeIn,
      animation: 'pixelFadeIn 0.3s steps(5, end) both',
      animationDelay: `${index * gap}ms`,
    };
  },
};

// ── Glow Effects ───────────────────────────────────────────
// Warm, soft glows for interactive elements

export function pixelGlow(color, intensity = 0.4) {
  return `0 0 ${8 * intensity}px ${color}, 0 0 ${16 * intensity}px ${color}`;
}

// ── Shadow Ramp (pixel-tinted) ─────────────────────────────
// 25 levels to satisfy MUI's shadow array requirement
// Tinted with warm indigo for cohesion with COZY palette

export const pixelShadows = [
  'none',
  '0 1px 2px rgba(91,82,163,0.08)',
  '0 2px 4px rgba(91,82,163,0.10)',
  '0 3px 6px rgba(91,82,163,0.12)',
  '0 4px 8px rgba(91,82,163,0.14)',
  '0 6px 12px rgba(91,82,163,0.16)',
  ...Array(19).fill('0 8px 16px rgba(91,82,163,0.18)'),
];
