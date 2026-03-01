import { useState, useEffect } from 'react';
import { useLoaderData } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import { fetchAdminDashboard } from '../../api/admin.js';
import AdminStatsCards from '../../components/admin/AdminStatsCards.jsx';
import AdminQuickCreate from '../../components/admin/AdminQuickCreate.jsx';
import AdminRecentActivity from '../../components/admin/AdminRecentActivity.jsx';
import AdminDraftsWidget from '../../components/admin/AdminDraftsWidget.jsx';
import AdminContentHealth from '../../components/admin/AdminContentHealth.jsx';
import AdminContentBreakdown from '../../components/admin/AdminContentBreakdown.jsx';

export async function loader() {
  return fetchAdminDashboard();
}

export default function AdminDashboardPage() {
  const loaderData = useLoaderData();
  const [data, setData] = useState(loaderData);

  useEffect(() => {
    setData(loaderData);
  }, [loaderData]);

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Dashboard
      </Typography>
      <Grid container spacing={3}>
        <Grid size={12}>
          <AdminStatsCards stats={data?.stats?.data} />
        </Grid>
        <Grid size={{ xs: 12, md: 6 }}>
          <AdminQuickCreate />
        </Grid>
        <Grid size={{ xs: 12, md: 6 }}>
          <AdminRecentActivity activity={data?.activity} />
        </Grid>
        <Grid size={{ xs: 12, md: 6 }}>
          <AdminDraftsWidget drafts={data?.drafts} />
        </Grid>
        <Grid size={{ xs: 12, md: 6 }}>
          <AdminContentHealth health={data?.health} />
        </Grid>
        <Grid size={12}>
          <AdminContentBreakdown breakdown={data?.breakdown} />
        </Grid>
      </Grid>
    </Box>
  );
}
