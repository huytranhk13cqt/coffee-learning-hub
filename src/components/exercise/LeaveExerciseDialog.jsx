import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogActions from '@mui/material/DialogActions';
import Button from '@mui/material/Button';

export default function LeaveExerciseDialog({ blocker }) {
  if (blocker.state !== 'blocked') return null;

  return (
    <Dialog open onClose={blocker.reset}>
      <DialogTitle>Thoát khỏi bài tập?</DialogTitle>
      <DialogContent>
        <DialogContentText>
          Tiến trình bài tập hiện tại sẽ không được lưu.
        </DialogContentText>
      </DialogContent>
      <DialogActions>
        <Button onClick={blocker.reset}>
          Tiếp tục làm bài
        </Button>
        <Button onClick={blocker.proceed} color="error" variant="contained">
          Thoát
        </Button>
      </DialogActions>
    </Dialog>
  );
}
