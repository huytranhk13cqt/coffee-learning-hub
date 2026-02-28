import { useState, useRef } from 'react';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import { exportSession, importSession } from '../api/progress.js';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Alert from '@mui/material/Alert';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogActions from '@mui/material/DialogActions';
import Divider from '@mui/material/Divider';
import Stack from '@mui/material/Stack';
import Fade from '@mui/material/Fade';
import DownloadIcon from '@mui/icons-material/Download';
import UploadIcon from '@mui/icons-material/Upload';
import WarningAmberIcon from '@mui/icons-material/WarningAmber';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';

// Build a human-readable summary of the import payload for the confirm dialog
function buildImportSummary(data) {
  const lines = [];
  if (data.progress?.length)
    lines.push(`• ${data.progress.length} bài học đã học`);
  if (data.attempts?.length)
    lines.push(`• ${data.attempts.length} lần thử bài tập`);
  if (data.reviews?.length)
    lines.push(`• ${data.reviews.length} bài đang ôn tập (SM-2)`);
  if (data.achievements?.length)
    lines.push(`• ${data.achievements.length} thành tựu`);
  if (data.streak?.current_streak)
    lines.push(`• Chuỗi dài nhất: ${data.streak.longest_streak} ngày`);
  return lines.length ? lines.join('\n') : '(không có dữ liệu)';
}

export default function SettingsPage() {
  useDocumentTitle('Cài đặt');

  const fileInputRef = useRef(null);
  const [exportLoading, setExportLoading] = useState(false);
  const [importLoading, setImportLoading] = useState(false);
  const [pendingImport, setPendingImport] = useState(null); // { data, filename, summary }
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [status, setStatus] = useState(null); // { type: 'success'|'error', message }

  // --- Export ---
  const handleExport = async () => {
    setExportLoading(true);
    setStatus(null);
    try {
      const data = await exportSession();
      const json = JSON.stringify(data, null, 2);
      const blob = new Blob([json], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `learning-hub-backup-${new Date().toISOString().slice(0, 10)}.json`;
      a.click();
      URL.revokeObjectURL(url);
      setStatus({
        type: 'success',
        message: 'Đã tải xuống file sao lưu thành công!',
      });
    } catch {
      setStatus({
        type: 'error',
        message: 'Không thể tải xuống. Vui lòng thử lại.',
      });
    } finally {
      setExportLoading(false);
    }
  };

  // --- File pick ---
  const handleFilePick = (e) => {
    const file = e.target.files[0];
    // Reset input so the same file can be re-selected after cancel
    e.target.value = '';
    if (!file) return;

    setStatus(null);
    const reader = new FileReader();
    reader.onload = (ev) => {
      try {
        const parsed = JSON.parse(ev.target.result);
        if (!parsed || parsed.version !== 1) {
          setStatus({
            type: 'error',
            message:
              'File không hợp lệ — không phải file sao lưu Learning Hub.',
          });
          return;
        }
        setPendingImport({
          data: parsed,
          filename: file.name,
          summary: buildImportSummary(parsed),
          exportedAt: parsed.exportedAt,
        });
        setConfirmOpen(true);
      } catch {
        setStatus({
          type: 'error',
          message: 'Không thể đọc file. Đảm bảo file là JSON hợp lệ.',
        });
      }
    };
    reader.readAsText(file);
  };

  // --- Confirm import ---
  const handleConfirmImport = async () => {
    if (!pendingImport) return;
    setConfirmOpen(false);
    setImportLoading(true);
    setStatus(null);
    try {
      await importSession(pendingImport.data);
      setStatus({
        type: 'success',
        message:
          'Khôi phục thành công! Tiến trình của bạn đã được cập nhật. Tải lại trang để thấy thay đổi.',
      });
    } catch {
      setStatus({
        type: 'error',
        message:
          'Khôi phục thất bại. File có thể bị lỗi hoặc server không phản hồi.',
      });
    } finally {
      setImportLoading(false);
      setPendingImport(null);
    }
  };

  return (
    <Fade in timeout={300}>
      <div>
        <Typography variant="h4" component="h1" gutterBottom>
          Cài đặt
        </Typography>

        {status && (
          <Alert
            severity={status.type}
            icon={
              status.type === 'success' ? <CheckCircleOutlineIcon /> : undefined
            }
            sx={{ mb: 3 }}
            onClose={() => setStatus(null)}
          >
            {status.message}
          </Alert>
        )}

        <Stack spacing={3} maxWidth={640}>
          {/* Export */}
          <Card variant="outlined">
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Sao lưu tiến trình
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Tải xuống toàn bộ tiến trình học tập, bài tập, thành tựu và lịch
                sử ôn tập dưới dạng file JSON. Bạn có thể dùng file này để khôi
                phục dữ liệu trên thiết bị khác hoặc sau khi xóa cache trình
                duyệt.
              </Typography>
            </CardContent>
            <Divider />
            <CardActions sx={{ p: 2 }}>
              <Button
                variant="contained"
                startIcon={<DownloadIcon />}
                onClick={handleExport}
                loading={exportLoading}
                loadingPosition="start"
              >
                Tải xuống file sao lưu
              </Button>
            </CardActions>
          </Card>

          {/* Import */}
          <Card variant="outlined" sx={{ borderColor: 'warning.main' }}>
            <CardContent>
              <Box
                sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}
              >
                <WarningAmberIcon color="warning" fontSize="small" />
                <Typography variant="h6">Khôi phục tiến trình</Typography>
              </Box>
              <Typography variant="body2" color="text.secondary">
                Nhập file sao lưu để khôi phục tiến trình học tập. Dữ liệu hiện
                tại sẽ được <strong>gộp</strong> với dữ liệu từ file — tiến
                trình tốt hơn sẽ được giữ lại. Lịch sử XP và hoạt động hàng ngày
                sẽ được thay thế hoàn toàn bằng dữ liệu từ file.
              </Typography>
            </CardContent>
            <Divider />
            <CardActions sx={{ p: 2 }}>
              <input
                ref={fileInputRef}
                type="file"
                accept=".json,application/json"
                style={{ display: 'none' }}
                onChange={handleFilePick}
              />
              <Button
                variant="outlined"
                color="warning"
                startIcon={<UploadIcon />}
                onClick={() => fileInputRef.current?.click()}
                loading={importLoading}
                loadingPosition="start"
              >
                Chọn file sao lưu để khôi phục
              </Button>
            </CardActions>
          </Card>
        </Stack>

        {/* Confirm import dialog */}
        <Dialog
          open={confirmOpen}
          onClose={() => {
            setConfirmOpen(false);
            setPendingImport(null);
          }}
          maxWidth="sm"
          fullWidth
        >
          <DialogTitle>Xác nhận khôi phục?</DialogTitle>
          <DialogContent>
            <DialogContentText component="div">
              <Typography variant="body2" gutterBottom>
                File: <strong>{pendingImport?.filename}</strong>
              </Typography>
              {pendingImport?.exportedAt && (
                <Typography variant="body2" color="text.secondary" gutterBottom>
                  Ngày xuất:{' '}
                  {new Date(pendingImport.exportedAt).toLocaleString('vi-VN')}
                </Typography>
              )}
              <Box
                component="pre"
                sx={{
                  mt: 1.5,
                  p: 1.5,
                  bgcolor: 'action.hover',
                  borderRadius: 1,
                  fontSize: '0.85rem',
                  whiteSpace: 'pre-wrap',
                  fontFamily: 'inherit',
                }}
              >
                {pendingImport?.summary}
              </Box>
              <Alert severity="warning" sx={{ mt: 2 }}>
                Lịch sử XP và hoạt động hàng ngày sẽ bị thay thế hoàn toàn. Hành
                động này không thể hoàn tác.
              </Alert>
            </DialogContentText>
          </DialogContent>
          <DialogActions>
            <Button
              onClick={() => {
                setConfirmOpen(false);
                setPendingImport(null);
              }}
            >
              Hủy
            </Button>
            <Button
              variant="contained"
              color="warning"
              onClick={handleConfirmImport}
            >
              Khôi phục
            </Button>
          </DialogActions>
        </Dialog>
      </div>
    </Fade>
  );
}
