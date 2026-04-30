# V — Investor Website: Replit Build Prompt, Part 1 of 2

**Read both Part 1 and Part 2 before starting any code.**
**Then execute Pass by Pass in order. Do not skip ahead.**
**Each Pass ends with a visual checkpoint. Do not proceed until the checkpoint passes.**

---

## WHAT YOU ARE BUILDING

A cinematic, investor-grade single-page web application for "V" — a personal AI operating
system that compiles a person's cognitive identity into a persistent mathematical structure,
then uses that structure to guide any AI model or agent the person works with.

The site is a pitch — not a tutorial. It explains what V is, why the math is novel, and why
the architecture is defensible, without revealing implementation details. It sells the vision
to a technically sophisticated investor.

**Name rule:** The product is referred to only as "V" throughout. Never "Velorin."
**Person rule:** No names, no biographical details, no personal history of any kind.
**Math rule:** Show enough to establish credibility; do not reveal derivations, specific
parameter values, or algorithmic implementation. Tease, don't teach.

---

## VISUAL IDENTITY — READ THIS BEFORE WRITING ONE LINE OF CODE

The aesthetic has three layers that must coexist without conflict:

**Layer 1 — iRobot precision:** Clean engineered surfaces. Chrome and white. Everything
has a reason. Nothing decorative for decoration's sake. Geometric exactness. Machine
confidence. This governs the layout grid and component edges.

**Layer 2 — Westworld formation:** The site builds itself in front of you. Neural threads
appear from darkness. Structures crystallize. Connections form and pulse. The experience
of watching something *becoming* — ligaments extending, a skeleton assembling. This governs
the animation approach. Nothing snaps into place. Everything forms.

**Layer 3 — Fallout New Vegas atomic vibe:** NOT retro. NOT pixel art. NOT low-resolution.
The atomic age aesthetic means: confidence, audacity, sweeping geometry, Nixie tube glow,
amber warmth against cold chrome, art deco proportions, bold typography that announces
rather than whispers. Think the architecture of a world that believed in its future.
This governs color accent decisions and typographic weight.

**What this is NOT:**
- Not a dark mode tech site with blue gradients
- Not a startup landing page with stock photos
- Not a retro/synthwave throwback with scanlines
- Not a minimal flat design with thin gray text
- Not any existing template

---

## COLOR SYSTEM

```css
--v-void:       #070a10;    /* True background — almost black with blue undertone */
--v-deep:       #0d1220;    /* Second background layer */
--v-surface:    #1a2035;    /* Card/panel surfaces */
--v-frame:      #1C2333;    /* Primary dark — the native environment */
--v-slate:      #8C9BAB;    /* Secondary text, labels */
--v-light:      #E8EDF2;    /* Primary text — machine surface */
--v-signal:     #C03A2B;    /* Vermillion — THE human signal. Use sparingly. One accent. */
--v-ember:      #D4A853;    /* Amber/gold — Nixie tube warmth. Secondary glow. */
--v-chrome:     #B8C0CC;    /* Metallic mid-tone */
--v-neural:     #33FF33;    /* CRT terminal green — used ONLY for data/terminal elements */
--v-glow-r:     rgba(192,58,43,0.15);   /* Signal glow */
--v-glow-e:     rgba(212,168,83,0.12);  /* Ember glow */
```

**Rule:** In any given viewport, the vermillion signal (#C03A2B) appears in at most ONE
prominent location. It is the needle. It cuts through everything else.

---

## TYPOGRAPHY

```
Display font:   "Playfair Display" — headings that command authority
Mono font:      "JetBrains Mono" — data, formulas, terminal elements, labels
Body font:      "Inter" — clean, legible body copy
```

Load from Google Fonts in index.html. The weight hierarchy:
- Section heroes: Playfair Display, 700–900 weight, very large (clamp-scaled)
- Data labels: JetBrains Mono, 400, uppercase, tracking-widest
- Body paragraphs: Inter, 300–400, generous line-height (1.8)
- Subheadings: Inter, 600, tight tracking

---

## TECH STACK — EXACT PACKAGES

```json
{
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "three": "^0.164.0",
    "@react-three/fiber": "^8.16.0",
    "@react-three/drei": "^9.102.0",
    "framer-motion": "^11.0.0",
    "gsap": "^3.12.0",
    "@gsap/react": "^2.1.0",
    "lenis": "^1.0.45",
    "express": "^4.18.0",
    "helmet": "^7.1.0",
    "express-rate-limit": "^7.2.0",
    "dompurify": "^3.0.0",
    "isomorphic-dompurify": "^1.13.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.2.0",
    "vite": "^5.1.0",
    "tailwindcss": "^3.4.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0"
  }
}
```

---

## PROJECT STRUCTURE

Create exactly this structure before writing any code:

```
/
├── src/
│   ├── components/
│   │   ├── Nav.jsx
│   │   ├── Hero/
│   │   │   ├── Hero.jsx
│   │   │   ├── VLogo.jsx
│   │   │   └── NeuralBackground.jsx
│   │   ├── Problem/
│   │   │   └── Problem.jsx
│   │   ├── Revelation/
│   │   │   └── Revelation.jsx
│   │   ├── Architecture/
│   │   │   ├── Architecture.jsx
│   │   │   └── LayerExplorer.jsx
│   │   ├── MathTeaser/
│   │   │   ├── MathTeaser.jsx
│   │   │   ├── PPRViz.jsx
│   │   │   ├── CrystalViz.jsx
│   │   │   └── SecondLawViz.jsx
│   │   ├── Vision/
│   │   │   └── Vision.jsx
│   │   ├── Moat/
│   │   │   └── Moat.jsx
│   │   ├── Scale/
│   │   │   └── Scale.jsx
│   │   ├── Contact/
│   │   │   └── Contact.jsx
│   │   └── Footer.jsx
│   ├── three/
│   │   ├── NeuralMesh.jsx
│   │   ├── EightCrystal.jsx
│   │   └── shaders/
│   │       ├── neural.vert.glsl
│   │       └── neural.frag.glsl
│   ├── hooks/
│   │   ├── useScrollReveal.js
│   │   └── useSmoothScroll.js
│   ├── styles/
│   │   ├── globals.css
│   │   └── animations.css
│   ├── App.jsx
│   └── main.jsx
├── public/
│   └── assets/
│       └── v-logo-placeholder.svg  ← CT will replace with actual V logo images
├── server.js
├── index.html
├── vite.config.js
├── tailwind.config.js
├── postcss.config.js
└── package.json
```

---

## PASS 1 — FOUNDATION

**Goal:** Project runs. Navigate to localhost and see a dark void with the V mark in
the center. No animations yet. Typography working. Color system working.

### 1A — Configuration Files

**vite.config.js:**
```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      '/api': 'http://localhost:3001'
    }
  }
})
```

**tailwind.config.js:**
```javascript
module.exports = {
  content: ['./src/**/*.{js,jsx,ts,tsx}', './index.html'],
  theme: {
    extend: {
      colors: {
        void:    '#070a10',
        deep:    '#0d1220',
        surface: '#1a2035',
        frame:   '#1C2333',
        slate:   '#8C9BAB',
        light:   '#E8EDF2',
        signal:  '#C03A2B',
        ember:   '#D4A853',
        chrome:  '#B8C0CC',
        neural:  '#33FF33',
      },
      fontFamily: {
        display: ['"Playfair Display"', 'serif'],
        mono:    ['"JetBrains Mono"', 'monospace'],
        body:    ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
```

**postcss.config.js:**
```javascript
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
```

### 1B — index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="V — Identity · Biology · Machine" />
  <meta name="robots" content="noindex, nofollow" />
  <title>V</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=JetBrains+Mono:wght@300;400;500&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
  <div id="root"></div>
  <script type="module" src="/src/main.jsx"></script>
</body>
</html>
```

### 1C — src/styles/globals.css

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --v-void: #070a10;
  --v-deep: #0d1220;
  --v-surface: #1a2035;
  --v-frame: #1C2333;
  --v-slate: #8C9BAB;
  --v-light: #E8EDF2;
  --v-signal: #C03A2B;
  --v-ember: #D4A853;
  --v-chrome: #B8C0CC;
  --v-neural: #33FF33;
}

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  background-color: var(--v-void);
  color: var(--v-light);
  font-family: 'Inter', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  overflow-x: hidden;
}

body {
  background-color: var(--v-void);
  min-height: 100vh;
}

::selection {
  background-color: rgba(192, 58, 43, 0.3);
  color: var(--v-light);
}

/* Scrollbar */
::-webkit-scrollbar { width: 2px; }
::-webkit-scrollbar-track { background: var(--v-void); }
::-webkit-scrollbar-thumb { background: var(--v-signal); }

/* Section base */
.v-section {
  min-height: 100vh;
  position: relative;
  overflow: hidden;
}

/* Label style */
.v-label {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.65rem;
  letter-spacing: 0.25em;
  text-transform: uppercase;
  color: var(--v-slate);
}

/* Signal line — the vermillion horizontal rule */
.v-rule {
  width: 48px;
  height: 1px;
  background: var(--v-signal);
  margin: 1rem 0;
}

/* Display text */
.v-display {
  font-family: 'Playfair Display', serif;
  font-weight: 700;
  line-height: 1.1;
  color: var(--v-light);
}

/* Mono data */
.v-mono {
  font-family: 'JetBrains Mono', monospace;
  color: var(--v-ember);
}
```

### 1D — public/assets/v-logo-placeholder.svg

Create a programmatic V logo. CT will replace this with actual images. The V is flat
outline — two strokes forming a V shape — with a vermillion needle through the center.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120" fill="none">
  <!-- Outer V — left stroke -->
  <line x1="10" y1="20" x2="60" y2="100" stroke="#B8C0CC" stroke-width="3" stroke-linecap="round"/>
  <!-- Outer V — right stroke -->
  <line x1="110" y1="20" x2="60" y2="100" stroke="#B8C0CC" stroke-width="3" stroke-linecap="round"/>
  <!-- Inner V — left stroke (thinner) -->
  <line x1="24" y1="20" x2="60" y2="88" stroke="#8C9BAB" stroke-width="1.5" stroke-linecap="round"/>
  <!-- Inner V — right stroke (thinner) -->
  <line x1="96" y1="20" x2="60" y2="88" stroke="#8C9BAB" stroke-width="1.5" stroke-linecap="round"/>
  <!-- The Needle — vermillion, vertical, through center -->
  <line x1="60" y1="10" x2="60" y2="110" stroke="#C03A2B" stroke-width="1.5" stroke-linecap="round"/>
</svg>
```

**Note to CT:** Replace v-logo-placeholder.svg with your actual V logo images.
Place them in /public/assets/ and update the src references in VLogo.jsx.

### 1E — src/components/Hero/VLogo.jsx

```jsx
import { useEffect, useRef } from 'react'
import { motion } from 'framer-motion'

export default function VLogo({ size = 120, animated = false }) {
  if (!animated) {
    return (
      <img
        src="/assets/v-logo-placeholder.svg"
        alt="V"
        width={size}
        height={size}
        style={{ filter: 'drop-shadow(0 0 20px rgba(192,58,43,0.4))' }}
      />
    )
  }

  // Animated version — draws itself in
  const paths = [
    { d: "M10,20 L60,100", delay: 0,   stroke: "#B8C0CC", width: 3 },
    { d: "M110,20 L60,100", delay: 0.3, stroke: "#B8C0CC", width: 3 },
    { d: "M24,20 L60,88",  delay: 0.6, stroke: "#8C9BAB", width: 1.5 },
    { d: "M96,20 L60,88",  delay: 0.9, stroke: "#8C9BAB", width: 1.5 },
    { d: "M60,10 L60,110", delay: 1.4, stroke: "#C03A2B", width: 1.5 },
  ]

  return (
    <svg
      width={size} height={size}
      viewBox="0 0 120 120"
      fill="none"
      style={{ filter: 'drop-shadow(0 0 24px rgba(192,58,43,0.35))' }}
    >
      {paths.map((p, i) => (
        <motion.path
          key={i}
          d={p.d}
          stroke={p.stroke}
          strokeWidth={p.width}
          strokeLinecap="round"
          initial={{ pathLength: 0, opacity: 0 }}
          animate={{ pathLength: 1, opacity: 1 }}
          transition={{ duration: 0.8, delay: p.delay, ease: "easeInOut" }}
        />
      ))}
    </svg>
  )
}
```

### 1F — src/App.jsx (skeleton only)

```jsx
import './styles/globals.css'
import Hero from './components/Hero/Hero'
import Problem from './components/Problem/Problem'
import Revelation from './components/Revelation/Revelation'
import Architecture from './components/Architecture/Architecture'
import MathTeaser from './components/MathTeaser/MathTeaser'
import Vision from './components/Vision/Vision'
import Moat from './components/Moat/Moat'
import Scale from './components/Scale/Scale'
import Contact from './components/Contact/Contact'
import Footer from './components/Footer'
import Nav from './components/Nav'

export default function App() {
  return (
    <main className="bg-void text-light">
      <Nav />
      <Hero />
      <Problem />
      <Revelation />
      <Architecture />
      <MathTeaser />
      <Vision />
      <Moat />
      <Scale />
      <Contact />
      <Footer />
    </main>
  )
}
```

### 1G — src/main.jsx

```jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
```

### 1H — All section components (stubbed)

Create each as a minimal stub that renders its background so the page scrolls:

```jsx
// Pattern for each stub — replace SECTION with actual section name
export default function SECTION() {
  return (
    <section className="v-section flex items-center justify-center">
      <p className="v-label">[SECTION NAME]</p>
    </section>
  )
}
```

Create stubs for: Nav, Problem, Revelation, Architecture, MathTeaser, Vision, Moat,
Scale, Contact, Footer.

**CHECKPOINT 1:** Run `npm run dev`. You should see a dark void page with section
labels stacked vertically. Fonts loading. No errors in console.

---

## PASS 2 — HERO SECTION + NEURAL BACKGROUND

**Goal:** The hero comes alive. Dark space fills with forming neural threads.
V logo assembles itself. The hook text appears. This is the most important section
— if this doesn't hit, nothing else matters.

### 2A — Neural Background Shader

The background is a WebGL canvas that fills the viewport. It shows:
- Deep black space with subtle blue undertone
- ~200 nodes as small bright points, slowly drifting
- Edges connecting nearby nodes, appearing and fading based on distance
- Occasional brighter flashes as if data flows through an edge
- Amber/gold primary color for nodes, thin chrome for edges

Create `src/three/NeuralMesh.jsx`:

```jsx
import { useRef, useMemo, useFrame } from '@react-three/fiber'
import { Canvas } from '@react-three/fiber'
import * as THREE from 'three'

function NeuralNodes() {
  const meshRef = useRef()
  const linesRef = useRef()
  const timeRef = useRef(0)

  const NODE_COUNT = 180

  // Generate stable node positions
  const positions = useMemo(() => {
    const pos = []
    for (let i = 0; i < NODE_COUNT; i++) {
      pos.push(
        (Math.random() - 0.5) * 24,
        (Math.random() - 0.5) * 14,
        (Math.random() - 0.5) * 8
      )
    }
    return new Float32Array(pos)
  }, [])

  // Generate velocities for slow drift
  const velocities = useMemo(() => {
    const vel = []
    for (let i = 0; i < NODE_COUNT; i++) {
      vel.push(
        (Math.random() - 0.5) * 0.004,
        (Math.random() - 0.5) * 0.004,
        (Math.random() - 0.5) * 0.002
      )
    }
    return vel
  }, [])

  // Build edge list — connect nodes within threshold distance
  const { edgePositions, edgeCount } = useMemo(() => {
    const THRESHOLD = 4.5
    const edges = []
    const pts = positions
    for (let i = 0; i < NODE_COUNT; i++) {
      for (let j = i + 1; j < NODE_COUNT; j++) {
        const dx = pts[i*3] - pts[j*3]
        const dy = pts[i*3+1] - pts[j*3+1]
        const dz = pts[i*3+2] - pts[j*3+2]
        const dist = Math.sqrt(dx*dx + dy*dy + dz*dz)
        if (dist < THRESHOLD) {
          edges.push(pts[i*3], pts[i*3+1], pts[i*3+2])
          edges.push(pts[j*3], pts[j*3+1], pts[j*3+2])
        }
      }
    }
    return { edgePositions: new Float32Array(edges), edgeCount: edges.length / 6 }
  }, [positions])

  // Node geometry
  const nodeGeo = useMemo(() => {
    const geo = new THREE.BufferGeometry()
    geo.setAttribute('position', new THREE.BufferAttribute(positions.slice(), 3))
    return geo
  }, [positions])

  // Edge geometry
  const edgeGeo = useMemo(() => {
    const geo = new THREE.BufferGeometry()
    geo.setAttribute('position', new THREE.BufferAttribute(edgePositions.slice(), 3))
    return geo
  }, [edgePositions])

  useFrame((state) => {
    timeRef.current += 0.01
    // Gentle drift — update node positions
    const posArr = meshRef.current?.geometry?.attributes?.position?.array
    if (!posArr) return
    for (let i = 0; i < NODE_COUNT; i++) {
      posArr[i*3]   += velocities[i*3]   * Math.sin(timeRef.current * 0.3 + i * 0.1)
      posArr[i*3+1] += velocities[i*3+1] * Math.cos(timeRef.current * 0.2 + i * 0.15)
      posArr[i*3+2] += velocities[i*3+2] * Math.sin(timeRef.current * 0.4 + i * 0.05)
      // Boundary bounce
      if (Math.abs(posArr[i*3]) > 12) velocities[i*3] *= -1
      if (Math.abs(posArr[i*3+1]) > 7) velocities[i*3+1] *= -1
      if (Math.abs(posArr[i*3+2]) > 4) velocities[i*3+2] *= -1
    }
    meshRef.current.geometry.attributes.position.needsUpdate = true
  })

  return (
    <>
      {/* Nodes */}
      <points ref={meshRef} geometry={nodeGeo}>
        <pointsMaterial
          size={0.06}
          color="#D4A853"
          transparent
          opacity={0.7}
          sizeAttenuation
        />
      </points>
      {/* Edges */}
      <lineSegments geometry={edgeGeo}>
        <lineBasicMaterial
          color="#B8C0CC"
          transparent
          opacity={0.08}
        />
      </lineSegments>
    </>
  )
}

export default function NeuralBackground() {
  return (
    <div
      style={{
        position: 'absolute', inset: 0,
        zIndex: 0,
        pointerEvents: 'none',
      }}
    >
      <Canvas
        camera={{ position: [0, 0, 10], fov: 65 }}
        gl={{ antialias: true, alpha: true }}
        style={{ background: 'transparent' }}
      >
        <NeuralNodes />
      </Canvas>
    </div>
  )
}
```

### 2B — E₈ Crystal (background accent in hero)

Create `src/three/EightCrystal.jsx`. This renders a slowly rotating crystalline
geometry — approximating the dense E₈ structure — as a background element in the
architecture section and math section:

```jsx
import { useRef, useMemo } from 'react'
import { useFrame } from '@react-three/fiber'
import * as THREE from 'three'

export default function EightCrystal({ size = 2, opacity = 0.3, speed = 0.003 }) {
  const groupRef = useRef()

  // Generate E₈-inspired geometry: 240 vertices, densely connected
  const { vertices, edges } = useMemo(() => {
    const verts = []
    const edgeList = []

    // Create 240 vertices arranged in nested shells — approximates E₈ visual
    // Shell 1: icosahedron (12 vertices)
    const phi = (1 + Math.sqrt(5)) / 2
    const base12 = [
      [0, 1, phi], [0, -1, phi], [0, 1, -phi], [0, -1, -phi],
      [1, phi, 0], [-1, phi, 0], [1, -phi, 0], [-1, -phi, 0],
      [phi, 0, 1], [-phi, 0, 1], [phi, 0, -1], [-phi, 0, -1],
    ]

    // Shell 2: dodecahedron (20 vertices)
    const psi = 1 / phi
    const base20 = []
    for (let s1 of [-1, 1])
    for (let s2 of [-1, 1])
    for (let s3 of [-1, 1]) {
      base20.push([s1, s2, s3])
    }
    for (let s of [-1, 1]) {
      base20.push([0, s * psi, s * phi])
      base20.push([0, -s * psi, s * phi])
      base20.push([s * psi, s * phi, 0])
      base20.push([-s * psi, s * phi, 0])
      base20.push([s * phi, 0, s * psi])
      base20.push([s * phi, 0, -s * psi])
    }

    // Combine and normalize, scale to varied radii to create crystal depth
    const allBase = [...base12, ...base20]
    allBase.forEach((v, i) => {
      const len = Math.sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
      const scale = size * (0.6 + (i % 5) * 0.15)
      verts.push(v[0]/len * scale, v[1]/len * scale, v[2]/len * scale)
    })

    // Add orbital shell — more vertices at outer radius
    for (let i = 0; i < 80; i++) {
      const theta = (i / 80) * Math.PI * 2
      const phi2 = Math.acos(1 - 2 * (i + 0.5) / 80)
      verts.push(
        size * 1.8 * Math.sin(phi2) * Math.cos(theta),
        size * 1.8 * Math.sin(phi2) * Math.sin(theta),
        size * 1.8 * Math.cos(phi2)
      )
    }

    const N = verts.length / 3
    // Connect nearby vertices
    for (let i = 0; i < N; i++) {
      for (let j = i + 1; j < N; j++) {
        const dx = verts[i*3] - verts[j*3]
        const dy = verts[i*3+1] - verts[j*3+1]
        const dz = verts[i*3+2] - verts[j*3+2]
        const dist = Math.sqrt(dx*dx + dy*dy + dz*dz)
        if (dist < size * 0.9) {
          edgeList.push(verts[i*3], verts[i*3+1], verts[i*3+2])
          edgeList.push(verts[j*3], verts[j*3+1], verts[j*3+2])
        }
      }
    }

    return {
      vertices: new Float32Array(verts),
      edges: new Float32Array(edgeList)
    }
  }, [size])

  const nodeGeo = useMemo(() => {
    const g = new THREE.BufferGeometry()
    g.setAttribute('position', new THREE.BufferAttribute(vertices, 3))
    return g
  }, [vertices])

  const edgeGeo = useMemo(() => {
    const g = new THREE.BufferGeometry()
    g.setAttribute('position', new THREE.BufferAttribute(edges, 3))
    return g
  }, [edges])

  useFrame(() => {
    if (!groupRef.current) return
    groupRef.current.rotation.x += speed * 0.6
    groupRef.current.rotation.y += speed
    groupRef.current.rotation.z += speed * 0.3
  })

  return (
    <group ref={groupRef}>
      <points geometry={nodeGeo}>
        <pointsMaterial size={0.05} color="#D4A853" transparent opacity={opacity * 1.5} />
      </points>
      <lineSegments geometry={edgeGeo}>
        <lineBasicMaterial color="#8C9BAB" transparent opacity={opacity * 0.5} />
      </lineSegments>
    </group>
  )
}
```

### 2C — Hero Section

Create `src/components/Hero/Hero.jsx`:

```jsx
import { useEffect, useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Canvas } from '@react-three/fiber'
import NeuralBackground from '../../three/NeuralMesh'
import VLogo from './VLogo'

const HOOK_LINES = [
  "There's something a little off about AI.",
  "It doesn't remember you.",
  "It doesn't know how you think.",
  "Every session — a stranger.",
]

export default function Hero() {
  const [hookIndex, setHookIndex] = useState(0)
  const [showReveal, setShowReveal] = useState(false)

  useEffect(() => {
    if (hookIndex < HOOK_LINES.length - 1) {
      const t = setTimeout(() => setHookIndex(i => i + 1), 1800)
      return () => clearTimeout(t)
    } else {
      const t = setTimeout(() => setShowReveal(true), 1600)
      return () => clearTimeout(t)
    }
  }, [hookIndex])

  return (
    <section
      className="v-section"
      style={{
        height: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: 'radial-gradient(ellipse at 50% 50%, #0d1220 0%, #070a10 70%)',
        position: 'relative',
        overflow: 'hidden',
      }}
    >
      {/* Neural background canvas */}
      <NeuralBackground />

      {/* Ambient vignette */}
      <div style={{
        position: 'absolute', inset: 0, zIndex: 1,
        background: 'radial-gradient(ellipse at 50% 50%, transparent 30%, rgba(7,10,16,0.8) 100%)',
        pointerEvents: 'none',
      }} />

      {/* Content */}
      <div style={{
        position: 'relative', zIndex: 2,
        textAlign: 'center',
        maxWidth: '900px',
        padding: '0 2rem',
      }}>
        {/* V Logo — assembles itself */}
        <motion.div
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 1.2, ease: 'easeOut' }}
          style={{ marginBottom: '2.5rem' }}
        >
          <VLogo size={100} animated={true} />
        </motion.div>

        {/* Tagline */}
        <motion.div
          initial={{ opacity: 0, letterSpacing: '0.5em' }}
          animate={{ opacity: 1, letterSpacing: '0.25em' }}
          transition={{ duration: 1, delay: 2.2 }}
          style={{
            fontFamily: 'JetBrains Mono, monospace',
            fontSize: '0.7rem',
            letterSpacing: '0.25em',
            textTransform: 'uppercase',
            color: 'var(--v-slate)',
            marginBottom: '3rem',
          }}
        >
          IDENTITY&nbsp;&nbsp;|&nbsp;&nbsp;BIOLOGY&nbsp;&nbsp;|&nbsp;&nbsp;MACHINE
        </motion.div>

        {/* Hook text — cycles through lines */}
        <div style={{ minHeight: '5rem', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <AnimatePresence mode="wait">
            <motion.p
              key={hookIndex}
              initial={{ opacity: 0, y: 12 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -12 }}
              transition={{ duration: 0.5 }}
              style={{
                fontFamily: 'Playfair Display, serif',
                fontSize: 'clamp(1.4rem, 3vw, 2.2rem)',
                fontWeight: 400,
                fontStyle: 'italic',
                color: 'var(--v-light)',
                lineHeight: 1.3,
              }}
            >
              {HOOK_LINES[hookIndex]}
            </motion.p>
          </AnimatePresence>
        </div>

        {/* The Reveal */}
        <AnimatePresence>
          {showReveal && (
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8 }}
              style={{ marginTop: '2rem' }}
            >
              <p style={{
                fontFamily: 'Playfair Display, serif',
                fontSize: 'clamp(3rem, 8vw, 6rem)',
                fontWeight: 900,
                color: 'var(--v-signal)',
                lineHeight: 1,
                letterSpacing: '-0.02em',
                textShadow: '0 0 60px rgba(192,58,43,0.4)',
              }}>
                We know what's missing.
              </p>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Scroll prompt */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 0.5 }}
          transition={{ delay: 5, duration: 1 }}
          style={{
            position: 'absolute',
            bottom: '2rem',
            left: '50%',
            transform: 'translateX(-50%)',
          }}
        >
          <div className="v-label" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '0.5rem' }}>
            <span>SCROLL</span>
            <motion.div
              animate={{ y: [0, 6, 0] }}
              transition={{ duration: 1.5, repeat: Infinity }}
              style={{ width: 1, height: 24, background: 'var(--v-signal)' }}
            />
          </div>
        </motion.div>
      </div>
    </section>
  )
}
```

### 2D — Nav

```jsx
import { motion, useScroll, useTransform } from 'framer-motion'

export default function Nav() {
  const { scrollY } = useScroll()
  const bg = useTransform(scrollY, [0, 100], ['rgba(7,10,16,0)', 'rgba(7,10,16,0.95)'])
  const borderOpacity = useTransform(scrollY, [0, 100], [0, 0.15])

  return (
    <motion.nav
      style={{
        position: 'fixed', top: 0, left: 0, right: 0, zIndex: 100,
        background: bg,
        borderBottom: `1px solid rgba(140,155,171,${borderOpacity})`,
        padding: '1rem 2rem',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
        <img src="/assets/v-logo-placeholder.svg" alt="V" width={28} height={28} />
        <span className="v-label" style={{ color: 'var(--v-light)' }}>V</span>
      </div>
      <div style={{ display: 'flex', gap: '2rem' }}>
        {['Architecture', 'Mathematics', 'Contact'].map(label => (
          <a
            key={label}
            href={`#${label.toLowerCase()}`}
            className="v-label"
            style={{ textDecoration: 'none', transition: 'color 0.2s' }}
            onMouseEnter={e => e.target.style.color = 'var(--v-light)'}
            onMouseLeave={e => e.target.style.color = ''}
          >
            {label}
          </a>
        ))}
      </div>
    </motion.nav>
  )
}
```

**CHECKPOINT 2:** The page loads. Hero section fills the screen. Neural background
animates (nodes drifting, thin edges). V logo draws itself in. Hook text cycles through
4 lines then reveals "We know what's missing." Nav appears on scroll.

---

## PASS 3 — PROBLEM + REVELATION SECTIONS

### 3A — Problem Section

```jsx
import { useRef } from 'react'
import { motion, useInView } from 'framer-motion'

const PROBLEM_STATS = [
  { number: "Session 1", label: "Stranger" },
  { number: "Session 100", label: "Still a stranger" },
  { number: "Session 1,000", label: "Still. A. Stranger." },
]

export default function Problem() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-20%' })

  return (
    <section
      ref={ref}
      className="v-section"
      style={{
        background: 'linear-gradient(180deg, #070a10 0%, #0d1220 100%)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '8rem 2rem',
      }}
    >
      <div style={{ maxWidth: '1100px', width: '100%' }}>
        {/* Label */}
        <motion.p
          initial={{ opacity: 0 }}
          animate={inView ? { opacity: 1 } : {}}
          transition={{ duration: 0.6 }}
          className="v-label"
          style={{ marginBottom: '2rem' }}
        >
          01 — THE PROBLEM
        </motion.p>

        {/* Main statement */}
        <motion.h2
          initial={{ opacity: 0, y: 30 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.9, delay: 0.2 }}
          className="v-display"
          style={{ fontSize: 'clamp(2.5rem, 6vw, 5rem)', marginBottom: '2rem' }}
        >
          AI is extraordinary.<br />
          <span style={{ color: 'var(--v-slate)', fontStyle: 'italic', fontWeight: 400 }}>
            It just doesn't know you.
          </span>
        </motion.h2>

        <div style={{ width: 1, height: 64, background: 'var(--v-signal)', margin: '2rem 0' }} />

        {/* Body */}
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.8, delay: 0.4 }}
          style={{
            fontFamily: 'Inter, sans-serif',
            fontSize: 'clamp(1rem, 1.8vw, 1.25rem)',
            lineHeight: 1.9,
            color: 'var(--v-chrome)',
            maxWidth: '700px',
            marginBottom: '4rem',
          }}
        >
          The frontier models are genuinely remarkable. The reasoning, the knowledge, the
          fluency — unprecedented. But every session, they start from zero. They have no
          model of how you think. They don't know your expertise, your vocabulary, your
          domain bridges, your patterns of reasoning. They learn nothing about you that
          survives to the next conversation.
          <br /><br />
          This is not a model failure. It is a structural gap. No model, however powerful,
          can fill it — because the gap is not about capability. It's about identity.
        </motion.p>

        {/* Stat grid */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '2px' }}>
          {PROBLEM_STATS.map((stat, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, y: 20 }}
              animate={inView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.7, delay: 0.6 + i * 0.15 }}
              style={{
                background: 'rgba(26,32,53,0.5)',
                border: '1px solid rgba(140,155,171,0.08)',
                padding: '2rem',
                textAlign: 'center',
              }}
            >
              <p style={{
                fontFamily: 'JetBrains Mono, monospace',
                fontSize: '1.1rem',
                color: i === 2 ? 'var(--v-signal)' : 'var(--v-ember)',
                marginBottom: '0.5rem',
              }}>
                {stat.number}
              </p>
              <p className="v-label">{stat.label}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
```

### 3B — Revelation Section

```jsx
import { useRef, useState } from 'react'
import { motion, useInView, AnimatePresence } from 'framer-motion'

const TRINITY = [
  {
    word: 'IDENTITY',
    desc: 'Not a persona. Not a preference file. Your actual cognitive topology — the unique way you connect ideas, weight domains, and build knowledge. Encoded permanently.',
  },
  {
    word: 'BIOLOGY',
    desc: 'The Brain mirrors biological memory architecture. Permanent episodic archive. Navigated by association. Compressed by mastery. Growing more specific with every session.',
  },
  {
    word: 'MACHINE',
    desc: 'Mathematically precise. Provably correct. Built from formal theorems, not heuristics. The architecture works identically for any person — guaranteed by the mathematics.',
  },
]

export default function Revelation() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-20%' })
  const [active, setActive] = useState(null)

  return (
    <section
      ref={ref}
      id="revelation"
      className="v-section"
      style={{
        background: '#070a10',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '10rem 2rem',
        textAlign: 'center',
      }}
    >
      {/* The missing word */}
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={inView ? { opacity: 1, scale: 1 } : {}}
        transition={{ duration: 1, delay: 0.2 }}
        style={{ marginBottom: '1rem' }}
      >
        <p style={{
          fontFamily: 'Playfair Display, serif',
          fontSize: 'clamp(4rem, 12vw, 10rem)',
          fontWeight: 900,
          lineHeight: 1,
          letterSpacing: '-0.03em',
          background: `linear-gradient(135deg, var(--v-light) 30%, var(--v-signal) 100%)`,
          WebkitBackgroundClip: 'text',
          WebkitTextFillColor: 'transparent',
          textShadow: 'none',
        }}>
          YOU.
        </p>
      </motion.div>

      {/* Tagline */}
      <motion.p
        initial={{ opacity: 0 }}
        animate={inView ? { opacity: 1 } : {}}
        transition={{ duration: 0.8, delay: 0.8 }}
        className="v-label"
        style={{ marginBottom: '5rem', color: 'var(--v-slate)' }}
      >
        IDENTITY&nbsp;&nbsp;·&nbsp;&nbsp;BIOLOGY&nbsp;&nbsp;·&nbsp;&nbsp;MACHINE
      </motion.p>

      {/* Trinity */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(3, 1fr)',
        gap: '2px',
        maxWidth: '1100px',
        width: '100%',
      }}>
        {TRINITY.map((item, i) => (
          <motion.div
            key={i}
            initial={{ opacity: 0, y: 24 }}
            animate={inView ? { opacity: 1, y: 0 } : {}}
            transition={{ duration: 0.7, delay: 1 + i * 0.2 }}
            onMouseEnter={() => setActive(i)}
            onMouseLeave={() => setActive(null)}
            style={{
              padding: '2.5rem 2rem',
              background: active === i ? 'rgba(26,32,53,0.8)' : 'rgba(13,18,32,0.6)',
              border: `1px solid ${active === i ? 'rgba(192,58,43,0.3)' : 'rgba(140,155,171,0.06)'}`,
              cursor: 'default',
              transition: 'background 0.3s, border-color 0.3s',
            }}
          >
            <p style={{
              fontFamily: 'JetBrains Mono, monospace',
              fontSize: '0.75rem',
              letterSpacing: '0.3em',
              color: active === i ? 'var(--v-signal)' : 'var(--v-ember)',
              marginBottom: '1.5rem',
              transition: 'color 0.3s',
            }}>
              {item.word}
            </p>
            <AnimatePresence>
              {active === i && (
                <motion.p
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: 'auto' }}
                  exit={{ opacity: 0, height: 0 }}
                  style={{
                    fontFamily: 'Inter, sans-serif',
                    fontSize: '0.9rem',
                    lineHeight: 1.8,
                    color: 'var(--v-chrome)',
                    overflow: 'hidden',
                  }}
                >
                  {item.desc}
                </motion.p>
              )}
            </AnimatePresence>
          </motion.div>
        ))}
      </div>
    </section>
  )
}
```

**CHECKPOINT 3:** Scroll past hero into Problem section. Text reveals on scroll.
Stats grid appears. Revelation section: "YOU." appears large, trinity cards respond
to hover with descriptions.

---

## END OF PART 1

Continue in Part 2:
- Pass 4: Architecture (interactive layer explorer) + Math Teaser (Three.js visualizations)
- Pass 5: Vision (multi-vendor orbit) + Moat + Scale + Contact + Footer
- Pass 6: Security (server.js, headers, rate limiting, input sanitization)
- Pass 7: Responsive + performance + deployment

Place Part 2 prompt file at: `Claude.AI/External/Replit.V.Website.Prompt.Part2.md`
Read it and execute its passes sequentially after completing all passes in Part 1.

[VELORIN.EOF]
