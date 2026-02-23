/**
 * Safe data generators for interactive charts (Explorable Explanations).
 *
 * Each generator is a pure function: (params, x) → y
 * Parameter names correspond to metadata.parameters[].key values.
 * Using predefined functions instead of eval/Function for security.
 *
 * To add a new generator:
 * 1. Add the function to GENERATORS
 * 2. Use it in lesson_section.metadata.generator or series[].generator
 */

const { sin, cos, exp, log, pow, sqrt, PI, abs, max } = Math;

const GENERATORS = {
  // -- Trigonometric --
  sine: (p, x) => (p.A ?? 1) * sin(((p.f ?? 1) * x * PI) / 180),
  cosine: (p, x) => (p.A ?? 1) * cos(((p.f ?? 1) * x * PI) / 180),

  // -- Polynomial --
  linear: (p, x) => (p.m ?? 1) * x + (p.b ?? 0),
  quadratic: (p, x) => (p.a ?? 1) * x * x + (p.b ?? 0) * x + (p.c ?? 0),
  cubic: (p, x) =>
    (p.a ?? 1) * x * x * x + (p.b ?? 0) * x * x + (p.c ?? 0) * x + (p.d ?? 0),

  // -- Growth & Decay --
  exponential: (p, x) => (p.a ?? 1) * exp((p.r ?? 0.1) * x),
  logarithmic: (p, x) => (p.a ?? 1) * log(abs(x) + 1) + (p.b ?? 0),
  power: (p, x) => (p.a ?? 1) * pow(max(abs(x), 0.001), p.n ?? 2),

  // -- Statistics --
  normal: (p, x) => {
    const mu = p.mu ?? 0;
    const sigma = max(p.sigma ?? 1, 0.01);
    const scale = p.scale ?? 100;
    return (
      (scale * exp(-0.5 * ((x - mu) / sigma) ** 2)) / (sigma * sqrt(2 * PI))
    );
  },

  // -- Economics --
  supply: (p, x) => max(0, (p.base ?? 10) + (p.slope ?? 0.5) * x),
  demand: (p, x) => max(0, (p.intercept ?? 100) - (p.slope ?? 0.5) * x),
  compound: (p, x) => (p.P ?? 1000) * pow(1 + (p.r ?? 0.05), x),
};

/**
 * Generate chart data from metadata configuration.
 *
 * @param {Object} metadata - Section metadata with generator config
 * @param {string} metadata.generator - Default generator name for all series
 * @param {number[]} metadata.xRange - [min, max, step] for x-axis values
 * @param {string} [metadata.xKey='x'] - Key name for x values in data points
 * @param {Object[]} metadata.series - Array of { dataKey, name, generator? }
 * @param {Object} paramValues - Current parameter values from sliders
 * @returns {Object[]} Array of data points for Recharts
 */
export function generateChartData(metadata, paramValues) {
  const { generator, xRange, xKey = 'x', series } = metadata;
  const [xMin, xMax, xStep] = xRange;
  const data = [];

  for (let x = xMin; x <= xMax; x += xStep) {
    const point = { [xKey]: Math.round(x * 1000) / 1000 }; // avoid float noise

    for (const s of series) {
      const genName = s.generator || generator;
      const genFn = GENERATORS[genName];
      if (genFn) {
        const y = genFn(paramValues, x);
        point[s.dataKey] = Number.isFinite(y) ? Math.round(y * 1000) / 1000 : 0;
      }
    }

    data.push(point);
  }

  return data;
}

/**
 * Extract initial parameter values from metadata.parameters definitions.
 */
export function getDefaultParams(parameters) {
  const defaults = {};
  for (const p of parameters) {
    defaults[p.key] = p.default ?? p.min ?? 0;
  }
  return defaults;
}

/** Check if a generator name is valid */
export function isValidGenerator(name) {
  return name in GENERATORS;
}
