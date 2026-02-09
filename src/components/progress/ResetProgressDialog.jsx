import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogActions from '@mui/material/DialogActions';
import Button from '@mui/material/Button';

export default function ResetProgressDialog({
  open,
  onClose,
  onConfirm,
  loading,
}) {
  return (
    <Dialog open={open} onClose={onClose}>
      <DialogTitle>Xác nhận đặt lại</DialogTitle>
      <DialogContent>
        <DialogContentText>
          Bạn có chắc muốn đặt lại tiến trình? Tất cả câu trả lời và điểm số
          hiện tại sẽ bị xóa. Điểm cao nhất và số lần làm bài sẽ được giữ lại.
        </DialogContentText>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose} disabled={loading}>
          Hủy
        </Button>
        <Button
          onClick={onConfirm}
          color="error"
          variant="contained"
          loading={loading}
        >
          Đặt lại
        </Button>
      </DialogActions>
    </Dialog>
  );
}
