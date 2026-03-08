import { useEffect, useRef } from 'react';

/**
 * Canvas 2D particle emitter — pixel art style.
 *
 * Particles are SQUARES rendered on a 2px grid with image smoothing
 * disabled, so they look like retro pixel sprites.
 *
 * @param {boolean} active  — spawn & animate when true
 * @param {'confetti'|'sparkle'} preset — particle behavior preset
 * @param {boolean} fixed   — true = viewport overlay, false = parent-relative
 */

const PRESETS = {
  confetti: {
    count: 40,
    colors: ['#D4A44E', '#3D8B5E', '#5B52A3', '#A3527A', '#D4826A', '#6B9EC4'],
    gravity: 0.12,
    sizeRange: [3, 7],
    friction: 0.985,
    decay: [0.006, 0.012],
    velocity: { x: [-7, 7], y: [-14, -5] },
    originY: 0.2,
  },
  sparkle: {
    count: 18,
    colors: ['#D4A44E', '#FEFCF8', '#E8A94D', '#C7C1E2'],
    gravity: -0.02,
    sizeRange: [2, 5],
    friction: 0.96,
    decay: [0.012, 0.022],
    velocity: { x: [-3, 3], y: [-3, 3] },
    originY: 0.4,
  },
};

function rand(min, max) {
  return min + Math.random() * (max - min);
}

// Snap to 2px grid for pixel-crisp rendering
function snap(v) {
  return Math.round(v / 2) * 2;
}

export default function PixelParticles({
  active = false,
  preset = 'confetti',
  fixed = false,
}) {
  const canvasRef = useRef(null);
  const rafRef = useRef(null);

  useEffect(() => {
    if (!active) return;

    const canvas = canvasRef.current;
    if (!canvas) return;

    // Size canvas to container or viewport
    if (fixed) {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    } else {
      const parent = canvas.parentElement;
      canvas.width = parent?.offsetWidth || 300;
      canvas.height = parent?.offsetHeight || 300;
    }

    const ctx = canvas.getContext('2d');
    ctx.imageSmoothingEnabled = false;

    const cfg = PRESETS[preset] || PRESETS.confetti;
    const ox = canvas.width / 2;
    const oy = canvas.height * cfg.originY;

    // Spawn particles
    const particles = Array.from({ length: cfg.count }, (_, i) => ({
      x: ox + rand(-4, 4),
      y: oy + rand(-4, 4),
      vx: rand(cfg.velocity.x[0], cfg.velocity.x[1]),
      vy: rand(cfg.velocity.y[0], cfg.velocity.y[1]),
      size: snap(rand(cfg.sizeRange[0], cfg.sizeRange[1])),
      color: cfg.colors[i % cfg.colors.length],
      life: 1,
      decay: rand(cfg.decay[0], cfg.decay[1]),
    }));

    function frame() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      let alive = 0;

      for (const p of particles) {
        if (p.life <= 0) continue;
        alive++;

        p.x += p.vx;
        p.y += p.vy;
        p.vy += cfg.gravity;
        p.vx *= cfg.friction;
        p.life -= p.decay;

        ctx.globalAlpha = Math.max(0, p.life);
        ctx.fillStyle = p.color;
        ctx.fillRect(snap(p.x), snap(p.y), p.size, p.size);
      }

      ctx.globalAlpha = 1;

      if (alive > 0) {
        rafRef.current = requestAnimationFrame(frame);
      }
    }

    rafRef.current = requestAnimationFrame(frame);

    return () => {
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
    };
  }, [active, preset, fixed]);

  if (!active) return null;

  const style = fixed
    ? {
        position: 'fixed',
        top: 0,
        left: 0,
        width: '100vw',
        height: '100vh',
        pointerEvents: 'none',
        zIndex: 9999,
        imageRendering: 'pixelated',
      }
    : {
        position: 'absolute',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
        pointerEvents: 'none',
        zIndex: 10,
        imageRendering: 'pixelated',
      };

  return <canvas ref={canvasRef} style={style} />;
}
