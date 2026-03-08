import { useState, useMemo } from 'react';
import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchHomePage } from '../api/groups.js';
import { fetchPaths } from '../api/paths.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import CardActionArea from '@mui/material/CardActionArea';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import Stack from '@mui/material/Stack';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import IconButton from '@mui/material/IconButton';
import InputAdornment from '@mui/material/InputAdornment';
import TextField from '@mui/material/TextField';
import Fade from '@mui/material/Fade';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import {
  PixelFrame,
  PixelProgressBar,
  PixelDivider,
} from '../components/pixel/index.js';
import { FONT, ANIMATION } from '../theme/pixelUtils.js';
import {
  RouteIcon,
  ArrowForwardIcon,
  MenuBookIcon,
  CodeIcon,
  BarChartIcon,
  SecurityIcon,
  RouterIcon,
  DeveloperBoardIcon,
  DevicesIcon,
  SportsEsportsIcon,
  ScienceIcon,
  ArrowUpIcon,
  NatureIcon,
  LocalHospitalIcon,
  FitnessCenterIcon,
  SportsMartialArtsIcon,
  NightsStayIcon,
  RestaurantIcon,
  PsychologyIcon,
  GroupsIcon,
  Diversity3Icon,
  PolicyIcon,
  CastForEducationIcon,
  AutoStoriesIcon,
  HistoryEduIcon,
  PublicIcon,
  LanguageIcon,
  GavelIcon,
  TranslateIcon,
  TrendingUpIcon,
  SavingsIcon,
  CampaignIcon,
  BusinessCenterIcon,
  HandshakeIcon,
  LocalShippingIcon,
  ExtensionIcon,
  DesignServicesIcon,
  MusicNoteIcon,
  BrushIcon,
  CameraAltIcon,
  BuildIcon,
  ShieldIcon,
  AccountTreeIcon,
  SchoolIcon,
  ArrowBackIcon,
  SearchIcon,
} from '../components/pixel/icons.jsx';

const RocketLaunchIcon = ArrowUpIcon;
const ParkIcon = NatureIcon;
const GrassIcon = NatureIcon;

import LessonStatusChip from '../components/progress/LessonStatusChip.jsx';
import ScoreBadge from '../components/progress/ScoreBadge.jsx';
import { DIFFICULTY_LABELS } from '../constants/difficulty.js';

// Icon mapping: topic.icon (DB string) → MUI component
const TOPIC_ICONS = {
  Code: CodeIcon,
  BarChart: BarChartIcon,
  Security: SecurityIcon,
  Router: RouterIcon,
  DeveloperBoard: DeveloperBoardIcon,
  Devices: DevicesIcon,
  SportsEsports: SportsEsportsIcon,
  Science: ScienceIcon,
  RocketLaunch: RocketLaunchIcon,
  Park: ParkIcon,
  Grass: GrassIcon,
  Nature: NatureIcon,
  LocalHospital: LocalHospitalIcon,
  FitnessCenter: FitnessCenterIcon,
  SportsMartialArts: SportsMartialArtsIcon,
  NightsStay: NightsStayIcon,
  Restaurant: RestaurantIcon,
  Psychology: PsychologyIcon,
  Groups: GroupsIcon,
  Diversity3: Diversity3Icon,
  Policy: PolicyIcon,
  CastForEducation: CastForEducationIcon,
  AutoStories: AutoStoriesIcon,
  HistoryEdu: HistoryEduIcon,
  Public: PublicIcon,
  Language: LanguageIcon,
  Gavel: GavelIcon,
  Translate: TranslateIcon,
  TrendingUp: TrendingUpIcon,
  Savings: SavingsIcon,
  Campaign: CampaignIcon,
  BusinessCenter: BusinessCenterIcon,
  Handshake: HandshakeIcon,
  LocalShipping: LocalShippingIcon,
  Extension: ExtensionIcon,
  DesignServices: DesignServicesIcon,
  MusicNote: MusicNoteIcon,
  Brush: BrushIcon,
  CameraAlt: CameraAltIcon,
  Build: BuildIcon,
  Shield: ShieldIcon,
  AccountTree: AccountTreeIcon,
  School: SchoolIcon,
  MenuBook: MenuBookIcon,
};

function getTopicLessonCount(topic) {
  return topic.groups.reduce((sum, g) => sum + g.lessons.length, 0);
}

export async function loader({ request }) {
  const [{ topics }, featuredPaths] = await Promise.all([
    fetchHomePage({ signal: request.signal }),
    fetchPaths({ signal: request.signal })
      .then((paths) => paths.filter((p) => p.is_featured).slice(0, 4))
      .catch(() => []),
  ]);
  return { topics, featuredPaths };
}

export default function HomePage() {
  const { topics, featuredPaths } = useLoaderData();
  const [selectedTopic, setSelectedTopic] = useState(null);
  const [search, setSearch] = useState('');
  useDocumentTitle(null);

  // Filter topics by search query (matches name or name_vi)
  const filteredTopics = useMemo(() => {
    if (!search.trim()) return topics;
    const q = search.trim().toLowerCase();
    return topics.filter(
      (t) =>
        t.name.toLowerCase().includes(q) || t.name_vi.toLowerCase().includes(q),
    );
  }, [topics, search]);

  function handleSelectTopic(topic) {
    setSelectedTopic(topic);
    setSearch('');
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  function handleBackToOverview() {
    setSelectedTopic(null);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  return (
    <Fade in timeout={300}>
      <div>
        {/* Featured Learning Paths (shown when not drilling into a topic) */}
        {!selectedTopic && featuredPaths.length > 0 && (
          <FeaturedPaths paths={featuredPaths} />
        )}

        {selectedTopic ? (
          <TopicDetailView
            topic={selectedTopic}
            onBack={handleBackToOverview}
          />
        ) : (
          <TopicOverview
            topics={filteredTopics}
            totalCount={topics.length}
            search={search}
            onSearchChange={setSearch}
            onSelectTopic={handleSelectTopic}
          />
        )}
      </div>
    </Fade>
  );
}

// ─────────────────────────────────────────────────
// Overview: Grid of all topic cards with search
// ─────────────────────────────────────────────────

function TopicOverview({
  topics,
  totalCount,
  search,
  onSearchChange,
  onSelectTopic,
}) {
  const totalLessons = topics.reduce(
    (sum, t) => sum + getTopicLessonCount(t),
    0,
  );

  return (
    <>
      <Typography
        variant="h4"
        component="h1"
        gutterBottom
        sx={{ fontFamily: FONT.pixel, fontSize: '1.4rem' }}
      >
        Learning Hub
      </Typography>
      <Typography variant="subtitle1" color="text.secondary" sx={{ mb: 3 }}>
        {totalCount} chủ đề · {totalLessons} bài học — Chọn chủ đề để bắt đầu
      </Typography>

      {/* Search bar */}
      <TextField
        size="small"
        placeholder="Tìm chủ đề..."
        value={search}
        onChange={(e) => onSearchChange(e.target.value)}
        slotProps={{
          input: {
            startAdornment: (
              <InputAdornment position="start">
                <SearchIcon fontSize="small" color="action" />
              </InputAdornment>
            ),
          },
        }}
        sx={{ mb: 3, maxWidth: 360, width: '100%' }}
      />

      {/* Topic cards grid */}
      <Grid container spacing={2}>
        {topics.map((topic, index) => (
          <Grid key={topic.id ?? 'other'} size={{ xs: 6, sm: 4, md: 3, lg: 2 }}>
            <TopicCard
              topic={topic}
              index={index}
              onClick={() => onSelectTopic(topic)}
            />
          </Grid>
        ))}
      </Grid>

      {topics.length === 0 && search && (
        <Typography color="text.secondary" sx={{ mt: 4, textAlign: 'center' }}>
          Không tìm thấy chủ đề phù hợp với &quot;{search}&quot;
        </Typography>
      )}
    </>
  );
}

function TopicCard({ topic, index = 0, onClick }) {
  const TopicIcon = TOPIC_ICONS[topic.icon] || MenuBookIcon;
  const lessonCount = getTopicLessonCount(topic);

  return (
    <PixelFrame
      variant="raised"
      glow
      sx={{
        height: '100%',
        cursor: 'pointer',
        '&:hover': {
          transform: 'translateY(-2px)',
        },
        ...ANIMATION.stagger(index),
      }}
    >
      <CardActionArea
        onClick={onClick}
        sx={{
          height: '100%',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          p: 2,
          textAlign: 'center',
          borderRadius: 0,
        }}
      >
        {/* Pixel square icon — no border-radius */}
        <Box
          sx={{
            width: 52,
            height: 52,
            bgcolor: topic.color + '18',
            border: '2px solid',
            borderColor: topic.color + '40',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            mb: 1.5,
          }}
        >
          <TopicIcon
            sx={{ color: topic.color, fontSize: 28, ...ANIMATION.float }}
          />
        </Box>
        <Typography
          variant="subtitle2"
          sx={{
            fontFamily: FONT.pixel,
            fontSize: '0.75rem',
            lineHeight: 1.4,
            mb: 0.5,
            overflow: 'hidden',
            textOverflow: 'ellipsis',
            display: '-webkit-box',
            WebkitLineClamp: 2,
            WebkitBoxOrient: 'vertical',
          }}
        >
          {topic.name_vi}
        </Typography>
        <Chip
          label={`${lessonCount} bài học`}
          size="small"
          sx={{
            height: 22,
            fontSize: '0.7rem',
            bgcolor: topic.color + '18',
            color: topic.color,
          }}
        />
      </CardActionArea>
    </PixelFrame>
  );
}

// ─────────────────────────────────────────────────
// Detail: Selected topic's categories + lessons
// ─────────────────────────────────────────────────

function TopicDetailView({ topic, onBack }) {
  const TopicIcon = TOPIC_ICONS[topic.icon] || MenuBookIcon;
  const lessonCount = getTopicLessonCount(topic);

  return (
    <>
      {/* Breadcrumb navigation */}
      <Breadcrumbs sx={{ mb: 2 }}>
        <Link
          component="button"
          variant="body2"
          underline="hover"
          onClick={onBack}
          sx={{
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            gap: 0.5,
          }}
        >
          <ArrowBackIcon sx={{ fontSize: 16 }} />
          Tất cả chủ đề
        </Link>
        <Typography variant="body2" color="text.primary" fontWeight={600}>
          {topic.name_vi}
        </Typography>
      </Breadcrumbs>

      {/* Topic header */}
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 3 }}>
        <Box
          sx={{
            width: 56,
            height: 56,
            bgcolor: topic.color + '18',
            border: '2px solid',
            borderColor: topic.color + '40',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            flexShrink: 0,
            boxShadow: '2px 2px 0 0 rgba(0,0,0,0.08)',
          }}
        >
          <TopicIcon sx={{ color: topic.color, fontSize: 32 }} />
        </Box>
        <Box sx={{ flex: 1, minWidth: 0 }}>
          <Typography
            variant="h4"
            component="h1"
            sx={{ lineHeight: 1.3, fontFamily: FONT.pixel }}
          >
            {topic.name}
          </Typography>
          <Typography variant="body1" color="text.secondary">
            {topic.name_vi} · {lessonCount} bài học · {topic.groups.length} nhóm
          </Typography>
        </Box>
        <IconButton
          onClick={onBack}
          aria-label="Quay lại"
          sx={{ display: { xs: 'flex', sm: 'none' } }}
        >
          <ArrowBackIcon />
        </IconButton>
      </Box>

      <PixelDivider sx={{ mb: 3 }} />

      {/* Category cards */}
      <Grid container spacing={3}>
        {topic.groups.map((group) => (
          <Grid key={group.id} size={{ xs: 12, sm: 6, md: 4 }}>
            <CategoryCard group={group} />
          </Grid>
        ))}
      </Grid>

      {/* Back button at bottom for long lists */}
      {topic.groups.length > 2 && (
        <Box sx={{ mt: 4, textAlign: 'center' }}>
          <Chip
            icon={<ArrowBackIcon />}
            label="Quay lại tất cả chủ đề"
            onClick={onBack}
            variant="outlined"
            sx={{ cursor: 'pointer' }}
          />
        </Box>
      )}
    </>
  );
}

// ─────────────────────────────────────────────────
// Featured Learning Paths strip
// ─────────────────────────────────────────────────

function FeaturedPaths({ paths }) {
  return (
    <Box sx={{ mb: 4 }}>
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          mb: 1.5,
        }}
      >
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
          <RouteIcon sx={{ color: 'primary.main' }} />
          <Typography variant="h6" fontWeight={700}>
            Lộ trình học tập
          </Typography>
        </Box>
        <Link
          component={RouterLink}
          to="/paths"
          underline="hover"
          variant="body2"
          sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}
        >
          Xem tất cả <ArrowForwardIcon sx={{ fontSize: 16 }} />
        </Link>
      </Box>

      <Box
        sx={{
          display: 'flex',
          gap: 2,
          overflowX: 'auto',
          pb: 1,
          '&::-webkit-scrollbar': { height: 4 },
          '&::-webkit-scrollbar-thumb': {
            borderRadius: 2,
            bgcolor: 'action.hover',
          },
        }}
      >
        {paths.map((path) => (
          <PixelFrame
            key={path.id}
            variant="raised"
            sx={{
              p: 2,
              minWidth: 200,
              maxWidth: 240,
              flexShrink: 0,
              textDecoration: 'none',
              color: 'inherit',
              borderTop: '3px solid',
              borderTopColor: path.color,
            }}
            component={RouterLink}
            to={`/paths/${path.slug}`}
          >
            <Typography
              variant="subtitle2"
              sx={{
                fontFamily: FONT.pixel,
                fontSize: '0.8rem',
                overflow: 'hidden',
                textOverflow: 'ellipsis',
                whiteSpace: 'nowrap',
                mb: 0.5,
              }}
            >
              {path.name_vi}
            </Typography>
            <Typography
              variant="caption"
              color="text.secondary"
              display="block"
              sx={{ mb: 1 }}
            >
              {path.total_steps} bài · {path.estimated_days} ngày
            </Typography>
            {path.progress_percent > 0 && (
              <PixelProgressBar
                value={path.progress_percent}
                segments={5}
                color="primary.main"
                height={6}
              />
            )}
          </PixelFrame>
        ))}
      </Box>
    </Box>
  );
}

function CategoryCard({ group }) {
  return (
    <PixelFrame
      variant="raised"
      sx={{
        height: '100%',
        borderTop: '4px solid',
        borderTopColor: group.color,
        p: 2,
      }}
    >
      <Typography
        variant="h6"
        component="h3"
        gutterBottom
        sx={{ fontFamily: FONT.pixel, fontSize: '0.95rem' }}
      >
        {group.name}
      </Typography>
      <Typography variant="subtitle2" color="text.secondary" gutterBottom>
        {group.name_vi}
      </Typography>

      <List dense disablePadding>
        {group.lessons.map((lesson) => (
          <ListItemButton
            key={lesson.id}
            component={RouterLink}
            to={`/lessons/${lesson.slug}`}
          >
            <ListItemIcon sx={{ minWidth: 36 }}>
              <MenuBookIcon fontSize="small" sx={{ color: group.color }} />
            </ListItemIcon>
            <ListItemText
              primary={lesson.name}
              secondary={`${lesson.name_vi} · ${DIFFICULTY_LABELS[lesson.difficulty] || lesson.difficulty}`}
            />
            <Box
              sx={{
                display: 'flex',
                alignItems: 'center',
                gap: 1,
                ml: 1,
                flexShrink: 0,
              }}
            >
              <ScoreBadge score={lesson.best_score} label="" />
              <LessonStatusChip status={lesson.status} />
            </Box>
          </ListItemButton>
        ))}
      </List>

      <Box sx={{ mt: 1 }}>
        <Chip
          label={`${group.lessons.length} bài học`}
          size="small"
          sx={{ backgroundColor: group.color, color: 'common.white' }}
        />
      </Box>
    </PixelFrame>
  );
}
