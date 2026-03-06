import { useRef, useEffect } from 'react';
import Box from '@mui/material/Box';

export default function SpriteAnimation({
  src,
  frameWidth,
  frameHeight,
  frameCount,
  fps = 4,
  scale = 4,
  direction = 'horizontal',
  ...boxProps
}) {
  const canvasRef = useRef(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    ctx.imageSmoothingEnabled = false;

    const img = new Image();
    img.src = src;

    let frameIndex = 0;
    let animId = null;
    let lastTime = 0;
    const frameDuration = 1000 / fps;

    function draw(timestamp) {
      if (!lastTime) lastTime = timestamp;
      const elapsed = timestamp - lastTime;

      if (elapsed >= frameDuration) {
        lastTime = timestamp;
        ctx.clearRect(0, 0, frameWidth, frameHeight);

        const sx = direction === 'horizontal' ? frameIndex * frameWidth : 0;
        const sy = direction === 'vertical' ? frameIndex * frameHeight : 0;

        ctx.drawImage(
          img,
          sx,
          sy,
          frameWidth,
          frameHeight,
          0,
          0,
          frameWidth,
          frameHeight,
        );

        frameIndex = (frameIndex + 1) % frameCount;
      }

      animId = requestAnimationFrame(draw);
    }

    img.onload = () => {
      ctx.clearRect(0, 0, frameWidth, frameHeight);
      ctx.drawImage(
        img,
        0,
        0,
        frameWidth,
        frameHeight,
        0,
        0,
        frameWidth,
        frameHeight,
      );
      animId = requestAnimationFrame(draw);
    };

    return () => {
      if (animId) cancelAnimationFrame(animId);
    };
  }, [src, frameWidth, frameHeight, frameCount, fps, direction]);

  return (
    <Box {...boxProps}>
      <canvas
        ref={canvasRef}
        width={frameWidth}
        height={frameHeight}
        style={{
          display: 'block',
          width: frameWidth * scale,
          height: frameHeight * scale,
          imageRendering: 'pixelated',
        }}
      />
    </Box>
  );
}
