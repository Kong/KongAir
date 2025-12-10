<svg width="960" height="480" viewBox="0 0 960 480" fill="none" xmlns="http://www.w3.org/2000/svg" style="max-width: 520px; width: 100%; height: auto;">
  <defs>
    <linearGradient id="kongair-sky" x1="0" y1="0" x2="960" y2="480" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#0B5F9E" />
      <stop offset="1" stop-color="#1B9DDD" />
    </linearGradient>
    <radialGradient id="kongair-sun" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(180 120) rotate(45) scale(220 220)">
      <stop offset="0" stop-color="#FDE68A" stop-opacity="0.7" />
      <stop offset="1" stop-color="#FDE68A" stop-opacity="0" />
    </radialGradient>
    <linearGradient id="kongair-wave" x1="0" y1="320" x2="960" y2="400" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#ffffff" stop-opacity="0.2" />
      <stop offset="1" stop-color="#ffffff" stop-opacity="0.05" />
    </linearGradient>
    <filter id="kongair-plane-shadow" x="0" y="0" width="200%" height="200%" color-interpolation-filters="sRGB">
      <feOffset dy="4" input="SourceAlpha" />
      <feGaussianBlur stdDeviation="6" />
      <feColorMatrix type="matrix" values="0 0 0 0 0.063 0 0 0 0 0.286 0 0 0 0 0.459 0 0 0 0.35 0" />
      <feBlend mode="normal" in2="SourceGraphic" result="shape" />
    </filter>
  </defs>

  <rect x="0" y="0" width="960" height="480" rx="32" fill="url(#kongair-sky)" />
  <rect x="0" y="0" width="960" height="480" rx="32" fill="url(#kongair-sun)" />

  <path d="M0 340C120 300 260 300 360 340C510 400 650 400 960 340V480H0V340Z" fill="url(#kongair-wave)" />

  <circle cx="140" cy="160" r="6" fill="#F9DA6A" />
  <circle cx="780" cy="120" r="4" fill="#F9DA6A" />
  <circle cx="860" cy="220" r="8" fill="#F9DA6A" fill-opacity="0.6" />

  <g opacity="0.75">
    <path d="M160 220C260 180 360 200 460 260C560 320 660 330 800 280" stroke="#FFFFFF" stroke-width="5" stroke-linecap="round" stroke-dasharray="14 16" />
    <circle cx="160" cy="220" r="10" fill="#ffffff" fill-opacity="0.35" stroke="#ffffff" stroke-width="2" />
    <circle cx="800" cy="280" r="10" fill="#ffffff" fill-opacity="0.35" stroke="#ffffff" stroke-width="2" />
  </g>

  <g filter="url(#kongair-plane-shadow)" transform="translate(570 210) rotate(-12)">
    <path d="M0 32C0 25.3726 5.37258 20 12 20H76C82.6274 20 88 25.3726 88 32C88 38.6274 82.6274 44 76 44H12C5.37258 44 0 38.6274 0 32Z" fill="#0B2948" fill-opacity="0.35" />
    <g transform="translate(18 0)">
      <path d="M148 0L90 24L44 18.5L10 42L0 38L30 12L-4 7L-7 2L44 0L148 0Z" fill="#FFFFFF" />
      <path d="M44 18.5L40 40" stroke="#0B5F9E" stroke-width="3" stroke-linecap="round" />
      <path d="M90 24L84 44" stroke="#0B5F9E" stroke-width="3" stroke-linecap="round" />
      <path d="M110 9.5L92 24" stroke="#1B9DDD" stroke-width="4" stroke-linecap="round" />
      <path d="M66 3L16 18" stroke="#1B9DDD" stroke-width="4" stroke-linecap="round" />
    </g>
  </g>

  <g opacity="0.35">
    <path d="M80 80L120 96" stroke="#FFFFFF" stroke-width="3" stroke-linecap="round" />
    <path d="M200 86L240 102" stroke="#FFFFFF" stroke-width="3" stroke-linecap="round" />
    <path d="M880 150L920 166" stroke="#FFFFFF" stroke-width="3" stroke-linecap="round" />
    <path d="M680 70L720 86" stroke="#FFFFFF" stroke-width="3" stroke-linecap="round" />
  </g>
</svg>
