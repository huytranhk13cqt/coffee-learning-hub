import { createTheme } from '@mui/material/styles';
import { COZY } from './palette.js';
import { FONT, DITHER, pixelShadows } from './pixelUtils.js';

// ═══════════════════════════════════════════════════════════
// Unified Pixel Art Theme — Cozy Study Edition
// Stardew Valley-inspired 64-bit aesthetic
// Used by BOTH user-facing Layout and Admin Layout
// ═══════════════════════════════════════════════════════════

const pixelTheme = createTheme({
  cssVariables: { colorSchemeSelector: 'data-color-scheme' },
  shadows: pixelShadows,

  // ── Color Schemes ──────────────────────────────────────
  colorSchemes: {
    light: {
      palette: {
        primary: {
          main: COZY.primary.main,
          light: COZY.primary[100],
          dark: COZY.primary[700],
          contrastText: '#FEFCF8',
        },
        secondary: {
          main: COZY.secondary.main,
          light: COZY.secondary[100],
          dark: COZY.secondary[700],
          contrastText: '#FEFCF8',
        },
        success: {
          main: COZY.success.main,
          dark: COZY.success.dark,
          light: COZY.success[50],
        },
        warning: {
          main: COZY.warning.main,
          dark: COZY.warning.dark,
          light: COZY.warning[50],
        },
        error: {
          main: COZY.error.main,
          dark: COZY.error.dark,
          light: COZY.error[50],
        },
        info: {
          main: COZY.info.main,
          dark: COZY.info.dark,
          light: COZY.info[50],
        },
        grey: COZY.grey,
        background: {
          default: COZY.bg.light.cream,
          paper: COZY.bg.light.paper,
        },
        text: {
          primary: COZY.text.light.ink,
          secondary: COZY.text.light.graphite,
          disabled: COZY.text.light.mist,
        },
        divider: 'rgba(44, 42, 53, 0.10)',
        action: {
          hover: 'rgba(91, 82, 163, 0.06)',
          selected: 'rgba(91, 82, 163, 0.10)',
          disabledBackground: COZY.bg.light.stone,
          disabled: COZY.text.light.mist,
        },
        // Custom tokens for pixel effects
        AppBar: {
          defaultBg: COZY.primary.main,
        },
      },
    },

    dark: {
      palette: {
        primary: {
          main: COZY.primary.light,
          light: COZY.primary[200],
          dark: COZY.primary.main,
          contrastText: COZY.bg.dark.midnight,
        },
        secondary: {
          main: COZY.secondary.light,
          light: COZY.secondary[200],
          dark: COZY.secondary.main,
        },
        success: {
          main: COZY.success.light,
          dark: COZY.success.main,
          light: COZY.success[50],
        },
        warning: {
          main: COZY.warning.light,
          dark: COZY.warning.main,
          light: COZY.warning[50],
        },
        error: {
          main: COZY.error.light,
          dark: COZY.error.main,
          light: COZY.error[50],
        },
        info: {
          main: COZY.info.light,
          dark: COZY.info.main,
          light: COZY.info[50],
        },
        grey: COZY.grey,
        background: {
          default: COZY.bg.dark.midnight,
          paper: COZY.bg.dark.slate,
        },
        text: {
          primary: COZY.text.dark.cream,
          secondary: COZY.text.dark.silver,
          disabled: COZY.text.dark.shadow,
        },
        divider: 'rgba(232, 228, 220, 0.08)',
        action: {
          hover: 'rgba(155, 147, 215, 0.08)',
          selected: 'rgba(155, 147, 215, 0.14)',
          disabledBackground: COZY.bg.dark.abyss,
          disabled: COZY.text.dark.shadow,
        },
        AppBar: {
          defaultBg: COZY.bg.dark.abyss,
        },
      },
    },
  },

  // ── Shape ──────────────────────────────────────────────
  shape: {
    borderRadius: 2, // Pixel-sharp corners
  },

  // ── Typography ─────────────────────────────────────────
  // Silkscreen: headings, buttons, nav, labels (pixel UI chrome)
  // VT323: body text, data, secondary info (pixel monospace)
  // Inter/system: lesson content, long reading (readability)

  typography: {
    fontFamily: FONT.mono,
    fontSize: 16,

    // Page titles — pixel display
    h1: {
      fontFamily: FONT.pixel,
      fontSize: '1.75rem',
      lineHeight: 1.6,
      fontWeight: 400,
      letterSpacing: '0.02em',
    },
    // Section headings
    h2: {
      fontFamily: FONT.pixel,
      fontSize: '1.4rem',
      lineHeight: 1.6,
      fontWeight: 400,
    },
    // Subsection headings
    h3: {
      fontFamily: FONT.pixel,
      fontSize: '1.15rem',
      lineHeight: 1.5,
      fontWeight: 400,
    },
    h4: {
      fontFamily: FONT.pixel,
      fontSize: '1.05rem',
      lineHeight: 1.5,
    },
    h5: {
      fontFamily: FONT.pixel,
      fontSize: '0.95rem',
      lineHeight: 1.4,
    },
    h6: {
      fontFamily: FONT.pixel,
      fontSize: '0.875rem',
      lineHeight: 1.4,
    },
    // Subtitles — pixel
    subtitle1: {
      fontFamily: FONT.pixel,
      fontSize: '0.95rem',
      lineHeight: 1.4,
    },
    subtitle2: {
      fontFamily: FONT.pixel,
      fontSize: '0.85rem',
      lineHeight: 1.4,
    },
    // Body text — pixel monospace
    body1: {
      fontFamily: FONT.mono,
      fontSize: '1.25rem',
      lineHeight: 1.6,
    },
    body2: {
      fontFamily: FONT.mono,
      fontSize: '1.1rem',
      lineHeight: 1.5,
    },
    // Buttons & labels — pixel
    button: {
      fontFamily: FONT.pixel,
      fontSize: '0.875rem',
      textTransform: 'none',
      letterSpacing: '0.02em',
    },
    caption: {
      fontFamily: FONT.mono,
      fontSize: '1rem',
      lineHeight: 1.4,
    },
    overline: {
      fontFamily: FONT.pixel,
      fontSize: '0.7rem',
      letterSpacing: '0.12em',
    },
  },

  // ── Component Overrides ────────────────────────────────
  components: {
    // ▸ Global baseline — pixel texture overlay + font rendering
    MuiCssBaseline: {
      styleOverrides: {
        body: {
          imageRendering: 'pixelated',
          // Subtle pixel dot texture — the "retro scanline" effect
          '&::after': {
            content: '""',
            position: 'fixed',
            inset: 0,
            backgroundImage: DITHER.dots.light,
            backgroundSize: DITHER.dots.size,
            pointerEvents: 'none',
            zIndex: 9999,
            opacity: 0.8,
          },
          '[data-color-scheme="dark"] &::after': {
            backgroundImage: DITHER.dots.dark,
          },
        },
        // Smooth scrollbar with pixel aesthetics
        '*::-webkit-scrollbar': {
          width: 8,
          height: 8,
        },
        '*::-webkit-scrollbar-track': {
          background: 'var(--mui-palette-background-default)',
        },
        '*::-webkit-scrollbar-thumb': {
          background: 'var(--mui-palette-divider)',
          border: '2px solid var(--mui-palette-background-default)',
          '&:hover': {
            background: 'var(--mui-palette-action-hover)',
          },
        },
      },
    },

    // ▸ Button — pixel press effect
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          textTransform: 'none',
          border: '2px solid transparent',
          boxShadow: `2px 2px 0 0 rgba(91,82,163,0.12)`,
          transition:
            'transform 0.1s steps(2, end), box-shadow 0.1s steps(2, end)',
          '&:hover': {
            transform: 'translateY(-1px)',
            boxShadow: `3px 3px 0 0 rgba(91,82,163,0.18)`,
          },
          '&:active': {
            transform: 'translateY(1px)',
            boxShadow: 'none',
          },
        },
        contained: {
          border: '2px solid',
          borderColor: 'rgba(0,0,0,0.15)',
          borderBottomColor: 'rgba(0,0,0,0.25)',
          borderRightColor: 'rgba(0,0,0,0.20)',
          '&:hover': {
            borderColor: 'rgba(0,0,0,0.20)',
          },
        },
        containedPrimary: {
          '&:hover': {
            boxShadow: `3px 3px 0 0 ${COZY.primary.main}44`,
          },
        },
        outlined: {
          borderWidth: 2,
          '&:hover': {
            borderWidth: 2,
          },
        },
        text: {
          boxShadow: 'none',
          '&:hover': {
            boxShadow: 'none',
            backgroundColor: 'var(--mui-palette-action-hover)',
          },
          '&:active': {
            transform: 'translateY(1px)',
          },
        },
        sizeSmall: {
          fontSize: '0.8rem',
          padding: '4px 12px',
        },
        sizeLarge: {
          fontSize: '1rem',
          padding: '10px 28px',
        },
      },
    },

    // ▸ IconButton — pixel circle
    MuiIconButton: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          transition:
            'transform 0.1s steps(2, end), background-color 0.15s steps(3, end)',
          '&:hover': {
            transform: 'translateY(-1px)',
          },
          '&:active': {
            transform: 'translateY(1px)',
          },
        },
      },
    },

    // ▸ Card — pixel frame with warm shadow
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          border: '2px solid var(--mui-palette-divider)',
          backgroundImage: 'none',
          boxShadow: '3px 3px 0 0 rgba(91,82,163,0.08)',
          transition:
            'box-shadow 0.15s steps(3, end), transform 0.15s steps(3, end)',
          '&:hover': {
            boxShadow: `4px 4px 0 0 rgba(91,82,163,0.14)`,
            transform: 'translateY(-1px)',
          },
        },
      },
    },

    // ▸ Paper — clean pixel surface
    MuiPaper: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          backgroundImage: 'none',
        },
        outlined: {
          borderWidth: 2,
          borderStyle: 'solid',
        },
      },
    },

    // ▸ AppBar — solid pixel header
    MuiAppBar: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          boxShadow: '0 2px 0 0 var(--mui-palette-divider)',
          borderBottom: '2px solid',
          borderColor: 'rgba(0,0,0,0.12)',
          backgroundImage: 'none',
        },
      },
    },

    // ▸ Toolbar — standard spacing
    MuiToolbar: {
      styleOverrides: {
        root: {
          minHeight: 56,
        },
      },
    },

    // ▸ Drawer — pixel sidebar
    MuiDrawer: {
      styleOverrides: {
        paper: {
          borderRadius: 0,
          backgroundImage: DITHER.dots.light,
          backgroundSize: DITHER.dots.size,
          '[data-color-scheme="dark"] &': {
            backgroundImage: DITHER.dots.dark,
          },
        },
      },
    },

    // ▸ TextField / Input — pixel input field
    MuiTextField: {
      styleOverrides: {
        root: {
          '& .MuiOutlinedInput-root': {
            borderRadius: 2,
            fontFamily: FONT.mono,
            fontSize: '1.1rem',
            '& fieldset': {
              borderWidth: 2,
              transition: 'border-color 0.15s steps(3, end)',
            },
            '&:hover fieldset': {
              borderWidth: 2,
            },
            '&.Mui-focused fieldset': {
              borderWidth: 2,
            },
          },
        },
      },
    },

    MuiOutlinedInput: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          '& fieldset': {
            borderWidth: 2,
          },
          '&:hover fieldset': {
            borderWidth: 2,
          },
          '&.Mui-focused fieldset': {
            borderWidth: 2,
          },
        },
      },
    },

    MuiInputBase: {
      styleOverrides: {
        root: {
          fontFamily: FONT.mono,
          fontSize: '1.1rem',
        },
      },
    },

    // ▸ Select — pixel dropdown
    MuiSelect: {
      styleOverrides: {
        outlined: {
          borderRadius: 2,
        },
      },
    },

    // ▸ Chip — pixel tag
    MuiChip: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          fontFamily: FONT.mono,
          fontSize: '1rem',
          border: '1px solid var(--mui-palette-divider)',
          transition: 'transform 0.1s steps(2, end)',
          '&:hover': {
            transform: 'translateY(-1px)',
          },
        },
        outlined: {
          borderWidth: 2,
        },
      },
    },

    // ▸ Alert — pixel notification frame
    MuiAlert: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          border: '2px solid',
          fontFamily: FONT.mono,
          fontSize: '1.05rem',
          '& .MuiAlert-icon': {
            fontSize: '1.4rem',
          },
        },
        standardSuccess: {
          borderColor: COZY.success.main,
          backgroundColor: COZY.success[50],
          '[data-color-scheme="dark"] &': {
            borderColor: COZY.success.light,
            backgroundColor: 'rgba(107, 196, 144, 0.08)',
          },
        },
        standardError: {
          borderColor: COZY.error.main,
          backgroundColor: COZY.error[50],
          '[data-color-scheme="dark"] &': {
            borderColor: COZY.error.light,
            backgroundColor: 'rgba(232, 112, 112, 0.08)',
          },
        },
        standardWarning: {
          borderColor: COZY.warning.main,
          backgroundColor: COZY.warning[50],
          '[data-color-scheme="dark"] &': {
            borderColor: COZY.warning.light,
            backgroundColor: 'rgba(232, 169, 77, 0.08)',
          },
        },
        standardInfo: {
          borderColor: COZY.info.main,
          backgroundColor: COZY.info[50],
          '[data-color-scheme="dark"] &': {
            borderColor: COZY.info.light,
            backgroundColor: 'rgba(107, 191, 191, 0.08)',
          },
        },
      },
    },

    // ▸ Dialog — pixel modal frame
    MuiDialog: {
      styleOverrides: {
        paper: {
          borderRadius: 4,
          border: '2px solid var(--mui-palette-divider)',
          boxShadow: '6px 6px 0 0 rgba(91,82,163,0.12)',
        },
      },
    },

    // ▸ LinearProgress — chunky pixel progress bar
    MuiLinearProgress: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          height: 8,
          border: '2px solid var(--mui-palette-divider)',
          backgroundColor: 'var(--mui-palette-action-disabledBackground)',
          '& .MuiLinearProgress-bar': {
            borderRadius: 0,
          },
        },
      },
    },

    // ▸ ListItemButton — pixel nav item
    MuiListItemButton: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          margin: '1px 4px',
          position: 'relative',
          transition: 'background 0.15s steps(3, end)',
          '&.Mui-selected': {
            background: `linear-gradient(90deg, var(--mui-palette-action-selected) 0%, transparent 100%)`,
            borderLeft: '3px solid var(--mui-palette-primary-main)',
            '&::before': {
              content: '""',
              position: 'absolute',
              left: 0,
              top: '50%',
              transform: 'translateY(-50%)',
              width: 3,
              height: '60%',
              background: 'var(--mui-palette-primary-main)',
              boxShadow: `0 0 8px var(--mui-palette-primary-main)`,
              borderRadius: 0,
            },
            '&:hover': {
              background: `linear-gradient(90deg, var(--mui-palette-action-hover) 0%, transparent 100%)`,
            },
          },
          '&:hover': {
            background: 'var(--mui-palette-action-hover)',
          },
        },
      },
    },

    // ▸ Divider — pixel line
    MuiDivider: {
      styleOverrides: {
        root: {
          borderBottomWidth: 2,
        },
      },
    },

    // ▸ Tooltip — pixel tooltip
    MuiTooltip: {
      styleOverrides: {
        tooltip: {
          borderRadius: 2,
          fontFamily: FONT.mono,
          fontSize: '0.95rem',
          border: '2px solid var(--mui-palette-divider)',
          boxShadow: '2px 2px 0 0 rgba(0,0,0,0.15)',
          padding: '6px 10px',
        },
      },
    },

    // ▸ Table — pixel grid
    MuiTableCell: {
      styleOverrides: {
        root: {
          borderBottomWidth: 2,
          fontFamily: FONT.mono,
          fontSize: '1.05rem',
        },
        head: {
          fontFamily: FONT.pixel,
          fontSize: '0.8rem',
          letterSpacing: '0.05em',
          textTransform: 'uppercase',
        },
      },
    },

    MuiTableContainer: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          border: '2px solid var(--mui-palette-divider)',
        },
      },
    },

    // ▸ Tabs — pixel tab bar
    MuiTab: {
      styleOverrides: {
        root: {
          fontFamily: FONT.pixel,
          fontSize: '0.85rem',
          textTransform: 'none',
          minHeight: 44,
          transition: 'color 0.15s steps(3, end)',
        },
      },
    },

    MuiTabs: {
      styleOverrides: {
        indicator: {
          height: 3,
          borderRadius: 0,
        },
      },
    },

    // ▸ Badge — pixel counter
    MuiBadge: {
      styleOverrides: {
        badge: {
          fontFamily: FONT.pixel,
          fontSize: '0.65rem',
          borderRadius: 2,
          minWidth: 18,
          height: 18,
          border: '2px solid var(--mui-palette-background-paper)',
        },
      },
    },

    // ▸ Switch — pixel toggle
    MuiSwitch: {
      styleOverrides: {
        root: {
          '& .MuiSwitch-track': {
            borderRadius: 2,
            border: '2px solid var(--mui-palette-divider)',
          },
          '& .MuiSwitch-thumb': {
            borderRadius: 2,
            boxShadow: '1px 1px 0 0 rgba(0,0,0,0.15)',
          },
        },
      },
    },

    // ▸ Slider — pixel range
    MuiSlider: {
      styleOverrides: {
        root: {
          '& .MuiSlider-track': {
            borderRadius: 0,
            border: 'none',
          },
          '& .MuiSlider-rail': {
            borderRadius: 0,
            opacity: 0.3,
          },
          '& .MuiSlider-thumb': {
            borderRadius: 2,
            width: 16,
            height: 16,
            boxShadow: '2px 2px 0 0 rgba(0,0,0,0.15)',
            '&:hover': {
              boxShadow: '2px 2px 0 0 rgba(0,0,0,0.25)',
            },
          },
        },
      },
    },

    // ▸ Accordion — pixel collapsible
    MuiAccordion: {
      styleOverrides: {
        root: {
          borderRadius: '2px !important',
          border: '2px solid var(--mui-palette-divider)',
          '&:before': {
            display: 'none',
          },
          '&.Mui-expanded': {
            margin: '0 0 8px 0',
          },
        },
      },
    },

    MuiAccordionSummary: {
      styleOverrides: {
        root: {
          fontFamily: FONT.pixel,
          fontSize: '0.9rem',
        },
      },
    },

    // ▸ Menu — pixel dropdown menu
    MuiMenu: {
      styleOverrides: {
        paper: {
          borderRadius: 2,
          border: '2px solid var(--mui-palette-divider)',
          boxShadow: '4px 4px 0 0 rgba(91,82,163,0.10)',
        },
      },
    },

    MuiMenuItem: {
      styleOverrides: {
        root: {
          fontFamily: FONT.mono,
          fontSize: '1.05rem',
          borderRadius: 2,
          margin: '1px 4px',
          transition: 'background 0.1s steps(2, end)',
        },
      },
    },

    // ▸ Snackbar — pixel toast
    MuiSnackbar: {
      styleOverrides: {
        root: {
          '& .MuiSnackbarContent-root': {
            borderRadius: 2,
            border: '2px solid var(--mui-palette-divider)',
            fontFamily: FONT.mono,
            fontSize: '1.05rem',
          },
        },
      },
    },

    // ▸ Skeleton — pixel loading placeholder
    MuiSkeleton: {
      styleOverrides: {
        root: {
          borderRadius: 2,
        },
        rectangular: {
          borderRadius: 2,
        },
      },
    },

    // ▸ Link — pixel underline
    MuiLink: {
      styleOverrides: {
        root: {
          textDecorationThickness: 2,
          textUnderlineOffset: 3,
          transition: 'color 0.1s steps(2, end)',
        },
      },
    },

    // ▸ Breadcrumbs — pixel path
    MuiBreadcrumbs: {
      styleOverrides: {
        root: {
          fontFamily: FONT.mono,
          fontSize: '1rem',
        },
        separator: {
          fontFamily: FONT.mono,
        },
      },
    },

    // ▸ Pagination — pixel page nav
    MuiPaginationItem: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          fontFamily: FONT.pixel,
          fontSize: '0.8rem',
          border: '2px solid var(--mui-palette-divider)',
          '&.Mui-selected': {
            fontWeight: 400,
          },
        },
      },
    },

    // ▸ ToggleButton — pixel toggle
    MuiToggleButton: {
      styleOverrides: {
        root: {
          borderRadius: 2,
          borderWidth: 2,
          fontFamily: FONT.pixel,
          fontSize: '0.85rem',
          textTransform: 'none',
          transition: 'background 0.1s steps(2, end)',
        },
      },
    },

    // ▸ FormLabel — pixel label
    MuiFormLabel: {
      styleOverrides: {
        root: {
          fontFamily: FONT.pixel,
          fontSize: '0.85rem',
        },
      },
    },

    MuiInputLabel: {
      styleOverrides: {
        root: {
          fontFamily: FONT.pixel,
          fontSize: '0.9rem',
        },
      },
    },

    // ▸ FormHelperText
    MuiFormHelperText: {
      styleOverrides: {
        root: {
          fontFamily: FONT.mono,
          fontSize: '0.95rem',
        },
      },
    },

    // ▸ Checkbox & Radio — pixel controls
    MuiCheckbox: {
      styleOverrides: {
        root: {
          '& .MuiSvgIcon-root': {
            fontSize: '1.3rem',
          },
        },
      },
    },

    MuiRadio: {
      styleOverrides: {
        root: {
          '& .MuiSvgIcon-root': {
            fontSize: '1.3rem',
          },
        },
      },
    },

    // ▸ Stepper — pixel steps
    MuiStepLabel: {
      styleOverrides: {
        label: {
          fontFamily: FONT.pixel,
          fontSize: '0.85rem',
        },
      },
    },
  },
});

export default pixelTheme;
export { COZY };
