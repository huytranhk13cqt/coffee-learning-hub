import { useMemo } from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

import {
  DashboardIcon,
  MenuBookIcon,
  ScienceIcon,
  PsychologyIcon,
  PaletteIcon,
  BusinessIcon,
  SchoolIcon,
  CodeIcon,
  CalculateIcon,
  HistoryIcon,
  LanguageIcon,
  MusicNoteIcon,
  BiotechIcon,
  AccountBalanceIcon,
  TrendingUpIcon,
  LightbulbIcon,
  BuildIcon,
  LocalHospitalIcon,
  PublicIcon,
  AutoStoriesIcon,
  FolderOpenIcon,
  CategoryIcon,
  AssignmentIcon,
  ExtensionIcon,
  ExploreIcon,
  VisibilityIcon,
  EmojiObjectsIcon,
  ArchitectureIcon,
  HandymanIcon,
  AnalyticsIcon,
} from '../pixel/icons.jsx';

const ICON_MAP = {
  Dashboard: DashboardIcon,
  MenuBook: MenuBookIcon,
  Science: ScienceIcon,
  Psychology: PsychologyIcon,
  Palette: PaletteIcon,
  Business: BusinessIcon,
  School: SchoolIcon,
  Code: CodeIcon,
  Calculate: CalculateIcon,
  History: HistoryIcon,
  Language: LanguageIcon,
  MusicNote: MusicNoteIcon,
  Biotech: BiotechIcon,
  AccountBalance: AccountBalanceIcon,
  TrendingUp: TrendingUpIcon,
  Lightbulb: LightbulbIcon,
  Build: BuildIcon,
  LocalHospital: LocalHospitalIcon,
  Public: PublicIcon,
  AutoStories: AutoStoriesIcon,
  FolderOpen: FolderOpenIcon,
  Category: CategoryIcon,
  Assignment: AssignmentIcon,
  Extension: ExtensionIcon,
  Explore: ExploreIcon,
  Visibility: VisibilityIcon,
  EmojiObjects: EmojiObjectsIcon,
  Architecture: ArchitectureIcon,
  Handyman: HandymanIcon,
  Analytics: AnalyticsIcon,
};

const ICON_OPTIONS = Object.keys(ICON_MAP);

export default function IconPickerField({
  value,
  onChange,
  label,
  error,
  helperText,
}) {
  const SelectedIcon = value ? ICON_MAP[value] : null;

  const renderOption = useMemo(
    () =>
      function OptionRenderer(props, option) {
        const Icon = ICON_MAP[option];
        return (
          <Box
            component="li"
            {...props}
            key={option}
            sx={{ display: 'flex', alignItems: 'center', gap: 1 }}
          >
            {Icon && <Icon fontSize="small" />}
            <Typography variant="body2">{option}</Typography>
          </Box>
        );
      },
    [],
  );

  return (
    <Autocomplete
      options={ICON_OPTIONS}
      value={value || null}
      onChange={(_, newVal) => onChange(newVal || '')}
      renderOption={renderOption}
      renderInput={(params) => (
        <TextField
          {...params}
          label={label || 'Icon'}
          size="small"
          variant="outlined"
          error={error}
          helperText={helperText}
          slotProps={{
            input: {
              ...params.InputProps,
              startAdornment: SelectedIcon ? (
                <SelectedIcon fontSize="small" sx={{ mr: 1 }} />
              ) : null,
            },
          }}
        />
      )}
      sx={{ mb: 2 }}
    />
  );
}

export { ICON_MAP };
