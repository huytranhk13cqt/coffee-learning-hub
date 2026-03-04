import { useMemo } from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

import DashboardIcon from '@mui/icons-material/Dashboard';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import ScienceIcon from '@mui/icons-material/Science';
import PsychologyIcon from '@mui/icons-material/Psychology';
import PaletteIcon from '@mui/icons-material/Palette';
import BusinessIcon from '@mui/icons-material/Business';
import SchoolIcon from '@mui/icons-material/School';
import CodeIcon from '@mui/icons-material/Code';
import CalculateIcon from '@mui/icons-material/Calculate';
import HistoryIcon from '@mui/icons-material/History';
import LanguageIcon from '@mui/icons-material/Language';
import MusicNoteIcon from '@mui/icons-material/MusicNote';
import BiotechIcon from '@mui/icons-material/Biotech';
import AccountBalanceIcon from '@mui/icons-material/AccountBalance';
import TrendingUpIcon from '@mui/icons-material/TrendingUp';
import LightbulbIcon from '@mui/icons-material/Lightbulb';
import BuildIcon from '@mui/icons-material/Build';
import LocalHospitalIcon from '@mui/icons-material/LocalHospital';
import PublicIcon from '@mui/icons-material/Public';
import AutoStoriesIcon from '@mui/icons-material/AutoStories';
import FolderOpenIcon from '@mui/icons-material/FolderOpen';
import CategoryIcon from '@mui/icons-material/Category';
import AssignmentIcon from '@mui/icons-material/Assignment';
import ExtensionIcon from '@mui/icons-material/Extension';
import ExploreIcon from '@mui/icons-material/Explore';
import VisibilityIcon from '@mui/icons-material/Visibility';
import EmojiObjectsIcon from '@mui/icons-material/EmojiObjects';
import ArchitectureIcon from '@mui/icons-material/Architecture';
import HandymanIcon from '@mui/icons-material/Handyman';
import AnalyticsIcon from '@mui/icons-material/Analytics';

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
