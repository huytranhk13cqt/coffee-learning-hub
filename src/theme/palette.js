// ═══════════════════════════════════════════════════════════
// COZY STUDY PALETTE — 44 warm, desaturated colors
// Inspired by: Apollo, Endesga 32/36, Japanese Woodblock, SLSO8
// Design: Warm undertones, <70% saturation, WCAG AA+ compliant
// Spec: docs/palette-specification.md
// ═══════════════════════════════════════════════════════════

export const COZY = {
  // ── Backgrounds ──────────────────────────────────────────
  bg: {
    light: {
      cream: '#F5F0E8', // page default — warm parchment
      paper: '#FEFCF8', // cards, elevated surfaces
      sand: '#EBE5D9', // inset areas, code blocks
      stone: '#E0D9CC', // deeper inset, disabled fields
    },
    dark: {
      midnight: '#1A1B26', // page default — warm navy
      slate: '#232536', // cards, elevated surfaces
      dusk: '#2C2E42', // inset areas, hover states
      abyss: '#13141D', // deepest inset
    },
  },

  // ── Text ─────────────────────────────────────────────────
  text: {
    light: {
      ink: '#2C2A35', // primary (11.2:1 on cream)
      graphite: '#5C5868', // secondary (5.6:1)
      ash: '#878390', // tertiary (3.3:1, large text only)
      mist: '#B2AEBB', // disabled (decorative only)
    },
    dark: {
      cream: '#E8E4DC', // primary (12.5:1 on midnight)
      silver: '#A8A4B2', // secondary (6.8:1)
      pewter: '#747082', // tertiary (3.7:1, large text only)
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

  // ── Neutral Grey (warm-shifted, never pure grey) ─────────
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
    gold: '#D4A44E', // rich gold — XP, achievements
    sage: '#7BA887', // sage green — nature topics
    sky: '#6B9EC4', // sky blue — tech topics
    plum: '#9B6BA8', // plum purple — arts topics
    terra: '#B8785C', // terracotta — history topics
  },
};

// ── Swatch array for ColorPickerField ────────────────────
export const PALETTE_SWATCHES = [
  { hex: '#5B52A3', name: 'Indigo' },
  { hex: '#A3527A', name: 'Rose' },
  { hex: '#3D8B5E', name: 'Sage' },
  { hex: '#C07B2A', name: 'Amber' },
  { hex: '#C44040', name: 'Red' },
  { hex: '#3D8A8A', name: 'Teal' },
  { hex: '#D4826A', name: 'Coral' },
  { hex: '#D4A44E', name: 'Gold' },
  { hex: '#7BA887', name: 'Mint' },
  { hex: '#6B9EC4', name: 'Sky' },
  { hex: '#9B6BA8', name: 'Plum' },
  { hex: '#B8785C', name: 'Terra' },
  { hex: '#2C2A35', name: 'Ink' },
  { hex: '#5C5868', name: 'Graphite' },
  { hex: '#86827A', name: 'Stone' },
  { hex: '#C6C2B8', name: 'Silver' },
];
