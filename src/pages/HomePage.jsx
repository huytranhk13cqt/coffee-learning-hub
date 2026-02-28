import { useState, useMemo } from 'react';
import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchHomePage } from '../api/groups.js';
import { fetchPaths } from '../api/paths.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardActionArea from '@mui/material/CardActionArea';
import CardContent from '@mui/material/CardContent';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import Stack from '@mui/material/Stack';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import InputAdornment from '@mui/material/InputAdornment';
import TextField from '@mui/material/TextField';
import Fade from '@mui/material/Fade';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Paper from '@mui/material/Paper';
import LinearProgress from '@mui/material/LinearProgress';
import RouteIcon from '@mui/icons-material/Route';
import ArrowForwardIcon from '@mui/icons-material/ArrowForward';

// Icons — topic icons (static imports for tree-shaking)
import MenuBookIcon from '@mui/icons-material/MenuBook';
import CodeIcon from '@mui/icons-material/Code';
import BarChartIcon from '@mui/icons-material/BarChart';
import SecurityIcon from '@mui/icons-material/Security';
import RouterIcon from '@mui/icons-material/Router';
import DeveloperBoardIcon from '@mui/icons-material/DeveloperBoard';
import DevicesIcon from '@mui/icons-material/Devices';
import SportsEsportsIcon from '@mui/icons-material/SportsEsports';
import ScienceIcon from '@mui/icons-material/Science';
import RocketLaunchIcon from '@mui/icons-material/RocketLaunch';
import ParkIcon from '@mui/icons-material/Park';
import GrassIcon from '@mui/icons-material/Grass';
import NatureIcon from '@mui/icons-material/Nature';
import LocalHospitalIcon from '@mui/icons-material/LocalHospital';
import FitnessCenterIcon from '@mui/icons-material/FitnessCenter';
import SportsMartialArtsIcon from '@mui/icons-material/SportsMartialArts';
import NightsStayIcon from '@mui/icons-material/NightsStay';
import RestaurantIcon from '@mui/icons-material/Restaurant';
import PsychologyIcon from '@mui/icons-material/Psychology';
import GroupsIcon from '@mui/icons-material/Groups';
import Diversity3Icon from '@mui/icons-material/Diversity3';
import PolicyIcon from '@mui/icons-material/Policy';
import CastForEducationIcon from '@mui/icons-material/CastForEducation';
import AutoStoriesIcon from '@mui/icons-material/AutoStories';
import HistoryEduIcon from '@mui/icons-material/HistoryEdu';
import PublicIcon from '@mui/icons-material/Public';
import LanguageIcon from '@mui/icons-material/Language';
import GavelIcon from '@mui/icons-material/Gavel';
import TranslateIcon from '@mui/icons-material/Translate';
import TrendingUpIcon from '@mui/icons-material/TrendingUp';
import SavingsIcon from '@mui/icons-material/Savings';
import CampaignIcon from '@mui/icons-material/Campaign';
import BusinessCenterIcon from '@mui/icons-material/BusinessCenter';
import HandshakeIcon from '@mui/icons-material/Handshake';
import LocalShippingIcon from '@mui/icons-material/LocalShipping';
import ExtensionIcon from '@mui/icons-material/Extension';
import DesignServicesIcon from '@mui/icons-material/DesignServices';
import MusicNoteIcon from '@mui/icons-material/MusicNote';
import BrushIcon from '@mui/icons-material/Brush';
import CameraAltIcon from '@mui/icons-material/CameraAlt';
import BuildIcon from '@mui/icons-material/Build';
import ShieldIcon from '@mui/icons-material/Shield';
import AccountTreeIcon from '@mui/icons-material/AccountTree';
import SchoolIcon from '@mui/icons-material/School';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import SearchIcon from '@mui/icons-material/Search';

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
      <Typography variant="h4" component="h1" gutterBottom>
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
        {topics.map((topic) => (
          <Grid key={topic.id ?? 'other'} size={{ xs: 6, sm: 4, md: 3, lg: 2 }}>
            <TopicCard topic={topic} onClick={() => onSelectTopic(topic)} />
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

function TopicCard({ topic, onClick }) {
  const TopicIcon = TOPIC_ICONS[topic.icon] || MenuBookIcon;
  const lessonCount = getTopicLessonCount(topic);

  return (
    <Card
      sx={{
        height: '100%',
        transition: 'transform 0.15s, box-shadow 0.15s',
        '&:hover': {
          transform: 'translateY(-2px)',
          boxShadow: 4,
        },
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
        }}
      >
        <Box
          sx={{
            width: 52,
            height: 52,
            borderRadius: 2,
            bgcolor: topic.color + '18',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            mb: 1.5,
          }}
        >
          <TopicIcon sx={{ color: topic.color, fontSize: 28 }} />
        </Box>
        <Typography
          variant="subtitle2"
          sx={{
            fontWeight: 600,
            lineHeight: 1.3,
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
            fontWeight: 600,
          }}
        />
      </CardActionArea>
    </Card>
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
            borderRadius: 2,
            bgcolor: topic.color + '18',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            flexShrink: 0,
          }}
        >
          <TopicIcon sx={{ color: topic.color, fontSize: 32 }} />
        </Box>
        <Box sx={{ flex: 1, minWidth: 0 }}>
          <Typography variant="h4" component="h1" sx={{ lineHeight: 1.3 }}>
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

      <Divider sx={{ mb: 3 }} />

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
          <Paper
            key={path.id}
            variant="outlined"
            component={RouterLink}
            to={`/paths/${path.slug}`}
            sx={{
              p: 2,
              minWidth: 200,
              maxWidth: 240,
              flexShrink: 0,
              textDecoration: 'none',
              color: 'inherit',
              borderTop: 3,
              borderColor: path.color,
              transition: 'box-shadow 0.15s',
              '&:hover': { boxShadow: 3 },
            }}
          >
            <Typography
              variant="subtitle2"
              fontWeight={700}
              sx={{
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
              <LinearProgress
                variant="determinate"
                value={path.progress_percent}
                sx={{ height: 4, borderRadius: 2 }}
              />
            )}
          </Paper>
        ))}
      </Box>
    </Box>
  );
}

function CategoryCard({ group }) {
  return (
    <Card
      sx={{
        height: '100%',
        borderTop: 4,
        borderColor: group.color,
      }}
    >
      <CardContent>
        <Typography variant="h6" component="h3" gutterBottom>
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
              sx={{ borderRadius: 1 }}
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
            sx={{ backgroundColor: group.color, color: '#fff' }}
          />
        </Box>
      </CardContent>
    </Card>
  );
}
