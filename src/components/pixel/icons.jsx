/**
 * Pixel Art Icon Library — pixelarticons wrapped in MUI SvgIcon.
 *
 * Uses MUI's createSvgIcon factory (same as @mui/icons-material internals)
 * so every icon supports: fontSize, color, sx, titleAccess, etc.
 *
 * Source: pixelarticons v1.8.2 (24×24 grid, fill="currentColor")
 * Mapping: ~90 MUI icon names → pixelarticons equivalents
 */
import SvgIcon from '@mui/material/SvgIcon';

// ---------------------------------------------------------------------------
// Helper — all pixelarticons use viewBox="0 0 24 24" and fill="currentColor"
// which matches SvgIcon defaults perfectly.
// ---------------------------------------------------------------------------
function px(pathData, displayName) {
  const Icon = (props) => (
    <SvgIcon {...props}>
      <path d={pathData} fill="currentColor" />
    </SvgIcon>
  );
  Icon.displayName = displayName;
  Icon.muiName = 'SvgIcon';
  return Icon;
}

// ---------------------------------------------------------------------------
// Navigation & Arrows
// ---------------------------------------------------------------------------
export const ArrowBackIcon = px(
  'M20 11v2H8v2H6v-2H4v-2h2V9h2v2h12zM10 7H8v2h2V7zm0 0h2V5h-2v2zm0 10H8v-2h2v2zm0 0h2v2h-2v-2z',
  'ArrowBack',
);
export const ArrowForwardIcon = px(
  'M4 11v2h12v2h2v-2h2v-2h-2V9h-2v2H4zm10-4h2v2h-2V7zm0 0h-2V5h2v2zm0 10h2v-2h-2v2zm0 0h-2v2h2v-2z',
  'ArrowForward',
);
export const ArrowUpIcon = px(
  'M11 20h2V8h2V6h-2V4h-2v2H9v2h2v12zM7 10V8h2v2H7zm0 0v2H5v-2h2zm10 0V8h-2v2h2zm0 0v2h2v-2h-2z',
  'ArrowUp',
);
export const ChevronLeftIcon = px(
  'M16 5v2h-2V5h2zm-4 4V7h2v2h-2zm-2 2V9h2v2h-2zm0 2H8v-2h2v2zm2 2v-2h-2v2h2zm0 0h2v2h-2v-2zm4 4v-2h-2v2h2z',
  'ChevronLeft',
);
export const ChevronRightIcon = px(
  'M8 5v2h2V5H8zm4 4V7h-2v2h2zm2 2V9h-2v2h2zm0 2h2v-2h-2v2zm-2 2v-2h2v2h-2zm0 0h-2v2h2v-2zm-4 4v-2h2v2H8z',
  'ChevronRight',
);
export const ExpandMoreIcon = px(
  'M7 8H5v2h2v2h2v2h2v2h2v-2h2v-2h2v-2h2V8h-2v2h-2v2h-2v2h-2v-2H9v-2H7V8z',
  'ExpandMore',
);
export const ExpandLessIcon = px(
  'M7 16H5v-2h2v-2h2v-2h2V8h2v2h2v2h2v2h2v2h-2v-2h-2v-2h-2v-2h-2v2H9v2H7v2z',
  'ExpandLess',
);

// ---------------------------------------------------------------------------
// Actions — CRUD & Common
// ---------------------------------------------------------------------------
export const AddIcon = px('M11 4h2v7h7v2h-7v7h-2v-7H4v-2h7V4z', 'Add');
export const DeleteIcon = px(
  'M16 2v4h6v2h-2v14H4V8H2V6h6V2h8zm-2 2h-4v2h4V4zm0 4H6v12h12V8h-4zm-5 2h2v8H9v-8zm6 0h-2v8h2v-8z',
  'Delete',
);
export const EditIcon = px(
  'M18 2h-2v2h-2v2h-2v2h-2v2H8v2H6v2H4v2H2v6h6v-2h2v-2h2v-2h2v-2h2v-2h2v-2h2V8h2V6h-2V4h-2V2zm0 8h-2v2h-2v2h-2v2h-2v2H8v-2H6v-2h2v-2h2v-2h2V8h2V6h2v2h2v2zM6 16H4v4h4v-2H6v-2z',
  'Edit',
);
export const SaveIcon = px(
  'M4 2h14v2H4v16h2v-6h12v6h2V6h2v16H2V2h2zm4 18h8v-4H8v4zM20 6h-2V4h2v2zM6 6h9v4H6V6z',
  'Save',
);
export const SearchIcon = px(
  'M6 2h8v2H6V2zM4 6V4h2v2H4zm0 8H2V6h2v8zm2 2H4v-2h2v2zm8 0v2H6v-2h8zm2-2h-2v2h2v2h2v2h2v2h2v-2h-2v-2h-2v-2h-2v-2zm0-8h2v8h-2V6zm0 0V4h-2v2h2z',
  'Search',
);
export const ClearIcon = px(
  'M5 5h2v2H5V5zm4 4H7V7h2v2zm2 2H9V9h2v2zm2 0h-2v2H9v2H7v2H5v2h2v-2h2v-2h2v-2h2v2h2v2h2v2h2v-2h-2v-2h-2v-2h-2v-2zm2-2v2h-2V9h2zm2-2v2h-2V7h2zm0 0V5h2v2h-2z',
  'Clear',
);
export const CloseIcon = ClearIcon;
export const ContentCopyIcon = px(
  'M4 2h11v2H6v13H4V2zm4 4h12v16H8V6zm2 2v12h8V8h-8z',
  'ContentCopy',
);
export const DragIndicatorIcon = px(
  'M5 3H3v2h2V3zm14 4h2v6h-2V9H9v10h4v2H7V7h12zM7 3h2v2H7V3zM5 7H3v2h2V7zm-2 4h2v2H3v-2zm2 4H3v2h2v-2zm6-12h2v2h-2V3zm6 0h-2v2h2V3zm-2 14v-2h6v2h-2v2h-2v2h-2v-4zm4 2v2h2v-2h-2z',
  'DragIndicator',
);

// ---------------------------------------------------------------------------
// Status & Feedback
// ---------------------------------------------------------------------------
export const CheckCircleIcon = px(
  'M18 6h2v2h-2V6zm-2 4V8h2v2h-2zm-2 2v-2h2v2h-2zm-2 2h2v-2h-2v2zm-2 2h2v-2h-2v2zm-2 0v2h2v-2H8zm-2-2h2v2H6v-2zm0 0H4v-2h2v2z',
  'CheckCircle',
);
export const CheckCircleOutlineIcon = CheckCircleIcon;
export const CancelIcon = px(
  'M5 3H3v18h18V3H5zm14 2v14H5V5h14zm-8 4H9V7H7v2h2v2h2v2H9v2H7v2h2v-2h2v-2h2v2h2v2h2v-2h-2v-2h-2v-2h2V9h2V7h-2v2h-2v2h-2V9z',
  'Cancel',
);
export const ErrorIcon = px(
  'M13 1h-2v2H9v2H7v2H5v2H3v2H1v2h2v2h2v2h2v2h2v2h2v2h2v-2h2v-2h2v-2h2v-2h2v-2h2v-2h-2V9h-2V7h-2V5h-2V3h-2V1zm0 2v2h2v2h2v2h2v2h2v2h-2v2h-2v2h-2v2h-2v2h-2v-2H9v-2H7v-2H5v-2H3v-2h2V9h2V7h2V5h2V3h2zm0 4h-2v6h2V7zm0 8h-2v2h2v-2z',
  'Error',
);
export const WarningAmberIcon = ErrorIcon;
export const InfoOutlinedIcon = px(
  'M3 3h2v18H3V3zm16 0H5v2h14v14H5v2h16V3h-2zm-8 6h2V7h-2v2zm2 8h-2v-6h2v6z',
  'InfoOutlined',
);
export const CheckDoubleIcon = px(
  'M15 6h2v2h-2V6zm-2 4V8h2v2h-2zm-2 2v-2h2v2h-2zm-2 2v-2h2v2H9zm-2 2v-2h2v2H7zm-2 0h2v2H5v-2zm-2-2h2v2H3v-2zm0 0H1v-2h2v2zm8 2h2v2h-2v-2zm4-2v2h-2v-2h2zm2-2v2h-2v-2h2zm2-2v2h-2v-2h2zm2-2h-2v2h2V8zm0 0h2V6h-2v2z',
  'CheckDouble',
);
export const VerifiedIcon = CheckDoubleIcon;
export const MoodHappyIcon = px(
  'M5 3h14v2H5V3zm0 16H3V5h2v14zm14 0v2H5v-2h14zm0 0h2V5h-2v14zM10 8H8v2h2V8zm4 0h2v2h-2V8zm-5 6v-2H7v2h2zm6 0v2H9v-2h6zm0 0h2v-2h-2v2z',
  'MoodHappy',
);
export const EmojiEmotionsIcon = MoodHappyIcon;

// ---------------------------------------------------------------------------
// Media & Content
// ---------------------------------------------------------------------------
export const PlayArrowIcon = px(
  'M10 20H8V4h2v2h2v3h2v2h2v2h-2v2h-2v3h-2v2z',
  'PlayArrow',
);
export const PlayCircleOutlineIcon = PlayArrowIcon;
export const StopIcon = px(
  'M6 2h2v2H6V2Zm10 2h-2v2h-4V4H8v2H6v3H4V7H2v2h2v2h2v2H2v2h4v2H4v2H2v2h2v-2h2v3h8v-2H8V8h8v6h2v-3h2V9h2V7h-2v2h-2V6h-2V4Zm0 0V2h2v2h-2Zm-6 7h4v2h-4v-2Zm4 4h-4v2h4v-2Zm8 1h-6v6h6v-6Z',
  'Stop',
);
export const ReloadIcon = px(
  'M16 2h-2v2h2v2H4v2H2v5h2V8h12v2h-2v2h2v-2h2V8h2V6h-2V4h-2V2zM6 20h2v2h2v-2H8v-2h12v-2h2v-5h-2v5H8v-2h2v-2H8v2H6v2H4v2h2v2z',
  'Reload',
);
export const AutorenewIcon = ReloadIcon;
export const RepeatIcon = px(
  'M11 1H9v2h2v2H5v2H3v10h2v2h2v-2H5V7h6v2H9v2h2V9h2V7h2V5h-2V3h-2V1zm8 4h-2v2h2v10h-6v-2h2v-2h-2v2h-2v2H9v2h2v2h2v2h2v-2h-2v-2h6v-2h2V7h-2V5z',
  'Repeat',
);
export const DownloadIcon = px(
  'M13 17V3h-2v10H9v-2H7v2h2v2h2v2h2zm8 2v-4h-2v4H5v-4H3v6h18v-2zm-8-6v2h2v-2h2v-2h-2v2h-2z',
  'Download',
);
export const UploadIcon = px(
  'M11 5V3h2v2h2v2h2v2h-2V7h-2v10h-2V7H9v2H7V7h2V5h2zM3 15v6h18v-6h-2v4H5v-4H3z',
  'Upload',
);
export const UploadFileIcon = UploadIcon;
export const PublishIcon = UploadIcon;
export const MusicNoteIcon = px(
  'M8 4h12v16h-8v-8h6V8h-8v12H2v-8h6V4zm0 10H4v4h4v-4zm10 0h-4v4h4v-4z',
  'MusicNote',
);
export const CameraAltIcon = px(
  'M9 3H7v2H2v16h20V5h-5V3H9zm8 4h3v12H4V7h5V5h6v2h2zm-7 2h4v2h-4V9zm4 6h-4v2h4v-2h2v-4h-2v4zm-6-4h2v4H8v-4z',
  'CameraAlt',
);

// ---------------------------------------------------------------------------
// Data & Charts
// ---------------------------------------------------------------------------
export const BarChartIcon = px(
  'M13 5h2v14h-2V5zm-2 4H9v10h2V9zm-4 4H5v6h2v-6zm12 0h-2v6h2v-6z',
  'BarChart',
);
export const AnalyticsIcon = px(
  'M3 3h18v18H3V3zm16 2H5v14h14V5zM7 12h2v5H7v-5zm10-5h-2v10h2V7zm-6 3h2v2h-2v-2zm2 4h-2v3h2v-3z',
  'Analytics',
);
export const TrendingUpIcon = px(
  'M14 6h8v8h-2v-4h-2V8h-4V6zm2 6v-2h2v2h-2zm-2 2v-2h2v2h-2zm-2 0h2v2h-2v-2zm-2-2h2v2h-2v-2zm-2 0v-2h2v2H8zm-2 2v-2h2v2H6zm-2 2v-2h2v2H4zm0 0v2H2v-2h2z',
  'TrendingUp',
);
export const TimelineIcon = px(
  'M7 7h4v4H7V7zm-2 6v-2h2v2H5zm0 0v4H1v-4h4zm8 0h-2v-2h2v2zm4 0h-4v4h4v-4zm2-2v2h-2v-2h2zm0 0h4V7h-4v4z',
  'Timeline',
);

// ---------------------------------------------------------------------------
// Books & Learning
// ---------------------------------------------------------------------------
export const MenuBookIcon = px(
  'M3 3h8v2H3v12h8V5h2v12h8V5h-8V3h10v16H13v2h-2v-2H1V3h2zm16 7h-4v2h4v-2zm-4-3h4v2h-4V7zm2 6h-2v2h2v-2z',
  'MenuBook',
);
export const AutoStoriesIcon = MenuBookIcon;
export const BookIcon = px(
  'M8 2h12v20H4V2h4zm4 8h-2v2H8V4H6v16h12V4h-4v8h-2v-2z',
  'Book',
);
export const ArticleIcon = px(
  'M5 3H3v18h18V3H5zm14 2v14H5V5h14zm-2 2H7v2h10V7zM7 11h10v2H7v-2zm7 4H7v2h7v-2z',
  'Article',
);
export const SchoolIcon = px(
  'M9 2H5v4h4V2zm7 7V7H2v9h2v6h2v-6h2v6h2V9h6zm-5-7h11v14H11v-2h9V4h-9V2z',
  'School',
);
export const TranslateIcon = px(
  'M2 7h10v10H2V7zm8 8V9H4v6h6zm12-8h-8v2h8V7zm-8 4h8v2h-8v-2zm8 4h-8v2h8v-2z',
  'Translate',
);

// ---------------------------------------------------------------------------
// Bookmarks
// ---------------------------------------------------------------------------
export const BookmarkIcon = px(
  'M18 2H6v2h12v16h-2v-2h-2v-2h-4v2H8v2H6V2H4v20h4v-2h2v-2h4v2h2v2h4V2h-2z',
  'Bookmark',
);
export const BookmarkBorderIcon = BookmarkIcon;
export const BookmarkRemoveIcon = px(
  'M21 18V2H7v2h12v14h2zM5 6H3v16h4v-2h2v-2h2v2h2v2h4V6H5zm8 14v-2h-2v-2H9v2H7v2H5V8h10v12h-2z',
  'BookmarkRemove',
);

// ---------------------------------------------------------------------------
// Time & History
// ---------------------------------------------------------------------------
export const AccessTimeIcon = px(
  'M19 3H5v2H3v14h2v2h14v-2h2V5h-2V3zm0 2v14H5V5h14zm-8 2h2v6h4v2h-6V7z',
  'AccessTime',
);
export const HistoryIcon = AccessTimeIcon;

// ---------------------------------------------------------------------------
// Gamification & Achievements
// ---------------------------------------------------------------------------
export const EmojiEventsIcon = px(
  'M16 3H6v2H2v10h6V5h8v10h6V5h-4V3h-2zm4 4v6h-2V7h2zM6 13H4V7h2v6zm12 2H6v2h12v-2zm-7 2h2v2h3v2H8v-2h3v-2z',
  'EmojiEvents',
);
export const TrophyIcon = EmojiEventsIcon;
export const MilitaryTechIcon = EmojiEventsIcon;
export const BoltIcon = px(
  'M12 1h2v8h8v4h-2v-2h-8V5h-2V3h2V1zM8 7V5h2v2H8zM6 9V7h2v2H6zm-2 2V9h2v2H4zm10 8v2h-2v2h-2v-8H2v-4h2v2h8v6h2zm2-2v2h-2v-2h2zm2-2v2h-2v-2h2zm0 0h2v-2h-2v2z',
  'Bolt',
);
export const LocalFireDepartmentIcon = BoltIcon;
export const WhatshotIcon = BoltIcon;
export const StarIcon = px(
  'M16 3H6v2H2v10h6V5h8v10h6V5h-4V3h-2zm4 4v6h-2V7h2zM6 13H4V7h2v6zm12 2H6v2h12v-2zm-7 2h2v2h3v2H8v-2h3v-2z',
  'Star',
);
export const StarBorderIcon = StarIcon;
export const StarRateIcon = StarIcon;
export const AutoAwesomeIcon = px(
  'M13 2h-2v4h2V2Zm2 6H9v2H7v4h2v4h6v-4h2v-4h-2V8Zm0 2v4h-2v2h-2v-2H9v-4h6ZM9 20h6v2H9v-2Zm14-9v2h-4v-2h4ZM5 13v-2H1v2h4Zm12-7h2v2h-2V6Zm2 0h2V4h-2v2ZM5 6h2v2H5V6Zm0 0V4H3v2h2Z',
  'AutoAwesome',
);
export const LightbulbOnIcon = AutoAwesomeIcon;
export const EmojiObjectsIcon = px(
  'M8 2h8v2H8V2ZM6 6V4h2v2H6Zm0 6H4V6h2v6Zm2 2H6v-2h2v2Zm8 0v4H8v-4h2v2h4v-2h2Zm2-2v2h-2v-2h2Zm0-6h2v6h-2V6Zm0 0V4h-2v2h2Zm-2 14H8v2h8v-2Z',
  'EmojiObjects',
);
export const FlagIcon = px(
  'M3 2h10v2h8v14H11v-2H5v6H3V2zm2 12h8v2h6V6h-8V4H5v10z',
  'Flag',
);
export const FitnessCenterIcon = px(
  'M10 2h4v4h-4V2zM7 7h10v2h-2v13h-2v-6h-2v6H9V9H7V7zM5 5v2h2V5H5zm0 0H3V3h2v2zm14 0v2h-2V5h2zm0 0V3h2v2h-2z',
  'FitnessCenter',
);

// ---------------------------------------------------------------------------
// Layout & Dashboard
// ---------------------------------------------------------------------------
export const DashboardIcon = px(
  'M3 3h8v10H3V3zm2 2v6h4V5H5zm8-2h8v6h-8V3zm2 2v2h4V5h-4zm-2 6h8v10h-8V11zm2 2v6h4v-6h-4zM3 15h8v6H3v-6zm2 2v2h4v-2H5z',
  'Dashboard',
);
export const MenuIcon = px(
  'M4 6h16v2H4V6zm0 5h16v2H4v-2zm16 5H4v2h16v-2z',
  'Menu',
);
export const ListAltIcon = px(
  'M6 6H4v2h2V6zm14 0H8v2h12V6zM4 11h2v2H4v-2zm16 0H8v2h12v-2zM4 16h2v2H4v-2zm16 0H8v2h12v-2z',
  'ListAlt',
);
export const ChecklistIcon = px(
  'M19 4h2v2h-2V4zm-2 4V6h2v2h-2zm-2 0h2v2h-2V8zm0 0h-2V6h2v2zM3 6h8v2H3V6zm8 10H3v2h8v-2zm7 2v-2h2v-2h-2v2h-2v-2h-2v2h2v2h-2v2h2v-2h2zm0 0v2h2v-2h-2z',
  'Checklist',
);

// ---------------------------------------------------------------------------
// Admin & Settings
// ---------------------------------------------------------------------------
export const SettingsIcon = px(
  'M17 4h2v10h-2V4zm0 12h-2v2h2v2h2v-2h2v-2h-4zm-4-6h-2v10h2V10zm-8 2H3v2h2v6h2v-6h2v-2H5zm8-8h-2v2H9v2h6V6h-2V4zM5 4h2v6H5V4z',
  'Settings',
);
export const LockIcon = px(
  'M15 2H9v2H7v4H4v14h16V8h-3V4h-2V2zm0 2v4H9V4h6zm-6 6h9v10H6V10h3zm4 3h-2v4h2v-4z',
  'Lock',
);
export const LogoutIcon = px(
  'M5 3h16v4h-2V5H5v14h14v-2h2v4H3V3h2zm16 8h-2V9h-2V7h-2v2h2v2H7v2h10v2h-2v2h2v-2h2v-2h2v-2z',
  'Logout',
);
export const LightModeIcon = px(
  'M13 3h-2v2h2V3zm4 2h2v2h-2V5zm-6 6h2v2h-2v-2zm-8 0h2v2H3v-2zm18 0h-2v2h2v-2zM5 5h2v2H5V5zm14 14h-2v-2h2v2zm-8 2h2v-2h-2v2zm-4-2H5v-2h2v2zM9 7h6v2H9V7zm0 8H7V9h2v6zm0 0v2h6v-2h2V9h-2v6H9z',
  'LightMode',
);
export const DarkModeIcon = px(
  'M6 2h8v2h-2v2h-2V4H6V2ZM4 6V4h2v2H4Zm0 10H2V6h2v10Zm2 2H4v-2h2v2Zm2 2H6v-2h2v2Zm10 0v2H8v-2h10Zm2-2v2h-2v-2h2Zm-2-4h2v4h2v-8h-2v2h-2v2Zm-6 0v2h6v-2h-6Zm-2-2h2v2h-2v-2Zm0 0V6H8v6h2Z',
  'DarkMode',
);
export const TrackChangesIcon = px(
  'M11 2H2v20h20V4h-2v16H4V4h7v2H6v12h12V8h-2v8H8V8h3v2h-1v4h4v-4h-1V2h-2z',
  'TrackChanges',
);

// ---------------------------------------------------------------------------
// Files & Folders
// ---------------------------------------------------------------------------
export const FolderIcon = px(
  'M4 4h8v2h10v14H2V4h2zm16 4H10V6H4v12h16V8z',
  'Folder',
);
export const FolderOpenIcon = FolderIcon;
export const CategoryIcon = px(
  'M12 2H2v10h2v2h2v2h2v2h2v2h2v2h2v-2h2v-2h2v-2h2v-2h2v-2h-2v-2h-2V8h-2V6h-2V4h-2V2zm0 2v2h2v2h2v2h2v2h2v2h-2v2h-2v2h-2v2h-2v-2h-2v-2H8v-2H6v-2H4V4h8zM6 6h2v2H6V6z',
  'Category',
);
export const ClipboardIcon = px(
  'M10 2h6v2h4v18H4V4h4V2h2zm6 4v2H8V6H6v14h12V6h-2zm-2 0V4h-4v2h4z',
  'Clipboard',
);
export const AssignmentIcon = ClipboardIcon;

// ---------------------------------------------------------------------------
// People & Users
// ---------------------------------------------------------------------------
export const UsersIcon = px(
  'M11 0H5v2H3v6h2v2h6V8H5V2h6V0zm0 2h2v6h-2V2zM0 14h2v4h12v2H0v-6zm2 0h12v-2H2v2zm14 0h-2v6h2v-6zM15 0h4v2h-4V0zm4 8h-4v2h4V8zm0-6h2v6h-2V2zm5 12h-2v4h-4v2h6v-6zm-6-2h4v2h-4v-2z',
  'Users',
);
export const GroupsIcon = UsersIcon;
export const Diversity3Icon = UsersIcon;
export const HumanIcon = px(
  'M10 2h4v4h-4V2zM3 7h18v2h-6v13h-2v-6h-2v6H9V9H3V7z',
  'Human',
);
export const PsychologyIcon = HumanIcon;

// ---------------------------------------------------------------------------
// Communication
// ---------------------------------------------------------------------------
export const CampaignIcon = px(
  'M14 4V2h-4v2H5v2h14V4h-5zm5 12H5v-4H3v6h5v4h2v-4h4v2h-4v2h6v-4h5v-6h-2V6h-2v8h2v2zM5 6v8h2V6H5z',
  'Campaign',
);
export const CastIcon = px(
  'M4 3h18v18h-8v-2h6V5H4v4H2V3h2zm0 16H2v2h2v-2zm-2-4h4v2H2v-2zm8-4H2v2h8v8h2V11h-2zm-4 4h2v6H6v-6z',
  'Cast',
);
export const CastForEducationIcon = CastIcon;

// ---------------------------------------------------------------------------
// Gaming & Fun
// ---------------------------------------------------------------------------
export const GamepadIcon = px(
  'M2 5h20v14H2V5zm18 12V7H4v10h16zM8 9h2v2h2v2h-2v2H8v-2H6v-2h2V9zm6 0h2v2h-2V9zm4 4h-2v2h2v-2z',
  'Gamepad',
);
export const SportsEsportsIcon = GamepadIcon;
export const ExtensionIcon = GamepadIcon;

// ---------------------------------------------------------------------------
// Science & Tech
// ---------------------------------------------------------------------------
export const CodeIcon = px(
  'M8 5h2v2H8V5zM6 7h2v2H6V7zM4 9h2v2H4V9zm-2 2h2v2H2v-2zm2 2h2v2H4v-2zm2 2h2v2H6v-2zm2 2h2v2H8v-2zm8-12h-2v2h2V5zm2 2h-2v2h2V7zm2 2h-2v2h2V9zm2 2h-2v2h2v-2zm-2 2h-2v2h2v-2zm-2 2h-2v2h2v-2zm-2 2h-2v2h2v-2z',
  'Code',
);
export const ScienceIcon = px(
  'M6 3h14v2h2v6h-2v8h-2V5H6V3zm8 14v-2H6V5H4v10H2v4h2v2h14v-2h-2v-2h-2zm0 0v2H4v-2h10zM8 7h8v2H8V7zm8 4H8v2h8v-2z',
  'Science',
);
export const BiotechIcon = ScienceIcon;
export const DevicesIcon = px(
  'M2 2h16v6h4v14H12v-6H2V2zm14 6V4H4v10h8V8h4zm-6-2H6v2h4V6zm10 14V10h-6v10h6zm-4-4h2v2h-2v-2zM6 10h4v2H6v-2z',
  'Devices',
);
export const DeveloperBoardIcon = px(
  'M20 3H2v14h8v2H8v2h8v-2h-2v-2h8V3h-2zm-6 12H4V5h16v10h-6z',
  'DeveloperBoard',
);
export const RouterIcon = px(
  'M19 2h-8v2H9v2h2V4h8v2h2V4h-2V2zm-8 6h2v2h-2V8zm6 0V6h-4v2h4zm0 0h2v2h-2V8zm-1 2h-2v2H2v10h20V12h-6v-2zm4 4v6H4v-6h16zm-2 2h-2v2h2v-2zm-6 0h2v2h-2v-2z',
  'Router',
);

// ---------------------------------------------------------------------------
// Nature & World
// ---------------------------------------------------------------------------
export const PublicIcon = px(
  'M13 2v4h5v5h4v2h-4v5h-5v4h-2v-4H6v-5H2v-2h4V6h5V2h2zM8 8v8h8V8H8zm2 2h4v4h-4v-4z',
  'Public',
);
export const LanguageIcon = PublicIcon;
export const TravelExploreIcon = PublicIcon;
export const ExploreIcon = PublicIcon;
export const NatureIcon = px(
  'M14 2h-4v2H8v2H6v2H4v2H2v12h20V10h-2V8h-2V6h-2V4h-2V2zm0 2v2h2v2h2v4h-2v2h-2v2h-4v-2H8v-2H6V8h2V6h2V4h4zm-8 8v2h2v2h2v2h4v-2h2v-2h2v-2h2v8H4v-8h2z',
  'Nature',
);
export const ParkIcon = NatureIcon;
export const GrassIcon = NatureIcon;
export const NightsStayIcon = px(
  'M20 0h2v2h2v2h-2v2h-2V4h-2V2h2V0ZM8 4h8v2h-2v2h-2V6H8V4ZM6 8V6h2v2H6Zm0 8H4V8h2v8Zm2 2H6v-2h2v2Zm8 0v2H8v-2h8Zm2-2v2h-2v-2h2Zm-2-4v-2h2V8h2v8h-2v-4h-2Zm-4 0h4v2h-4v-2Zm0 0V8h-2v4h2Zm-8 6H2v2H0v2h2v2h2v-2h2v-2H4v-2Z',
  'NightsStay',
);
export const MoonStarsIcon = NightsStayIcon;

// ---------------------------------------------------------------------------
// Commerce & Business
// ---------------------------------------------------------------------------
export const CoinIcon = px(
  'M6 2h12v2H6V2zM4 6V4h2v2H4zm0 12V6H2v12h2zm2 2v-2H4v2h2zm12 0v2H6v-2h12zm2-2v2h-2v-2h2zm0-12h2v12h-2V6zm0 0V4h-2v2h2zm-9-1h2v2h3v2h-6v2h6v6h-3v2h-2v-2H8v-2h6v-2H8V7h3V5z',
  'Coin',
);
export const SavingsIcon = CoinIcon;
export const BriefcaseIcon = px(
  'M8 3h8v4h6v14H2V7h6V3zm2 4h4V5h-4v2zM4 9v10h16V9H4z',
  'Briefcase',
);
export const BusinessCenterIcon = BriefcaseIcon;
export const BuildingIcon = px(
  'M3 2h18v20H3V2zm12 16v2h4V4H5v16h4v-2h6zM7 6h2v2H7V6zm6 0h-2v2h2V6zm2 0h2v2h-2V6zm-6 4H7v2h2v-2zm2 0h2v2h-2v-2zm6 0h-2v2h2v-2zM7 14h2v2H7v-2zm6 0h-2v2h2v-2zm4 0h-2v2h2v-2z',
  'Building',
);
export const BusinessIcon = BuildingIcon;
export const AccountBalanceIcon = BuildingIcon;
export const TruckIcon = px(
  'M2 4h14v4h4v2h-4v6h6v-4h2v6h-4v2h-4v-2H8v2H4v-2H0V4h2zm20 8h-2v-2h2v2zm-8-2V6H2v10h12v-6z',
  'Truck',
);
export const LocalShippingIcon = TruckIcon;

// ---------------------------------------------------------------------------
// Health & Wellness
// ---------------------------------------------------------------------------
export const HeartIcon = px(
  'M9 2H5v2H3v2H1v6h2v2h2v2h2v2h2v2h2v2h2v-2h2v-2h2v-2h2v-2h2v-2h2V6h-2V4h-2V2h-4v2h-2v2h-2V4H9V2zm0 2v2h2v2h2V6h2V4h4v2h2v6h-2v2h-2v2h-2v2h-2v2h-2v-2H9v-2H7v-2H5v-2H3V6h2V4h4z',
  'Heart',
);
export const LocalHospitalIcon = HeartIcon;
export const SportsMartialArtsIcon = px(
  'M10 3H8v2H6v2h2V5h2v2h2v2h-2v2H8v2H6v2H4v-2H2v2h2v2h2v-2h4v2h2v2h-2v2h2v-2h2v-2h-2v-4h2v-2h2v2h2v2h2v-2h2v-2h-2v2h-2v-2h-2V9h2V5h-4v2h-2V5h-2V3z',
  'SportsMartialArts',
);
export const RestaurantIcon = px(
  'M4 4h18v7h-4v5H4V4zm14 5h2V6h-2v3zm-2-3H6v8h10V6zm3 14H3v-2h16v2z',
  'Restaurant',
);

// ---------------------------------------------------------------------------
// Design & Art
// ---------------------------------------------------------------------------
export const PaintBucketIcon = px(
  'M8 3h8v2H8V3zm0 2H6v4H4v12h16V9h-2V5h-2v4H8V5zm8 6h2v8H6v-8h2v6h2v-4h2v2h2v-2h2v-2z',
  'PaintBucket',
);
export const BrushIcon = PaintBucketIcon;
export const PaletteIcon = px(
  'M14 2h8v20H12V2h2zm6 2h-6v16h6V4zM10 20H4v-6h6v-2H6v-2H4V8h2V6h2V4h2V2H8v2H6v2H4v2H2v2h2v2H2v10h8v-2zm8-4h-2v2h2v-2z',
  'Palette',
);
export const ColorSwatchIcon = PaletteIcon;
export const DesignServicesIcon = px(
  'M18 2h-2v2h2V2zM4 4h6v2H4v14h14v-6h2v8H2V4h2zm4 8H6v6h6v-2h2v-2h-2v2H8v-4zm4-2h-2v2H8v-2h2V8h2V6h2v2h-2v2zm2-6h2v2h-2V4zm4 0h2v2h2v2h-2v2h-2v2h-2v-2h2V8h2V6h-2V4zm-4 8h2v2h-2v-2z',
  'DesignServices',
);

// ---------------------------------------------------------------------------
// Security & Shields
// ---------------------------------------------------------------------------
export const ShieldIcon = px(
  'M22 2H2v12h2V4h16v10h2V2zM6 14H4v2h2v-2zm0 2h2v2h2v2H8v-2H6v-2zm4 4v2h4v-2h2v-2h-2v2h-4zm10-6h-2v2h-2v2h2v-2h2v-2z',
  'Shield',
);
export const SecurityIcon = ShieldIcon;
export const PolicyIcon = ShieldIcon;

// ---------------------------------------------------------------------------
// Maps & Location
// ---------------------------------------------------------------------------
export const GpsIcon = px(
  'M13 2v4h5v5h4v2h-4v5h-5v4h-2v-4H6v-5H2v-2h4V6h5V2h2zM8 8v8h8V8H8zm2 2h4v4h-4v-4z',
  'Gps',
);
export const RouteIcon = TimelineIcon;

// ---------------------------------------------------------------------------
// Law & Justice
// ---------------------------------------------------------------------------
export const GavelIcon = px(
  'M21 3h-8v2h4v2h2v4h2V3zm-4 4h-2v2h-2v2h2V9h2V7zm-8 8h2v-2H9v2H7v2h2v-2zm-4-2v4h2v2H5h6v2H3v-8h2z',
  'Gavel',
);
export const ScaleIcon = GavelIcon;

// ---------------------------------------------------------------------------
// Other UI
// ---------------------------------------------------------------------------
export const LightbulbIcon = px(
  'M8 2h8v2H8V2ZM6 6V4h2v2H6Zm0 6H4V6h2v6Zm2 2H6v-2h2v2Zm8 0v4H8v-4h2v2h4v-2h2Zm2-2v2h-2v-2h2Zm0-6h2v6h-2V6Zm0 0V4h-2v2h2Zm-2 14H8v2h8v-2Z',
  'Lightbulb',
);
export const VisibilityIcon = px(
  'M8 17h8v2H8v-2Zm8-2h4v2h-4v-2Zm-8 0H4v2h4v-2Zm8-8h4v2h-4V7ZM8 7H4v2h4V7Zm12 2h2v2h-2V9ZM4 9H2v2h2V9Zm18 2h2v2h-2v-2ZM2 11H0v2h2v-2Zm18 2h2v2h-2v-2ZM4 13H2v2h2v-2Zm4-8h8v2H8V5Zm2 5h4v4h-4v-4Z',
  'Visibility',
);
export const RadioButtonUncheckedIcon = px(
  'M17 3H7v2H5v2H3v10h2v2h2v2h10v-2h2v-2h2V7h-2V5h-2V3zm0 2v2h2v10h-2v2H7v-2H5V7h2V5h10zm-9 6h2v2h2v2h-2v-2H8v-2zm8-2h-2v2h-2v2h2v-2h2V9z',
  'RadioButtonUnchecked',
);
export const AutoFixHighIcon = BoltIcon;
export const ArchitectureIcon = NatureIcon;
export const CalculateIcon = px(
  'M5 2H3v20h18V2H5zm14 18H5V4h14v16zM17 6H7v4h10V6zM7 12h2v2H7v-2zm6 0h-2v2h2v-2zm2 0h2v2h-2v-2zm-6 4H7v2h2v-2zm2 0h2v2h-2v-2zm6 0h-2v2h2v-2z',
  'Calculate',
);
export const AccountTreeIcon = px(
  'M5 2h2v12h3v3h7v-7h-3V2h8v8h-3v9h-9v3H2v-8h3V2zm15 6V4h-4v4h4zM8 19v-3H4v4h4v-1z',
  'AccountTree',
);
export const HandshakeIcon = UsersIcon;
export const HandymanIcon = SettingsIcon;
export const TuneIcon = SettingsIcon;
export const WarningBoxIcon = px(
  'M3 3h16v2H5v14h14v2H3V3zm18 0h-2v18h2V3zM11 15h2v2h-2v-2zm2-8h-2v6h2V7z',
  'WarningBox',
);
export const InboxIcon = px(
  'M3 2h18v20H3V2zm2 2v10h4v2h6v-2h4V4H5zm14 12h-2v2H7v-2H5v4h14v-4z',
  'Inbox',
);

// ---------------------------------------------------------------------------
// Icon Picker Field — additional icons for admin topic/category selection
// ---------------------------------------------------------------------------
export const HistoryEduIcon = ScienceIcon;
export const BuildIcon = SettingsIcon;
