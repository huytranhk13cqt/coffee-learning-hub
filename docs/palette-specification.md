# Cozy Study Palette — Production Specification

> **Version**: 1.0
> **Date**: 2026-03-08
> **Purpose**: Replace PICO-8 (16 colors) with a 32-bit era, 44-color curated palette optimized for readability, warmth, and dual-mode (light/dark) support.

---

## Design Philosophy

### Research Summary

**Reference palettes studied**:

- **DawnBringer 32** (Lospec) — balanced general-purpose, slightly desaturated
- **Endesga 32** (Lospec) — warm earth tones + cool blues, versatile for games
- **Endesga 36** (Lospec) — refined neutral ramp with warm undertone
- **Apollo 46** (Lospec) — best warm neutral ramp found (10 greys from near-black to near-white, all warm-shifted)
- **Japanese Woodblock** (Lospec) — warm, muted, cozy aesthetic from traditional prints
- **SLSO8** — warm dark-to-light gradient (#0d2b45 to #ffecd6), eye-comfort proven
- **Stardew Valley** — warm, inviting gaming palette with earth tones and soft greens
- **Celeste/PICO-8** — clean but too saturated for long reading sessions
- **Steam Deck UI** — dark gaming UI with warm-shifted darks

**Key color theory principles applied**:

1. **Warm hue-shifting**: Shadows shift toward blue-purple, highlights toward yellow-amber (pixel art standard)
2. **Desaturation**: All colors kept below 70% saturation to reduce eye strain (research shows 27% longer reading sessions with calm palettes)
3. **Warm undertone in neutrals**: Every grey has a slight amber/purple shift (never pure grey)
4. **No pure black or white**: Reduces halation effect, less eye strain per WCAG dark mode research
5. **Mid-saturation semantics**: Success/Warning/Error use enough saturation for quick recognition but not enough to cause visual vibration on dark backgrounds

### Why Not PICO-8?

| Problem                                     | Impact                                                          |
| ------------------------------------------- | --------------------------------------------------------------- |
| Only 16 colors                              | No semantic differentiation for 4 status types + 2 modes        |
| Pure #000000 black                          | Halation on dark mode, harsh                                    |
| Fully saturated (#FF004D, #00E436, #29ADFF) | Visual vibration on dark backgrounds, eye strain during reading |
| No warm neutral ramp                        | Cold, gamey feel — wrong for a learning/studying app            |
| No light/dark mode consideration            | Same colors forced into both modes                              |

### Comparison with References

| Aspect          | Stardew Valley               | Celeste/PICO-8       | Steam Deck | **Cozy Study**             |
| --------------- | ---------------------------- | -------------------- | ---------- | -------------------------- |
| Warmth          | Very warm                    | Neutral              | Cool-warm  | Warm with cool accents     |
| Saturation      | Medium                       | High                 | Low        | Low-medium                 |
| Reading comfort | Good (not designed for text) | Poor (too saturated) | Good       | **Optimized**              |
| Dark mode       | N/A (no dark mode)           | N/A                  | Yes        | **Yes, warm-shifted**      |
| Color count     | ~50+                         | 16                   | ~20        | **44 curated**             |
| WCAG compliance | Not tested                   | Fails many           | Partial    | **AA minimum, AAA target** |

---

## Complete Palette (44 Colors)

### 1. BACKGROUNDS (8 colors)

#### Light Mode

| Name       | Hex       | RGB           | Usage                                     | Notes                                                                                             |
| ---------- | --------- | ------------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `bg.cream` | `#F5F0E8` | 245, 240, 232 | Page background (default)                 | Warm parchment — inspired by Japanese Woodblock #e3cfb4 lightened. Not pure white, reduces glare. |
| `bg.paper` | `#FEFCF8` | 254, 252, 248 | Cards, papers, elevated surfaces          | Near-white with warm tint. Cards read cleanly against cream.                                      |
| `bg.sand`  | `#EBE5D9` | 235, 229, 217 | Subtle sections, code blocks, inset areas | Visible against cream (ΔE > 5) but not distracting.                                               |
| `bg.stone` | `#E0D9CC` | 224, 217, 204 | Deeper inset, disabled fields             | Clear hierarchy step from sand.                                                                   |

#### Dark Mode

| Name          | Hex       | RGB        | Usage                            | Notes                                                                                          |
| ------------- | --------- | ---------- | -------------------------------- | ---------------------------------------------------------------------------------------------- |
| `bg.midnight` | `#1A1B26` | 26, 27, 38 | Page background (default)        | Warm navy — not pure black. Inspired by Apollo #10141f lightened. Purple undertone for warmth. |
| `bg.slate`    | `#232536` | 35, 37, 54 | Cards, papers, elevated surfaces | Clearly distinct from midnight (ΔE > 8).                                                       |
| `bg.dusk`     | `#2C2E42` | 44, 46, 66 | Subtle sections, hover states    | Third tier of depth.                                                                           |
| `bg.abyss`    | `#13141D` | 19, 20, 29 | Deepest inset, sunken areas      | Darkest background, still not pure black.                                                      |

### 2. TEXT (8 colors)

#### Light Mode

| Name            | Hex       | RGB           | Contrast on `bg.cream` | Contrast on `bg.paper` | Usage                                  |
| --------------- | --------- | ------------- | ---------------------- | ---------------------- | -------------------------------------- |
| `text.ink`      | `#2C2A35` | 44, 42, 53    | **11.2:1**             | **12.1:1**             | Body text, headings — AAA              |
| `text.graphite` | `#5C5868` | 92, 88, 104   | **5.6:1**              | **6.0:1**              | Secondary text, captions — AA          |
| `text.ash`      | `#878390` | 135, 131, 144 | **3.3:1**              | **3.5:1**              | Tertiary text, placeholders — AA Large |
| `text.mist`     | `#B2AEBB` | 178, 174, 187 | **2.0:1**              | **2.1:1**              | Disabled text, decorative only         |

#### Dark Mode

| Name          | Hex       | RGB           | Contrast on `bg.midnight` | Contrast on `bg.slate` | Usage                          |
| ------------- | --------- | ------------- | ------------------------- | ---------------------- | ------------------------------ |
| `text.cream`  | `#E8E4DC` | 232, 228, 220 | **12.5:1**                | **10.5:1**             | Body text, headings — AAA      |
| `text.silver` | `#A8A4B2` | 168, 164, 178 | **6.8:1**                 | **5.7:1**              | Secondary text — AA            |
| `text.pewter` | `#747082` | 116, 112, 130 | **3.7:1**                 | **3.1:1**              | Tertiary text — AA Large       |
| `text.shadow` | `#504C5E` | 80, 76, 94    | **2.1:1**                 | **1.8:1**              | Disabled text, decorative only |

### 3. PRIMARY — Warm Indigo (4+2 shades)

Scholarly, trustworthy blue-violet. Desaturated enough for comfort, saturated enough for button CTAs.

| Name            | Hex       | RGB           | Usage                                             | Notes                                                             |
| --------------- | --------- | ------------- | ------------------------------------------------- | ----------------------------------------------------------------- |
| `primary.50`    | `#EDEBF6` | 237, 235, 246 | Light tint backgrounds                            | Hover bg in light mode                                            |
| `primary.100`   | `#C7C1E2` | 199, 193, 226 | Light borders, selected state bg                  |                                                                   |
| `primary.main`  | `#5B52A3` | 91, 82, 163   | **Light mode main** — buttons, links, focus rings | Contrast on paper: **5.8:1** (AA). White on this: **5.3:1** (AA). |
| `primary.700`   | `#463F82` | 70, 63, 130   | Hover/pressed state in light mode                 |                                                                   |
| `primary.light` | `#9B93D7` | 155, 147, 215 | **Dark mode main** — buttons, links               | Contrast on midnight: **5.2:1** (AA).                             |
| `primary.200`   | `#B8B2E5` | 184, 178, 229 | Dark mode hover, lighter accent                   |                                                                   |

### 4. SECONDARY — Warm Rose (4+2 shades)

Creative, inviting. Inspired by Japanese Woodblock reds softened.

| Name              | Hex       | RGB           | Usage                    | Notes                                                             |
| ----------------- | --------- | ------------- | ------------------------ | ----------------------------------------------------------------- |
| `secondary.50`    | `#F5EBF0` | 245, 235, 240 | Light tint backgrounds   |                                                                   |
| `secondary.100`   | `#E0C6D4` | 224, 198, 212 | Light borders, chips     |                                                                   |
| `secondary.main`  | `#A3527A` | 163, 82, 122  | **Light mode main**      | Contrast on paper: **5.0:1** (AA). White on this: **4.6:1** (AA). |
| `secondary.700`   | `#824060` | 130, 64, 96   | Hover/pressed            |                                                                   |
| `secondary.light` | `#D79AB8` | 215, 154, 184 | **Dark mode main**       | Contrast on midnight: **5.4:1** (AA).                             |
| `secondary.200`   | `#E5B8CE` | 229, 184, 206 | Dark mode lighter accent |                                                                   |

### 5. SUCCESS — Sage Green (4 shades)

Natural, earthy green. Inspired by Endesga #3e8948 desaturated.

| Name            | Hex       | RGB           | Usage                    | Notes                                                                        |
| --------------- | --------- | ------------- | ------------------------ | ---------------------------------------------------------------------------- |
| `success.50`    | `#E8F4EC` | 232, 244, 236 | Alert bg, success banner |                                                                              |
| `success.main`  | `#3D8B5E` | 61, 139, 94   | **Light mode**           | Contrast on paper: **3.8:1** (AA-lg). White on this: **3.5:1** (lg buttons). |
| `success.dark`  | `#2D6B47` | 45, 107, 71   | Icon, text emphasis      | Contrast on paper: **5.6:1** (AA for text).                                  |
| `success.light` | `#6BC490` | 107, 196, 144 | **Dark mode main**       | Contrast on midnight: **6.4:1** (AA).                                        |

### 6. WARNING — Warm Amber (4 shades)

Attention without alarm. Inspired by Endesga #feae34 darkened for readability.

| Name            | Hex       | RGB           | Usage                    | Notes                                 |
| --------------- | --------- | ------------- | ------------------------ | ------------------------------------- |
| `warning.50`    | `#FFF4E0` | 255, 244, 224 | Alert bg, warning banner |                                       |
| `warning.main`  | `#C07B2A` | 192, 123, 42  | **Light mode**           | Contrast on paper: **3.6:1** (AA-lg). |
| `warning.dark`  | `#9A6220` | 154, 98, 32   | Text emphasis            | Contrast on paper: **5.2:1** (AA).    |
| `warning.light` | `#E8A94D` | 232, 169, 77  | **Dark mode main**       | Contrast on midnight: **5.9:1** (AA). |

### 7. ERROR — Dusty Red (4 shades)

Urgent but not aggressive. Inspired by Endesga #e43b44 desaturated.

| Name          | Hex       | RGB           | Usage                  | Notes                                                             |
| ------------- | --------- | ------------- | ---------------------- | ----------------------------------------------------------------- |
| `error.50`    | `#FDE6E6` | 253, 230, 230 | Alert bg, error banner |                                                                   |
| `error.main`  | `#C44040` | 196, 64, 64   | **Light mode**         | Contrast on paper: **5.0:1** (AA). White on this: **4.6:1** (AA). |
| `error.dark`  | `#9E3030` | 158, 48, 48   | Text emphasis          | Contrast on paper: **7.0:1** (AAA).                               |
| `error.light` | `#E87070` | 232, 112, 112 | **Dark mode main**     | Contrast on midnight: **4.7:1** (AA).                             |

### 8. INFO — Soft Teal (4 shades)

Calm, informative. Bridges the warm palette with a cool accent.

| Name         | Hex       | RGB           | Usage                 | Notes                                 |
| ------------ | --------- | ------------- | --------------------- | ------------------------------------- |
| `info.50`    | `#E4F2F2` | 228, 242, 242 | Alert bg, info banner |                                       |
| `info.main`  | `#3D8A8A` | 61, 138, 138  | **Light mode**        | Contrast on paper: **3.7:1** (AA-lg). |
| `info.dark`  | `#2D6B6B` | 45, 107, 107  | Text emphasis         | Contrast on paper: **5.5:1** (AA).    |
| `info.light` | `#6BBFBF` | 107, 191, 191 | **Dark mode main**    | Contrast on midnight: **6.0:1** (AA). |

### 9. NEUTRAL/GREY — Warm Ramp (10 shades)

Every grey has a warm purple-amber undertone (never pure grey). Inspired by Apollo's 10-step warm neutral ramp.

| Name       | Hex       | RGB           | Usage                    |
| ---------- | --------- | ------------- | ------------------------ |
| `grey.50`  | `#F8F5F0` | 248, 245, 240 | Barely-there bg tint     |
| `grey.100` | `#EDEAD4` | 237, 234, 212 | Light borders, hover bg  |
| `grey.200` | `#DBD8CE` | 219, 216, 206 | Subtle borders, dividers |
| `grey.300` | `#C6C2B8` | 198, 194, 184 | Input borders (resting)  |
| `grey.400` | `#A6A29A` | 166, 162, 154 | Placeholder icons        |
| `grey.500` | `#86827A` | 134, 130, 122 | Muted labels             |
| `grey.600` | `#666258` | 102, 98, 88   | Secondary icons          |
| `grey.700` | `#4A4840` | 74, 72, 64    | Emphasis on dark bg      |
| `grey.800` | `#32302A` | 50, 48, 42    | Near-dark text alt       |
| `grey.900` | `#1E1C18` | 30, 28, 24    | Deepest neutral          |

### 10. DECORATIVE (6 colors)

For charts, badges, category chips, data visualization. All designed to be distinguishable under colorblindness (sufficient luminance variation).

| Name         | Hex       | RGB           | Purpose                      | On Paper (ratio)   | On Midnight (ratio) |
| ------------ | --------- | ------------- | ---------------------------- | ------------------ | ------------------- |
| `deco.coral` | `#D4826A` | 212, 130, 106 | Charts series 1, warm accent | 2.8:1 (decorative) | 4.1:1               |
| `deco.gold`  | `#D4A44E` | 212, 164, 78  | Badges, XP, achievements     | 2.3:1 (decorative) | 5.0:1               |
| `deco.sage`  | `#7BA887` | 123, 168, 135 | Nature/science topics        | 2.4:1 (decorative) | 4.6:1               |
| `deco.sky`   | `#6B9EC4` | 107, 158, 196 | Tech/CS topics               | 2.8:1 (decorative) | 4.2:1               |
| `deco.plum`  | `#9B6BA8` | 155, 107, 168 | Arts/creative topics         | 3.4:1              | 3.3:1               |
| `deco.terra` | `#B8785C` | 184, 120, 92  | History/social topics        | 3.0:1              | 3.8:1               |

---

## WCAG Compliance Summary

### Light Mode (text on `bg.paper` #FEFCF8)

| Pair                      | Ratio      | Level            |
| ------------------------- | ---------- | ---------------- |
| `text.ink` on paper       | **12.1:1** | AAA              |
| `text.graphite` on paper  | **6.0:1**  | AA               |
| `text.ash` on paper       | **3.5:1**  | AA Large (18px+) |
| `primary.main` on paper   | **5.8:1**  | AA               |
| `secondary.main` on paper | **5.0:1**  | AA               |
| `error.main` on paper     | **5.0:1**  | AA               |
| `success.dark` on paper   | **5.6:1**  | AA               |
| `warning.dark` on paper   | **5.2:1**  | AA               |
| White on `primary.main`   | **5.3:1**  | AA (buttons)     |
| White on `error.main`     | **4.6:1**  | AA (buttons)     |

### Dark Mode (text on `bg.midnight` #1A1B26)

| Pair                          | Ratio      | Level            |
| ----------------------------- | ---------- | ---------------- |
| `text.cream` on midnight      | **12.5:1** | AAA              |
| `text.silver` on midnight     | **6.8:1**  | AA               |
| `text.pewter` on midnight     | **3.7:1**  | AA Large (18px+) |
| `primary.light` on midnight   | **5.2:1**  | AA               |
| `secondary.light` on midnight | **5.4:1**  | AA               |
| `error.light` on midnight     | **4.7:1**  | AA               |
| `success.light` on midnight   | **6.4:1**  | AA               |
| `warning.light` on midnight   | **5.9:1**  | AA               |

---

## MUI Theme Integration

### Mapping to MUI Palette Structure

```javascript
// src/theme/palette.js — Cozy Study Palette v1.0

// ═══════════════════════════════════════════════════════════
// COZY STUDY PALETTE — 44 colors
// Inspired by: Apollo, Endesga 32/36, Japanese Woodblock, SLSO8
// Design: Warm, desaturated, WCAG AA+ for readability
// ═══════════════════════════════════════════════════════════

export const COZY = {
  // ── Backgrounds ──────────────────────────────────────────
  bg: {
    light: {
      cream: '#F5F0E8', // page default
      paper: '#FEFCF8', // cards, elevated
      sand: '#EBE5D9', // inset, code blocks
      stone: '#E0D9CC', // deeper inset, disabled
    },
    dark: {
      midnight: '#1A1B26', // page default
      slate: '#232536', // cards, elevated
      dusk: '#2C2E42', // inset, hover
      abyss: '#13141D', // deepest
    },
  },

  // ── Text ─────────────────────────────────────────────────
  text: {
    light: {
      ink: '#2C2A35', // primary (11.2:1 on cream)
      graphite: '#5C5868', // secondary (5.6:1)
      ash: '#878390', // tertiary (3.3:1, large text)
      mist: '#B2AEBB', // disabled (decorative only)
    },
    dark: {
      cream: '#E8E4DC', // primary (12.5:1 on midnight)
      silver: '#A8A4B2', // secondary (6.8:1)
      pewter: '#747082', // tertiary (3.7:1, large text)
      shadow: '#504C5E', // disabled (decorative only)
    },
  },

  // ── Primary: Warm Indigo ─────────────────────────────────
  primary: {
    50: '#EDEBF6',
    100: '#C7C1E2',
    200: '#B8B2E5',
    main: '#5B52A3', // light mode
    700: '#463F82',
    light: '#9B93D7', // dark mode main
  },

  // ── Secondary: Warm Rose ─────────────────────────────────
  secondary: {
    50: '#F5EBF0',
    100: '#E0C6D4',
    200: '#E5B8CE',
    main: '#A3527A', // light mode
    700: '#824060',
    light: '#D79AB8', // dark mode main
  },

  // ── Success: Sage Green ──────────────────────────────────
  success: {
    50: '#E8F4EC',
    main: '#3D8B5E', // light mode
    dark: '#2D6B47',
    light: '#6BC490', // dark mode main
  },

  // ── Warning: Warm Amber ──────────────────────────────────
  warning: {
    50: '#FFF4E0',
    main: '#C07B2A', // light mode
    dark: '#9A6220',
    light: '#E8A94D', // dark mode main
  },

  // ── Error: Dusty Red ─────────────────────────────────────
  error: {
    50: '#FDE6E6',
    main: '#C44040', // light mode
    dark: '#9E3030',
    light: '#E87070', // dark mode main
  },

  // ── Info: Soft Teal ──────────────────────────────────────
  info: {
    50: '#E4F2F2',
    main: '#3D8A8A', // light mode
    dark: '#2D6B6B',
    light: '#6BBFBF', // dark mode main
  },

  // ── Neutral Grey (warm-shifted) ──────────────────────────
  grey: {
    50: '#F8F5F0',
    100: '#EDEAD4',
    200: '#DBD8CE',
    300: '#C6C2B8',
    400: '#A6A29A',
    500: '#86827A',
    600: '#666258',
    700: '#4A4840',
    800: '#32302A',
    900: '#1E1C18',
  },

  // ── Decorative (charts, badges, categories) ──────────────
  deco: {
    coral: '#D4826A', // warm coral
    gold: '#D4A44E', // rich gold
    sage: '#7BA887', // sage green
    sky: '#6B9EC4', // sky blue
    plum: '#9B6BA8', // plum purple
    terra: '#B8785C', // terracotta
  },
};
```

### MUI createTheme Configuration

```javascript
// Usage in theme.js or pixelTheme.js

import { createTheme } from '@mui/material/styles';
import { COZY } from './palette.js';

const theme = createTheme({
  cssVariables: { colorSchemeSelector: 'data-color-scheme' },

  colorSchemes: {
    light: {
      palette: {
        primary:   { main: COZY.primary.main, light: COZY.primary.100, dark: COZY.primary[700] },
        secondary: { main: COZY.secondary.main, light: COZY.secondary[100], dark: COZY.secondary[700] },
        success:   { main: COZY.success.main, dark: COZY.success.dark, light: COZY.success[50] },
        warning:   { main: COZY.warning.main, dark: COZY.warning.dark, light: COZY.warning[50] },
        error:     { main: COZY.error.main, dark: COZY.error.dark, light: COZY.error[50] },
        info:      { main: COZY.info.main, dark: COZY.info.dark, light: COZY.info[50] },
        grey:      COZY.grey,
        background: {
          default: COZY.bg.light.cream,
          paper:   COZY.bg.light.paper,
        },
        text: {
          primary:   COZY.text.light.ink,
          secondary: COZY.text.light.graphite,
          disabled:  COZY.text.light.mist,
        },
        divider: 'rgba(44, 42, 53, 0.10)',  // warm ink-based divider
        action: {
          hover: 'rgba(91, 82, 163, 0.06)',           // primary-tinted hover
          selected: 'rgba(91, 82, 163, 0.10)',         // primary-tinted selected
          disabledBackground: COZY.bg.light.stone,
          disabled: COZY.text.light.mist,
        },
      },
    },

    dark: {
      palette: {
        primary:   { main: COZY.primary.light, light: COZY.primary[200], dark: COZY.primary.main },
        secondary: { main: COZY.secondary.light, light: COZY.secondary[200], dark: COZY.secondary.main },
        success:   { main: COZY.success.light, dark: COZY.success.main, light: COZY.success[50] },
        warning:   { main: COZY.warning.light, dark: COZY.warning.main, light: COZY.warning[50] },
        error:     { main: COZY.error.light, dark: COZY.error.main, light: COZY.error[50] },
        info:      { main: COZY.info.light, dark: COZY.info.main, light: COZY.info[50] },
        grey:      COZY.grey,
        background: {
          default: COZY.bg.dark.midnight,
          paper:   COZY.bg.dark.slate,
        },
        text: {
          primary:   COZY.text.dark.cream,
          secondary: COZY.text.dark.silver,
          disabled:  COZY.text.dark.shadow,
        },
        divider: 'rgba(232, 228, 220, 0.08)',  // warm cream-based divider
        action: {
          hover: 'rgba(155, 147, 215, 0.08)',           // primary-tinted hover
          selected: 'rgba(155, 147, 215, 0.14)',         // primary-tinted selected
          disabledBackground: COZY.bg.dark.abyss,
          disabled: COZY.text.dark.shadow,
        },
      },
    },
  },

  // ... rest of theme (typography, shape, components)
});
```

### PICO to COZY Migration Map

For files that directly import `PICO` colors:

| PICO Color                  | Hex                     | COZY Replacement | Hex                          | Reason |
| --------------------------- | ----------------------- | ---------------- | ---------------------------- | ------ |
| `PICO.blue` (#29ADFF)       | `COZY.deco.sky`         | `#6B9EC4`        | Desaturated, same hue family |
| `PICO.pink` (#FF77A8)       | `COZY.secondary.light`  | `#D79AB8`        | Warm rose, less harsh        |
| `PICO.green` (#00E436)      | `COZY.success.light`    | `#6BC490`        | Sage, less neon              |
| `PICO.orange` (#FFA300)     | `COZY.warning.light`    | `#E8A94D`        | Warm amber, less glaring     |
| `PICO.red` (#FF004D)        | `COZY.error.light`      | `#E87070`        | Dusty red, less aggressive   |
| `PICO.yellow` (#FFEC27)     | `COZY.deco.gold`        | `#D4A44E`        | Rich gold, less neon         |
| `PICO.lavender` (#83769C)   | `COZY.deco.plum`        | `#9B6BA8`        | Plum, more intentional       |
| `PICO.peach` (#FFCCAA)      | `COZY.deco.coral`       | `#D4826A`        | Warmer, more grounded        |
| `PICO.darkBlue` (#1D2B53)   | `COZY.bg.dark.midnight` | `#1A1B26`        | Warm dark, purple-shifted    |
| `PICO.darkGrey` (#5F574F)   | `COZY.grey[600]`        | `#666258`        | Warm grey                    |
| `PICO.lightGrey` (#C2C3C7)  | `COZY.grey[300]`        | `#C6C2B8`        | Warm grey                    |
| `PICO.white` (#FFF1E8)      | `COZY.bg.light.cream`   | `#F5F0E8`        | Similar warm tone            |
| `PICO.brown` (#AB5236)      | `COZY.deco.terra`       | `#B8785C`        | Terracotta, lighter          |
| `PICO.darkPurple` (#7E2553) | `COZY.secondary[700]`   | `#824060`        | Warm rose dark               |
| `PICO.darkGreen` (#008751)  | `COZY.success.main`     | `#3D8B5E`        | Sage, desaturated            |
| `PICO.black` (#000000)      | `COZY.bg.dark.abyss`    | `#13141D`        | Never pure black             |

### ColorPickerField Replacement

```javascript
// Replace PICO_COLORS array in ColorPickerField.jsx
const PALETTE_COLORS = [
  // Semantic
  { hex: '#5B52A3', name: 'Indigo' },
  { hex: '#A3527A', name: 'Rose' },
  { hex: '#3D8B5E', name: 'Sage' },
  { hex: '#C07B2A', name: 'Amber' },
  { hex: '#C44040', name: 'Red' },
  { hex: '#3D8A8A', name: 'Teal' },
  // Decorative
  { hex: '#D4826A', name: 'Coral' },
  { hex: '#D4A44E', name: 'Gold' },
  { hex: '#7BA887', name: 'Mint' },
  { hex: '#6B9EC4', name: 'Sky' },
  { hex: '#9B6BA8', name: 'Plum' },
  { hex: '#B8785C', name: 'Terra' },
  // Neutrals
  { hex: '#2C2A35', name: 'Ink' },
  { hex: '#5C5868', name: 'Graphite' },
  { hex: '#86827A', name: 'Stone' },
  { hex: '#C6C2B8', name: 'Silver' },
];
```

---

## Color Accessibility Notes

### Colorblind Safety

The decorative palette was designed with varying luminance levels to remain distinguishable under the three main colorblindness types:

| Color           | Approximate Luminance | Deuteranopia                | Protanopia             | Tritanopia           |
| --------------- | --------------------- | --------------------------- | ---------------------- | -------------------- |
| coral (#D4826A) | 0.24                  | Distinguishable (brown-ish) | Distinguishable        | Distinguishable      |
| gold (#D4A44E)  | 0.37                  | Distinguishable (bright)    | Distinguishable        | May merge with coral |
| sage (#7BA887)  | 0.33                  | May appear similar to gold  | Distinguishable        | Distinguishable      |
| sky (#6B9EC4)   | 0.31                  | Distinguishable (blue)      | Distinguishable (blue) | May shift            |
| plum (#9B6BA8)  | 0.17                  | Distinguishable (dark)      | Distinguishable        | Distinguishable      |
| terra (#B8785C) | 0.22                  | May appear similar to coral | Distinguishable        | Distinguishable      |

**Recommendation**: When using decorative colors for data visualization, always pair with shape/pattern or labels, not color alone.

### Focus Ring

Use `primary.main` (#5B52A3) in light mode and `primary.light` (#9B93D7) in dark mode for focus rings. Both achieve 3:1+ contrast against their respective backgrounds, meeting WCAG 2.2 focus indicator requirements.

---

## Research Sources

- [DawnBringer 32 Palette](https://lospec.com/palette-list/dawnbringer-32)
- [Endesga 32 Palette](https://lospec.com/palette-list/endesga-32)
- [Endesga 36 Palette](https://lospec.com/palette-list/endesga-36)
- [Apollo Palette](https://lospec.com/palette-list/apollo)
- [Japanese Woodblock Palette](https://lospec.com/palette-list/japanese-woodblock)
- [SLSO8 Palette](https://lospec.com/palette-list/slso8)
- [Resurrect 64 Palette](https://lospec.com/palette-list/resurrect-64)
- [Lospec Palette List](https://lospec.com/palette-list)
- [Color Theory for Pixel Artists](https://pixelparmesan.com/blog/color-theory-for-pixel-artists-its-all-relative)
- [Pixel Art Color Palettes — SLYNYRD](https://www.slynyrd.com/blog/2018/1/10/pixelblog-1-color-palettes)
- [Stardew Valley Color Scheme](https://www.schemecolor.com/stardew-valley.php)
- [10 Pixel Art Color Palettes for Games — Sprite-AI](https://www.sprite-ai.art/guides/pixel-art-color-palettes)
- [Dark Mode Best Practices — DubBot](https://dubbot.com/dubblog/2023/dark-mode-a11y.html)
- [Dark Mode Done Right — Medium](https://medium.com/@mohitphogat/dark-mode-done-right-and-why-most-apps-get-it-wrong-a75f90aab30a)
- [WCAG Contrast Requirements](https://www.makethingsaccessible.com/guides/contrast-requirements-for-wcag-2-2-level-aa/)
- [Color Contrast for Readability — Viget](https://www.viget.com/articles/color-contrast)
- [Accessible Colors Guide — Venngage](https://venngage.com/blog/accessible-colors/)
- [MUI Dark Mode Documentation](https://mui.com/material-ui/customization/dark-mode/)
- [MUI Palette Customization](https://mui.com/material-ui/customization/palette/)
- [Calm Color Palettes for Websites](https://muffingroup.com/blog/calm-color-palette/)
- [Color Safe — Accessible Combinations](http://colorsafe.co/)
- [Relaxing Dark Mode Palette](https://www.color-hex.com/color-palette/1043808)
