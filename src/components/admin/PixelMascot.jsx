import { useRef, useEffect } from 'react';
import Box from '@mui/material/Box';
import Tooltip from '@mui/material/Tooltip';
import { bulbasaur } from '../../assets/sprites/index.js';

function renderFrame(ctx, sprite, frameIndex) {
  const frame = sprite.FRAMES[frameIndex];
  const { PALETTE, FRAME_WIDTH, FRAME_HEIGHT } = sprite;

  ctx.clearRect(0, 0, FRAME_WIDTH, FRAME_HEIGHT);

  for (let row = 0; row < frame.length; row++) {
    const line = frame[row];
    for (let col = 0; col < line.length; col++) {
      const colorIndex = parseInt(line[col], 16);
      if (colorIndex === 0) continue;
      ctx.fillStyle = PALETTE[colorIndex];
      ctx.fillRect(col, row, 1, 1);
    }
  }
}

export default function PixelMascot({
  sprite = bulbasaur,
  scale = 4,
  show = true,
}) {
  const canvasRef = useRef(null);
  const frameRef = useRef(0);
  const lastTimeRef = useRef(0);
  const rafRef = useRef(null);
  const excitedRef = useRef(false);
  const excitedTimerRef = useRef(null);

  useEffect(() => {
    if (!show) return;

    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    ctx.imageSmoothingEnabled = false;

    renderFrame(ctx, sprite, 0);
    frameRef.current = 0;
    lastTimeRef.current = 0;

    function animate(timestamp) {
      if (!lastTimeRef.current) lastTimeRef.current = timestamp;

      const elapsed = timestamp - lastTimeRef.current;
      const duration = excitedRef.current
        ? sprite.FRAME_DURATION / 2
        : sprite.FRAME_DURATION;

      if (elapsed >= duration) {
        lastTimeRef.current = timestamp;
        frameRef.current = (frameRef.current + 1) % sprite.FRAMES.length;
        renderFrame(ctx, sprite, frameRef.current);
      }

      rafRef.current = requestAnimationFrame(animate);
    }

    rafRef.current = requestAnimationFrame(animate);

    return () => {
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
      if (excitedTimerRef.current) clearTimeout(excitedTimerRef.current);
    };
  }, [show, sprite]);

  function handleClick() {
    if (excitedRef.current) return;
    excitedRef.current = true;

    if (excitedTimerRef.current) clearTimeout(excitedTimerRef.current);
    excitedTimerRef.current = setTimeout(() => {
      excitedRef.current = false;
      excitedTimerRef.current = null;
    }, 2000);
  }

  if (!show) return null;

  return (
    <Tooltip title="Bulbasaur" placement="top">
      <Box
        onClick={handleClick}
        sx={{
          position: 'fixed',
          bottom: 16,
          right: 16,
          zIndex: 1000,
          cursor: 'pointer',
          transition: 'transform 0.2s ease-out',
          '&:hover': { transform: 'translateY(-4px)' },
          display: { xs: 'none', sm: 'block' },
        }}
      >
        <canvas
          ref={canvasRef}
          width={sprite.FRAME_WIDTH}
          height={sprite.FRAME_HEIGHT}
          style={{
            display: 'block',
            width: sprite.FRAME_WIDTH * scale,
            height: sprite.FRAME_HEIGHT * scale,
            imageRendering: 'pixelated',
          }}
        />
      </Box>
    </Tooltip>
  );
}
