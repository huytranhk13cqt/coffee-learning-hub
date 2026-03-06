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

function renderSpriteSheetFrame(ctx, img, sheet, frameIndex) {
  const { frameWidth, frameHeight } = sheet;
  ctx.clearRect(0, 0, frameWidth, frameHeight);
  const sx = frameIndex * frameWidth;
  ctx.drawImage(
    img,
    sx,
    0,
    frameWidth,
    frameHeight,
    0,
    0,
    frameWidth,
    frameHeight,
  );
}

export default function PixelMascot({
  sprite = bulbasaur,
  spriteSheet,
  scale = 4,
  show = true,
}) {
  const canvasRef = useRef(null);
  const frameRef = useRef(0);
  const lastTimeRef = useRef(0);
  const rafRef = useRef(null);
  const excitedRef = useRef(false);
  const excitedTimerRef = useRef(null);

  // PNG sprite sheet mode
  useEffect(() => {
    if (!show || !spriteSheet) return;

    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    ctx.imageSmoothingEnabled = false;

    const img = new Image();
    img.src = spriteSheet.src;

    const fps = spriteSheet.fps || 4;
    const frameDuration = 1000 / fps;
    const frameCount = spriteSheet.frameCount;

    frameRef.current = 0;
    lastTimeRef.current = 0;

    img.onload = () => {
      renderSpriteSheetFrame(ctx, img, spriteSheet, 0);

      function animate(timestamp) {
        if (!lastTimeRef.current) lastTimeRef.current = timestamp;
        const elapsed = timestamp - lastTimeRef.current;
        const duration = excitedRef.current ? frameDuration / 2 : frameDuration;

        if (elapsed >= duration) {
          lastTimeRef.current = timestamp;
          frameRef.current = (frameRef.current + 1) % frameCount;
          renderSpriteSheetFrame(ctx, img, spriteSheet, frameRef.current);
        }

        rafRef.current = requestAnimationFrame(animate);
      }

      rafRef.current = requestAnimationFrame(animate);
    };

    return () => {
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
      if (excitedTimerRef.current) clearTimeout(excitedTimerRef.current);
    };
  }, [show, spriteSheet]);

  // JS array sprite mode (original)
  useEffect(() => {
    if (!show || spriteSheet) return;

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
  }, [show, sprite, spriteSheet]);

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

  const w = spriteSheet ? spriteSheet.frameWidth : sprite.FRAME_WIDTH;
  const h = spriteSheet ? spriteSheet.frameHeight : sprite.FRAME_HEIGHT;
  const tooltipLabel = spriteSheet ? 'Mascot' : 'Bulbasaur';

  return (
    <Tooltip title={tooltipLabel} placement="top">
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
          width={w}
          height={h}
          style={{
            display: 'block',
            width: w * scale,
            height: h * scale,
            imageRendering: 'pixelated',
          }}
        />
      </Box>
    </Tooltip>
  );
}
