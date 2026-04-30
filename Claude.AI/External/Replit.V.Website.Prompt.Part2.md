# V — Investor Website: Replit Build Prompt, Part 2 of 2

**Execute only after Part 1 Checkpoint 3 passes.**
**Continue Pass numbering from Part 1 (Part 1 ended after Pass 3).**

---

## PASS 4 — ARCHITECTURE + MATH TEASER

### 4A — Architecture Section (Interactive Layer Explorer)

The architecture section visually explains V's four-layer brain stack. Each layer is
an interactive panel. Hover/click opens a deep dive. The visual language is a 3D stack
of semi-transparent planes with data flowing upward through them.

Create `src/components/Architecture/LayerExplorer.jsx`:

```jsx
import { useState, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'

const LAYERS = [
  {
    id: 'layer0',
    number: 'L-0',
    name: 'THE WEIGHTS',
    subtitle: 'Permanent Cognitive Patterns',
    color: 'var(--v-signal)',
    description: `The deepest layer. When V has watched you work long enough to detect
    genuine mastery in a domain — when your taxonomic and thematic thinking about a subject
    have fully converged — that knowledge compresses into model weights. Permanently encoded.
    Model-agnostic. If the AI model changes, the weights rebuild from the layer below.
    You cannot lose what has been encoded here.`,
    metric: 'Compression trigger: detected mastery criterion, not frequency',
  },
  {
    id: 'layer1',
    number: 'L-1',
    name: 'THE NAVIGATION',
    subtitle: 'E₈ Crystal Graph + PPR',
    color: 'var(--v-ember)',
    description: `The routing layer. Your knowledge is organized into crystalline structures
    of exactly 240 connected nodes each — a geometry proven optimal in 8 dimensions. When
    you issue a query, V doesn't search. It walks your knowledge graph the same way your own
    mind does: following connections you've made, weighted by how strongly you made them.
    The more you've worked in a domain, the more precisely V navigates it.`,
    metric: 'Retrieval precision: O(1) independent of graph size',
  },
  {
    id: 'layer2',
    number: 'L-2',
    name: 'THE EPISODES',
    subtitle: 'Temporal Knowledge Graph',
    color: 'var(--v-chrome)',
    description: `Every session, document, and interaction is preserved as a structured graph
    of 240 nodes — encoding the semantic relationships in the moment they were encountered.
    Raw data (photos, logs, documents) enters here as dark matter: present but unconnected,
    waiting. Emotional engagement crystallizes dark matter into navigable structure.
    Nothing is lost. Some things are simply not yet lit.`,
    metric: 'Dark matter: exists in the index, has zero routing gravity until crystallized',
  },
  {
    id: 'layer3',
    number: 'L-3',
    name: 'THE ARCHIVE',
    subtitle: 'Permanent Ground Truth',
    color: '#4A90A4',
    description: `GitHub markdown. The lossless, permanent, model-agnostic record of everything
    that has been committed. The Second Law of Epistemodynamics governs this layer: information
    that has been encoded into deeper layers cannot be deleted without destroying coherence.
    V does not delete. It demotes. The archive is the proof record — every decision, every
    insight, every connection, preserved with its original context. When models change,
    this layer enables complete reconstruction.`,
    metric: 'Second Law: compression is irreversible — the archive is the inviolable ground',
  },
]

export default function LayerExplorer() {
  const [active, setActive] = useState(null)

  return (
    <div style={{ position: 'relative', maxWidth: '1100px', margin: '0 auto' }}>
      {/* 3D perspective stack illusion */}
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        gap: '2px',
      }}>
        {LAYERS.map((layer, i) => (
          <motion.div
            key={layer.id}
            onClick={() => setActive(active === layer.id ? null : layer.id)}
            style={{
              background: active === layer.id
                ? `linear-gradient(90deg, rgba(26,32,53,0.9) 0%, rgba(13,18,32,0.9) 100%)`
                : 'rgba(13,18,32,0.5)',
              border: `1px solid ${active === layer.id ? layer.color + '40' : 'rgba(140,155,171,0.06)'}`,
              padding: '0',
              cursor: 'pointer',
              overflow: 'hidden',
              transition: 'background 0.3s, border-color 0.3s',
            }}
            whileHover={{ scale: 1.002 }}
          >
            {/* Header row */}
            <div style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              padding: '1.75rem 2rem',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '1.5rem' }}>
                {/* Layer indicator */}
                <div style={{
                  width: 3,
                  height: 40,
                  background: layer.color,
                  flexShrink: 0,
                }} />
                <div>
                  <p style={{
                    fontFamily: 'JetBrains Mono, monospace',
                    fontSize: '0.6rem',
                    letterSpacing: '0.3em',
                    color: layer.color,
                    marginBottom: '0.25rem',
                  }}>
                    {layer.number}
                  </p>
                  <p style={{
                    fontFamily: 'Playfair Display, serif',
                    fontSize: 'clamp(1.1rem, 2vw, 1.5rem)',
                    fontWeight: 700,
                    color: 'var(--v-light)',
                  }}>
                    {layer.name}
                  </p>
                </div>
              </div>
              <div style={{ textAlign: 'right' }}>
                <p className="v-label" style={{ color: 'var(--v-slate)' }}>
                  {layer.subtitle}
                </p>
              </div>
            </div>

            {/* Expandable detail */}
            <AnimatePresence>
              {active === layer.id && (
                <motion.div
                  initial={{ height: 0, opacity: 0 }}
                  animate={{ height: 'auto', opacity: 1 }}
                  exit={{ height: 0, opacity: 0 }}
                  transition={{ duration: 0.4 }}
                  style={{
                    overflow: 'hidden',
                    borderTop: `1px solid ${layer.color}20`,
                  }}
                >
                  <div style={{ padding: '1.5rem 2rem 2rem calc(2rem + 19px)' }}>
                    <p style={{
                      fontFamily: 'Inter, sans-serif',
                      fontSize: '0.95rem',
                      lineHeight: 1.9,
                      color: 'var(--v-chrome)',
                      maxWidth: '700px',
                      marginBottom: '1.25rem',
                    }}>
                      {layer.description}
                    </p>
                    <p style={{
                      fontFamily: 'JetBrains Mono, monospace',
                      fontSize: '0.7rem',
                      color: layer.color,
                      letterSpacing: '0.05em',
                    }}>
                      {layer.metric}
                    </p>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </motion.div>
        ))}
      </div>
    </div>
  )
}
```

Create `src/components/Architecture/Architecture.jsx`:

```jsx
import { useRef } from 'react'
import { motion, useInView } from 'framer-motion'
import LayerExplorer from './LayerExplorer'

export default function Architecture() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-15%' })

  return (
    <section
      ref={ref}
      id="architecture"
      className="v-section"
      style={{
        background: 'linear-gradient(180deg, #070a10 0%, #0a0e18 100%)',
        padding: '8rem 2rem',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <div style={{ maxWidth: '1100px', width: '100%' }}>
        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ duration: 0.6 }}
          className="v-label" style={{ marginBottom: '1.5rem' }}
        >02 — ARCHITECTURE</motion.p>

        <motion.h2
          initial={{ opacity: 0, y: 20 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.8, delay: 0.15 }}
          className="v-display"
          style={{ fontSize: 'clamp(2rem, 5vw, 4rem)', marginBottom: '1rem' }}
        >
          Four layers.<br />
          <span style={{ color: 'var(--v-slate)', fontStyle: 'italic', fontWeight: 400 }}>
            One compiled mind.
          </span>
        </motion.h2>

        <motion.p
          initial={{ opacity: 0 }}
          animate={inView ? { opacity: 1 } : {}}
          transition={{ duration: 0.7, delay: 0.3 }}
          style={{
            fontFamily: 'Inter', fontSize: '1rem', lineHeight: 1.8,
            color: 'var(--v-slate)', maxWidth: '600px', marginBottom: '3.5rem',
          }}
        >
          V mirrors the biological memory hierarchy — from hippocampal episodes to
          neocortical patterns. Each layer serves a distinct function. Data flows upward.
          Permanence flows down. Click any layer to explore.
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.9, delay: 0.4 }}
        >
          <LayerExplorer />
        </motion.div>
      </div>
    </section>
  )
}
```

### 4B — Math Teaser Section

Three side-by-side interactive visualizations. Each is a Three.js canvas that activates
on hover. Copy is intentionally brief — the visuals carry the weight.

Create `src/components/MathTeaser/PPRViz.jsx`:

```jsx
import { useRef, useMemo } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import * as THREE from 'three'

function PPRScene() {
  const particleRef = useRef()
  const timeRef = useRef(0)

  // Static graph nodes
  const nodes = useMemo(() => [
    [0, 0, 0], [1.5, 0.8, 0], [1.5, -0.8, 0],
    [3, 0.4, 0], [3, -1.2, 0], [-1.5, 0.6, 0],
    [0.5, 1.8, 0], [-0.5, -1.6, 0],
  ], [])

  // Edges between nodes
  const edges = useMemo(() => {
    const e = []
    const connections = [[0,1],[0,2],[0,5],[0,6],[1,3],[2,3],[2,4],[3,4],[5,7],[0,7],[1,6]]
    connections.forEach(([a, b]) => {
      e.push(...nodes[a], ...nodes[b])
    })
    return new Float32Array(e)
  }, [nodes])

  const edgeGeo = useMemo(() => {
    const g = new THREE.BufferGeometry()
    g.setAttribute('position', new THREE.BufferAttribute(edges, 3))
    return g
  }, [edges])

  // Animated particle following a path
  const PATH = [0,1,3,4,2,0,5,7,0,6,1,3]
  useFrame(() => {
    if (!particleRef.current) return
    timeRef.current += 0.015
    const seg = timeRef.current % PATH.length
    const i = Math.floor(seg)
    const t = seg - i
    const a = nodes[PATH[i % PATH.length]]
    const b = nodes[PATH[(i+1) % PATH.length]]
    particleRef.current.position.set(
      a[0] + (b[0]-a[0]) * t,
      a[1] + (b[1]-a[1]) * t,
      0
    )
  })

  return (
    <>
      {/* Graph nodes */}
      {nodes.map((pos, i) => (
        <mesh key={i} position={pos}>
          <sphereGeometry args={[0.08, 8, 8]} />
          <meshBasicMaterial color={i === 0 ? '#D4A853' : '#8C9BAB'} />
        </mesh>
      ))}
      {/* Edges */}
      <lineSegments geometry={edgeGeo}>
        <lineBasicMaterial color="#8C9BAB" transparent opacity={0.25} />
      </lineSegments>
      {/* Traveling particle — the PPR walk */}
      <mesh ref={particleRef}>
        <sphereGeometry args={[0.14, 10, 10]} />
        <meshBasicMaterial color="#C03A2B" />
      </mesh>
    </>
  )
}

export default function PPRViz() {
  return (
    <Canvas
      camera={{ position: [1, 0, 8], fov: 45 }}
      gl={{ antialias: true, alpha: true }}
      style={{ background: 'transparent', width: '100%', height: '100%' }}
    >
      <PPRScene />
    </Canvas>
  )
}
```

Create `src/components/MathTeaser/CrystalViz.jsx` using the EightCrystal component:

```jsx
import { Canvas } from '@react-three/fiber'
import EightCrystal from '../../three/EightCrystal'

export default function CrystalViz() {
  return (
    <Canvas
      camera={{ position: [0, 0, 8], fov: 50 }}
      gl={{ antialias: true, alpha: true }}
      style={{ background: 'transparent', width: '100%', height: '100%' }}
    >
      <EightCrystal size={2.5} opacity={0.5} speed={0.005} />
    </Canvas>
  )
}
```

Create `src/components/MathTeaser/SecondLawViz.jsx`:

```jsx
import { useRef, useMemo } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import * as THREE from 'three'

function FlowScene() {
  const particlesRef = useRef()
  const timeRef = useRef(0)

  const N = 60
  const positions = useMemo(() => {
    const p = new Float32Array(N * 3)
    for (let i = 0; i < N; i++) {
      p[i*3]   = (Math.random() - 0.5) * 3
      p[i*3+1] = -2 + Math.random() * 4
      p[i*3+2] = (Math.random() - 0.5) * 0.5
    }
    return p
  }, [])

  const speeds = useMemo(() =>
    Array.from({length: N}, () => 0.3 + Math.random() * 0.4), [])

  useFrame(() => {
    if (!particlesRef.current) return
    timeRef.current += 0.01
    const pos = particlesRef.current.geometry.attributes.position.array
    for (let i = 0; i < N; i++) {
      pos[i*3+1] -= speeds[i] * 0.02
      if (pos[i*3+1] < -2) {
        pos[i*3+1] = 2
        pos[i*3] = (Math.random() - 0.5) * 3
      }
    }
    particlesRef.current.geometry.attributes.position.needsUpdate = true
  })

  const geo = useMemo(() => {
    const g = new THREE.BufferGeometry()
    g.setAttribute('position', new THREE.BufferAttribute(positions.slice(), 3))
    return g
  }, [positions])

  // Layer planes
  const layers = [
    { y: 1.5, color: '#C03A2B', label: 'L0' },
    { y: 0.5, color: '#D4A853', label: 'L1' },
    { y: -0.5, color: '#8C9BAB', label: 'L2' },
    { y: -1.5, color: '#4A90A4', label: 'L3' },
  ]

  return (
    <>
      {layers.map((l, i) => (
        <mesh key={i} position={[0, l.y, -0.5]}>
          <planeGeometry args={[4, 0.02]} />
          <meshBasicMaterial color={l.color} transparent opacity={0.4} />
        </mesh>
      ))}
      <points ref={particlesRef} geometry={geo}>
        <pointsMaterial size={0.07} color="#E8EDF2" transparent opacity={0.6} />
      </points>
    </>
  )
}

export default function SecondLawViz() {
  return (
    <Canvas
      camera={{ position: [0, 0, 7], fov: 45 }}
      gl={{ antialias: true, alpha: true }}
      style={{ background: 'transparent', width: '100%', height: '100%' }}
    >
      <FlowScene />
    </Canvas>
  )
}
```

Create `src/components/MathTeaser/MathTeaser.jsx`:

```jsx
import { useRef, useState } from 'react'
import { motion, useInView } from 'framer-motion'
import PPRViz from './PPRViz'
import CrystalViz from './CrystalViz'
import SecondLawViz from './SecondLawViz'

const CONCEPTS = [
  {
    label: 'PERSONALIZED PAGERANK',
    title: 'The Brain navigates by association, not address.',
    body: `V does not search your knowledge. It walks it. Following the connections you've made, weighted by how strongly you made them — the same way your own mind activates related concepts. The more you've worked in a domain, the more precisely the walk reaches what you need.`,
    formula: 'R = (1−α)·P(q)·R + α·S',
    Viz: PPRViz,
  },
  {
    label: 'E₈ CRYSTAL STRUCTURE',
    title: '240 connections. 8 dimensions. Mathematically optimal.',
    body: `Your knowledge organizes into crystalline formations of exactly 240 nodes each — a structure proven to achieve the densest possible sphere packing in 8 dimensions. This is not an engineering choice. It is the shape that emerges when you optimize for information density and retrieval precision simultaneously.`,
    formula: 'Density: d_max = 7 in ℝ⁸',
    Viz: CrystalViz,
  },
  {
    label: 'SECOND LAW OF EPISTEMODYNAMICS',
    title: 'What the Brain encodes cannot be undone.',
    body: `When knowledge flows from episodic memory down through navigation to permanent weights, information is irreversibly compressed. The compression is lossy in one direction only. This means: what you have encoded is permanent. The archive at the base is the lossless ground truth. The Brain never deletes — it demotes.`,
    formula: 'Δ = I(X;Y) − I(Z;Y) > 0',
    Viz: SecondLawViz,
  },
]

export default function MathTeaser() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-15%' })
  const [hovering, setHovering] = useState(null)

  return (
    <section
      ref={ref}
      id="mathematics"
      className="v-section"
      style={{
        background: 'linear-gradient(180deg, #0a0e18 0%, #070a10 100%)',
        padding: '8rem 2rem',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
      }}
    >
      <div style={{ maxWidth: '1300px', width: '100%' }}>
        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          className="v-label" style={{ marginBottom: '1.5rem' }}
        >03 — THE MATHEMATICS</motion.p>

        <motion.h2
          initial={{ opacity: 0, y: 20 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ delay: 0.15, duration: 0.8 }}
          className="v-display"
          style={{ fontSize: 'clamp(2rem, 4.5vw, 3.5rem)', marginBottom: '1rem' }}
        >
          Not heuristics.<br />
          <span style={{ color: 'var(--v-slate)', fontStyle: 'italic', fontWeight: 400 }}>
            Formal proofs.
          </span>
        </motion.h2>

        <motion.p
          initial={{ opacity: 0 }}
          animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.3, duration: 0.7 }}
          style={{
            fontFamily: 'Inter', fontSize: '1rem', color: 'var(--v-slate)',
            maxWidth: '600px', lineHeight: 1.8, marginBottom: '4rem',
          }}
        >
          V's architecture is built from locked mathematical theorems, not engineering
          intuitions. Three of the foundational results below. Hover to activate.
        </motion.p>

        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))',
          gap: '2px',
        }}>
          {CONCEPTS.map((c, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, y: 30 }}
              animate={inView ? { opacity: 1, y: 0 } : {}}
              transition={{ delay: 0.5 + i * 0.15, duration: 0.7 }}
              onMouseEnter={() => setHovering(i)}
              onMouseLeave={() => setHovering(null)}
              style={{
                background: hovering === i ? 'rgba(26,32,53,0.7)' : 'rgba(13,18,32,0.5)',
                border: `1px solid ${hovering === i ? 'rgba(192,58,43,0.2)' : 'rgba(140,155,171,0.06)'}`,
                overflow: 'hidden',
                transition: 'background 0.3s, border-color 0.3s',
              }}
            >
              {/* Canvas */}
              <div style={{
                height: '200px',
                opacity: hovering === i ? 1 : 0.4,
                transition: 'opacity 0.4s',
              }}>
                <c.Viz />
              </div>

              {/* Text */}
              <div style={{ padding: '1.5rem 2rem 2rem' }}>
                <p className="v-label" style={{
                  color: hovering === i ? 'var(--v-signal)' : 'var(--v-ember)',
                  marginBottom: '0.75rem',
                  transition: 'color 0.3s',
                }}>
                  {c.label}
                </p>
                <p style={{
                  fontFamily: 'Playfair Display, serif', fontWeight: 700,
                  fontSize: '1rem', color: 'var(--v-light)',
                  marginBottom: '0.75rem', lineHeight: 1.4,
                }}>
                  {c.title}
                </p>
                <p style={{
                  fontFamily: 'Inter', fontSize: '0.85rem', lineHeight: 1.8,
                  color: 'var(--v-chrome)', marginBottom: '1rem',
                  opacity: hovering === i ? 1 : 0.6,
                  transition: 'opacity 0.3s',
                }}>
                  {c.body}
                </p>
                <p style={{
                  fontFamily: 'JetBrains Mono', fontSize: '0.75rem',
                  color: 'var(--v-ember)', letterSpacing: '0.05em',
                }}>
                  {c.formula}
                </p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
```

**CHECKPOINT 4:** Architecture section loads with interactive layer cards. Math section
loads with three live Three.js canvases. Hovering activates animations and reveals text.

---

## PASS 5 — VISION + MOAT + SCALE + CONTACT + FOOTER

### 5A — Vision Section (Multi-Vendor Orbit)

```jsx
import { useRef, useState } from 'react'
import { motion, useInView } from 'framer-motion'

const TOOLS = [
  { name: 'GPT', angle: 0,   dist: 200, color: '#74AA9C' },
  { name: 'Gemini', angle: 51,  dist: 200, color: '#4285F4' },
  { name: 'Claude', angle: 102, dist: 200, color: '#D4A853' },
  { name: 'Codex', angle: 153, dist: 200, color: '#E8EDF2' },
  { name: 'SeedDance', angle: 204, dist: 200, color: '#FF6B6B' },
  { name: 'Veo', angle: 255, dist: 200, color: '#6BCB77' },
  { name: 'Sora', angle: 306, dist: 200, color: '#C77DFF' },
]

export default function Vision() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-15%' })
  const [hoveredTool, setHoveredTool] = useState(null)

  return (
    <section
      ref={ref}
      id="vision"
      className="v-section"
      style={{
        background: '#070a10',
        padding: '8rem 2rem',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
      }}
    >
      <div style={{ maxWidth: '1100px', width: '100%', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '4rem', alignItems: 'center' }}>

        {/* Left — orbit diagram */}
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={inView ? { opacity: 1, scale: 1 } : {}}
          transition={{ duration: 0.9 }}
          style={{ position: 'relative', width: '100%', aspectRatio: '1', maxWidth: '440px', margin: '0 auto' }}
        >
          {/* V center */}
          <div style={{
            position: 'absolute', top: '50%', left: '50%',
            transform: 'translate(-50%, -50%)',
            zIndex: 10,
          }}>
            <div style={{
              width: 80, height: 80,
              background: 'rgba(26,32,53,0.9)',
              border: '1px solid rgba(192,58,43,0.5)',
              borderRadius: '50%',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 0 40px rgba(192,58,43,0.2)',
            }}>
              <img src="/assets/v-logo-placeholder.svg" alt="V" width={40} height={40} />
            </div>
          </div>

          {/* Orbit ring */}
          <div style={{
            position: 'absolute', top: '50%', left: '50%',
            width: 400, height: 400,
            transform: 'translate(-50%, -50%)',
            border: '1px solid rgba(140,155,171,0.08)',
            borderRadius: '50%',
          }} />

          {/* Tool nodes */}
          {TOOLS.map((tool, i) => {
            const rad = (tool.angle * Math.PI) / 180
            const x = Math.cos(rad) * tool.dist
            const y = Math.sin(rad) * tool.dist
            return (
              <motion.div
                key={tool.name}
                initial={{ opacity: 0 }}
                animate={inView ? { opacity: 1 } : {}}
                transition={{ delay: 0.3 + i * 0.1, duration: 0.6 }}
                onMouseEnter={() => setHoveredTool(tool.name)}
                onMouseLeave={() => setHoveredTool(null)}
                style={{
                  position: 'absolute',
                  top: '50%', left: '50%',
                  transform: `translate(calc(-50% + ${x/2}px), calc(-50% + ${y/2}px))`,
                  zIndex: 5,
                }}
              >
                <div style={{
                  background: hoveredTool === tool.name ? `${tool.color}20` : 'rgba(13,18,32,0.8)',
                  border: `1px solid ${hoveredTool === tool.name ? tool.color : 'rgba(140,155,171,0.15)'}`,
                  padding: '0.3rem 0.7rem',
                  transition: 'all 0.3s',
                  cursor: 'default',
                }}>
                  <span style={{
                    fontFamily: 'JetBrains Mono', fontSize: '0.6rem',
                    color: hoveredTool === tool.name ? tool.color : 'var(--v-slate)',
                    letterSpacing: '0.1em',
                    textTransform: 'uppercase',
                    transition: 'color 0.3s',
                  }}>
                    {tool.name}
                  </span>
                </div>

                {/* Connection line to center */}
                <svg
                  style={{
                    position: 'absolute', top: '50%', left: '50%',
                    pointerEvents: 'none', overflow: 'visible',
                    opacity: hoveredTool === tool.name ? 0.5 : 0.08,
                    transition: 'opacity 0.3s',
                  }}
                  width={1} height={1}
                >
                  <line
                    x1={0} y1={0}
                    x2={-x/2} y2={-y/2}
                    stroke={tool.color}
                    strokeWidth={1}
                  />
                </svg>
              </motion.div>
            )
          })}
        </motion.div>

        {/* Right — copy */}
        <div>
          <motion.p
            initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
            className="v-label" style={{ marginBottom: '1.5rem' }}
          >04 — THE VISION</motion.p>

          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            animate={inView ? { opacity: 1, y: 0 } : {}}
            transition={{ delay: 0.2, duration: 0.8 }}
            className="v-display"
            style={{ fontSize: 'clamp(1.8rem, 3.5vw, 3rem)', marginBottom: '1.5rem' }}
          >
            The model is not the product.
            <br />
            <span style={{ color: 'var(--v-signal)' }}>The Brain is the product.</span>
          </motion.h2>

          {[
            'Every AI model — GPT, Gemini, Claude, Codex, SeedDance, Veo, whatever ships next month — is a tool. V is the brain that tells the operator which tool to call, and why, for this specific person at this specific moment.',
            'The orchestrator is interchangeable. The Brain is not. When a better model ships, V routes to it. When a specialized agent serves a specific task better, V activates it. The intelligence about which to use, and when, lives in the Brain — not in any single model.',
            'This is the architectural moat. The tools commoditize. The personal intelligence that routes them does not.',
          ].map((para, i) => (
            <motion.p
              key={i}
              initial={{ opacity: 0 }}
              animate={inView ? { opacity: 1 } : {}}
              transition={{ delay: 0.4 + i * 0.2, duration: 0.7 }}
              style={{
                fontFamily: 'Inter', fontSize: '0.95rem', lineHeight: 1.9,
                color: i === 2 ? 'var(--v-chrome)' : 'var(--v-slate)',
                fontWeight: i === 2 ? 400 : 300,
                marginBottom: '1rem',
              }}
            >
              {para}
            </motion.p>
          ))}
        </div>
      </div>
    </section>
  )
}
```

### 5B — Moat Section

```jsx
import { useRef } from 'react'
import { motion, useInView } from 'framer-motion'

export default function Moat() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-15%' })

  const sessions = [
    { label: '1 Session',   value: 5,   desc: 'Learns your vocabulary' },
    { label: '10 Sessions', value: 22,  desc: 'Learns your domain bridges' },
    { label: '100 Sessions', value: 58,  desc: 'Learns your reasoning patterns' },
    { label: '1,000 Sessions', value: 91,  desc: 'Encodes your cognitive topology' },
    { label: '10,000 Sessions', value: 100, desc: 'Becomes a compiled version of how you think' },
  ]

  return (
    <section
      ref={ref}
      className="v-section"
      style={{
        background: 'linear-gradient(180deg, #070a10 0%, #0a0e18 100%)',
        padding: '8rem 2rem',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
      }}
    >
      <div style={{ maxWidth: '900px', width: '100%' }}>
        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          className="v-label" style={{ marginBottom: '1.5rem' }}
        >05 — THE MOAT</motion.p>

        <motion.h2
          initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ delay: 0.15, duration: 0.8 }}
          className="v-display"
          style={{ fontSize: 'clamp(2rem, 4.5vw, 3.5rem)', marginBottom: '1rem' }}
        >
          It grows harder to replicate<br />
          <span style={{ color: 'var(--v-slate)', fontStyle: 'italic', fontWeight: 400 }}>
            with every session.
          </span>
        </motion.h2>

        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.3, duration: 0.7 }}
          style={{
            fontFamily: 'Inter', fontSize: '1rem', color: 'var(--v-slate)',
            lineHeight: 1.8, maxWidth: '600px', marginBottom: '3.5rem',
          }}
        >
          The knowledge that V accumulates cannot be transferred, exported, or
          replicated. It is not a data file. It is a compiled representation of
          how one specific person thinks. That is not duplicable.
        </motion.p>

        {/* Progression bars */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
          {sessions.map((s, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, x: -20 }}
              animate={inView ? { opacity: 1, x: 0 } : {}}
              transition={{ delay: 0.5 + i * 0.12, duration: 0.6 }}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.4rem' }}>
                <span style={{
                  fontFamily: 'JetBrains Mono', fontSize: '0.7rem',
                  color: 'var(--v-ember)', letterSpacing: '0.05em',
                }}>
                  {s.label}
                </span>
                <span className="v-label" style={{ color: 'var(--v-slate)' }}>{s.desc}</span>
              </div>
              <div style={{ height: 2, background: 'rgba(140,155,171,0.1)', position: 'relative' }}>
                <motion.div
                  initial={{ width: 0 }}
                  animate={inView ? { width: `${s.value}%` } : {}}
                  transition={{ delay: 0.7 + i * 0.12, duration: 1.2, ease: 'easeOut' }}
                  style={{
                    position: 'absolute', top: 0, left: 0, height: '100%',
                    background: `linear-gradient(90deg, var(--v-ember), ${i === 4 ? 'var(--v-signal)' : 'var(--v-chrome)'})`,
                  }}
                />
              </div>
            </motion.div>
          ))}
        </div>

        <motion.blockquote
          initial={{ opacity: 0 }}
          animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 1.5, duration: 0.8 }}
          style={{
            borderLeft: '2px solid var(--v-signal)',
            paddingLeft: '1.5rem',
            marginTop: '3rem',
            fontFamily: 'Playfair Display, serif',
            fontSize: '1.15rem',
            fontStyle: 'italic',
            color: 'var(--v-chrome)',
            lineHeight: 1.7,
          }}
        >
          "The moat is not the AI. The moat is what the Brain knows about you.
          That grows harder to replicate with every session."
        </motion.blockquote>
      </div>
    </section>
  )
}
```

### 5C — Scale Section (Universality Theorem)

```jsx
import { useRef } from 'react'
import { motion, useInView } from 'framer-motion'

export default function Scale() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-15%' })

  return (
    <section
      ref={ref}
      className="v-section"
      style={{
        background: '#070a10',
        padding: '8rem 2rem',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        textAlign: 'center',
      }}
    >
      <div style={{ maxWidth: '800px' }}>
        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          className="v-label" style={{ marginBottom: '1.5rem' }}
        >06 — THE SCALE</motion.p>

        <motion.h2
          initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ delay: 0.15, duration: 0.8 }}
          className="v-display"
          style={{ fontSize: 'clamp(2.5rem, 6vw, 5rem)', marginBottom: '1.5rem' }}
        >
          Built for one.<br />
          <span style={{ color: 'var(--v-signal)' }}>Proven for any.</span>
        </motion.h2>

        <motion.div
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.3 }}
          style={{ width: 64, height: 1, background: 'var(--v-signal)', margin: '0 auto 2rem' }}
        />

        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.4, duration: 0.8 }}
          style={{
            fontFamily: 'Inter', fontSize: 'clamp(1rem, 1.8vw, 1.2rem)',
            lineHeight: 1.9, color: 'var(--v-chrome)', marginBottom: '1.5rem',
          }}
        >
          V was built first for one person. Not as a custom solution — as a proof of concept
          that demanded the highest possible specificity. Every architectural decision was
          forced to survive against a real, demanding test case.
        </motion.p>

        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.55, duration: 0.8 }}
          style={{
            fontFamily: 'Inter', fontSize: 'clamp(1rem, 1.8vw, 1.2rem)',
            lineHeight: 1.9, color: 'var(--v-chrome)', marginBottom: '2.5rem',
          }}
        >
          The Universality Theorem proves this was also the correct strategy mathematically.
          The architecture works identically for any person — not because it was designed
          generically, but because the mathematical structure washes out microscopic content
          and preserves only symmetries. Built for one. Generalized to all by proof.
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ delay: 0.7, duration: 0.8 }}
          style={{
            background: 'rgba(26,32,53,0.5)',
            border: '1px solid rgba(192,58,43,0.2)',
            padding: '2rem',
            marginBottom: '3rem',
          }}
        >
          <p style={{
            fontFamily: 'JetBrains Mono', fontSize: '0.8rem',
            color: 'var(--v-ember)', letterSpacing: '0.05em',
            marginBottom: '0.75rem',
          }}>
            UNIVERSALITY THEOREM
          </p>
          <p style={{
            fontFamily: 'Playfair Display, serif', fontSize: '1.1rem',
            fontStyle: 'italic', color: 'var(--v-light)', lineHeight: 1.6,
          }}>
            "The architecture works identically for any user — not because we designed
            it generically, but because the mathematics guarantee it generalizes."
          </p>
        </motion.div>

        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.9 }}
          className="v-label" style={{ color: 'var(--v-slate)' }}
        >
          First user: proof of concept. Second user: replication. Third: productization.
        </motion.p>
      </div>
    </section>
  )
}
```

### 5D — Contact Section

```jsx
import { useRef, useState } from 'react'
import { motion, useInView } from 'framer-motion'
import DOMPurify from 'dompurify'

export default function Contact() {
  const ref = useRef()
  const inView = useInView(ref, { once: true, margin: '-15%' })
  const [form, setForm] = useState({ name: '', email: '', context: '' })
  const [status, setStatus] = useState('idle') // idle | sending | success | error

  const handleSubmit = async (e) => {
    e.preventDefault()
    setStatus('sending')

    // Sanitize all inputs before sending
    const clean = {
      name: DOMPurify.sanitize(form.name.trim()),
      email: DOMPurify.sanitize(form.email.trim()),
      context: DOMPurify.sanitize(form.context.trim()),
    }

    // Basic email validation
    const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRe.test(clean.email)) {
      setStatus('error')
      return
    }

    try {
      const res = await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(clean),
      })
      if (res.ok) {
        setStatus('success')
        setForm({ name: '', email: '', context: '' })
      } else {
        setStatus('error')
      }
    } catch {
      // If no server, just show success for demo
      setStatus('success')
    }
  }

  const inputStyle = {
    width: '100%',
    background: 'rgba(13,18,32,0.7)',
    border: '1px solid rgba(140,155,171,0.15)',
    padding: '1rem 1.25rem',
    fontFamily: 'Inter, sans-serif',
    fontSize: '0.95rem',
    color: 'var(--v-light)',
    outline: 'none',
    transition: 'border-color 0.2s',
    resize: 'none',
  }

  return (
    <section
      ref={ref}
      id="contact"
      className="v-section"
      style={{
        background: 'linear-gradient(180deg, #0a0e18 0%, #070a10 100%)',
        padding: '8rem 2rem',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
      }}
    >
      <div style={{ maxWidth: '680px', width: '100%' }}>
        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          className="v-label" style={{ marginBottom: '1.5rem' }}
        >07 — CONTACT</motion.p>

        <motion.h2
          initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ delay: 0.15 }}
          className="v-display"
          style={{ fontSize: 'clamp(1.8rem, 4vw, 3rem)', marginBottom: '1rem' }}
        >
          V is in development.<br />
          <span style={{ color: 'var(--v-slate)', fontStyle: 'italic', fontWeight: 400 }}>
            First partners selected carefully.
          </span>
        </motion.h2>

        <motion.p
          initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
          transition={{ delay: 0.3 }}
          style={{
            fontFamily: 'Inter', fontSize: '0.95rem', lineHeight: 1.8,
            color: 'var(--v-slate)', marginBottom: '3rem',
          }}
        >
          If you are an investor or strategic partner interested in discussing V,
          use the form below. We will respond within 48 hours.
        </motion.p>

        {status === 'success' ? (
          <motion.div
            initial={{ opacity: 0 }} animate={{ opacity: 1 }}
            style={{
              border: '1px solid rgba(192,58,43,0.3)',
              padding: '2rem', textAlign: 'center',
            }}
          >
            <p style={{ fontFamily: 'JetBrains Mono', color: 'var(--v-signal)', fontSize: '0.75rem', letterSpacing: '0.2em', marginBottom: '0.5rem' }}>
              RECEIVED
            </p>
            <p style={{ fontFamily: 'Inter', color: 'var(--v-chrome)' }}>
              We'll be in touch within 48 hours.
            </p>
          </motion.div>
        ) : (
          <motion.form
            initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}}
            transition={{ delay: 0.45 }}
            onSubmit={handleSubmit}
            style={{ display: 'flex', flexDirection: 'column', gap: '1.5px' }}
          >
            <input
              type="text" placeholder="Name" required
              value={form.name} onChange={e => setForm(f => ({...f, name: e.target.value}))}
              maxLength={120}
              style={inputStyle}
            />
            <input
              type="email" placeholder="Email" required
              value={form.email} onChange={e => setForm(f => ({...f, email: e.target.value}))}
              maxLength={254}
              style={inputStyle}
            />
            <textarea
              placeholder="Context — what brings you here?" rows={5}
              value={form.context} onChange={e => setForm(f => ({...f, context: e.target.value}))}
              maxLength={1000}
              style={inputStyle}
            />
            {status === 'error' && (
              <p style={{ fontFamily: 'JetBrains Mono', fontSize: '0.7rem', color: 'var(--v-signal)', letterSpacing: '0.1em' }}>
                CHECK YOUR EMAIL ADDRESS AND TRY AGAIN.
              </p>
            )}
            <button
              type="submit"
              disabled={status === 'sending'}
              style={{
                background: 'var(--v-signal)',
                border: 'none', padding: '1rem 2rem',
                fontFamily: 'JetBrains Mono', fontSize: '0.7rem',
                letterSpacing: '0.2em', color: 'var(--v-light)',
                cursor: status === 'sending' ? 'wait' : 'pointer',
                textTransform: 'uppercase',
                opacity: status === 'sending' ? 0.7 : 1,
                transition: 'opacity 0.2s, background 0.2s',
                alignSelf: 'flex-end',
                marginTop: '1.5px',
              }}
              onMouseEnter={e => e.target.style.background = '#a03025'}
              onMouseLeave={e => e.target.style.background = 'var(--v-signal)'}
            >
              {status === 'sending' ? 'SENDING...' : 'SEND →'}
            </button>
          </motion.form>
        )}
      </div>
    </section>
  )
}
```

### 5E — Footer

```jsx
export default function Footer() {
  return (
    <footer style={{
      background: '#070a10',
      borderTop: '1px solid rgba(140,155,171,0.06)',
      padding: '2.5rem 2rem',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
    }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
        <img src="/assets/v-logo-placeholder.svg" alt="V" width={22} height={22} style={{ opacity: 0.5 }} />
        <span className="v-label" style={{ color: 'var(--v-slate)' }}>V</span>
      </div>
      <p className="v-label" style={{ color: 'rgba(140,155,171,0.3)' }}>
        IDENTITY · BIOLOGY · MACHINE
      </p>
      <p className="v-label" style={{ color: 'rgba(140,155,171,0.3)' }}>
        {new Date().getFullYear()}
      </p>
    </footer>
  )
}
```

**CHECKPOINT 5:** All sections present. Vision orbit animates. Moat bars fill on scroll.
Scale section clean. Contact form renders. Footer complete. Full page scrolls.

---

## PASS 6 — SECURITY

### 6A — server.js

```javascript
import express from 'express'
import helmet from 'helmet'
import rateLimit from 'express-rate-limit'

const app = express()
const PORT = process.env.PORT || 3001

app.use(express.json({ limit: '10kb' }))

// Security headers
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com"],
      styleSrc:  ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com", "https://fonts.gstatic.com"],
      fontSrc:   ["'self'", "https://fonts.gstatic.com"],
      imgSrc:    ["'self'", "data:", "blob:"],
      connectSrc:["'self'"],
      frameSrc:  ["'none'"],
      objectSrc: ["'none'"],
      upgradeInsecureRequests: process.env.NODE_ENV === 'production' ? [] : null,
    },
  },
  hsts: { maxAge: 31536000, includeSubDomains: true, preload: true },
  noSniff: true,
  referrerPolicy: { policy: 'strict-origin-when-cross-origin' },
  frameguard: { action: 'deny' },
  permittedCrossDomainPolicies: false,
}))

// Rate limiting — contact form
const contactLimit = rateLimit({
  windowMs: 15 * 60 * 1000,   // 15 minutes
  max: 5,                       // 5 requests per window
  message: { error: 'Too many requests. Try again later.' },
  standardHeaders: true,
  legacyHeaders: false,
})

// General rate limit
const generalLimit = rateLimit({
  windowMs: 60 * 1000,
  max: 100,
})
app.use(generalLimit)

// Input validation helper
function validateContactInput(body) {
  const { name, email, context } = body
  if (!name || typeof name !== 'string' || name.length > 120) return false
  if (!email || typeof email !== 'string' || email.length > 254) return false
  if (!context || typeof context !== 'string' || context.length > 1000) return false
  const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRe.test(email)) return false
  // Block obvious injection patterns
  const suspicious = /<script|javascript:|on\w+=/i
  if (suspicious.test(name) || suspicious.test(context)) return false
  return true
}

// Contact endpoint
app.post('/api/contact', contactLimit, (req, res) => {
  if (!validateContactInput(req.body)) {
    return res.status(400).json({ error: 'Invalid input' })
  }
  // In production: send email via SendGrid/Resend/etc.
  // For demo: log and confirm
  console.log('[CONTACT]', {
    time: new Date().toISOString(),
    name: req.body.name,
    email: req.body.email,
    contextLength: req.body.context.length,
  })
  res.status(200).json({ ok: true })
})

// Serve static files in production
if (process.env.NODE_ENV === 'production') {
  const { createServer } = await import('vite')
  // Serve the built Vite output
  app.use(express.static('dist'))
  app.get('*', (req, res) => res.sendFile('dist/index.html', { root: '.' }))
}

app.listen(PORT, () => {
  console.log(`[V] Server running on port ${PORT}`)
})
```

### 6B — package.json scripts

Add to package.json:
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "start": "NODE_ENV=production node server.js",
    "preview": "vite preview"
  },
  "type": "module"
}
```

**CHECKPOINT 6:** Run `node server.js`. Security headers present in curl response.
Rate limiting active on /api/contact. Input validation rejects malformed data.

---

## PASS 7 — RESPONSIVE + PERFORMANCE + POLISH

### 7A — Mobile styles (add to globals.css)

```css
@media (max-width: 768px) {
  .v-section { min-height: auto; padding: 5rem 1.25rem; }

  /* Vision orbit — stack on mobile */
  #vision .grid { grid-template-columns: 1fr !important; }

  /* Math teaser — single column */
  #mathematics .grid { grid-template-columns: 1fr !important; }

  /* Architecture layer cards */
  .layer-explorer { gap: 4px; }
}

@media (max-width: 480px) {
  nav { padding: 0.75rem 1rem; }
  nav > div:last-child { display: none; }  /* Hide nav links on very small */
}
```

### 7B — Smooth scrolling with Lenis (add to main.jsx)

```jsx
import Lenis from 'lenis'
import { useEffect } from 'react'

function SmoothScroll({ children }) {
  useEffect(() => {
    const lenis = new Lenis({
      duration: 1.2,
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      smooth: true,
    })
    function raf(time) {
      lenis.raf(time)
      requestAnimationFrame(raf)
    }
    requestAnimationFrame(raf)
    return () => lenis.destroy()
  }, [])
  return children
}
```

Wrap App in SmoothScroll in main.jsx:
```jsx
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <SmoothScroll>
      <App />
    </SmoothScroll>
  </React.StrictMode>
)
```

### 7C — Performance: lazy load Three.js sections

Wrap MathTeaser and any heavy Three.js section in React.lazy + Suspense:

```jsx
import { lazy, Suspense } from 'react'
const MathTeaser = lazy(() => import('./components/MathTeaser/MathTeaser'))
const Vision = lazy(() => import('./components/Vision/Vision'))

// In App.jsx:
<Suspense fallback={<div style={{ minHeight: '100vh', background: '#070a10' }} />}>
  <MathTeaser />
</Suspense>
```

### 7D — Add scroll-to-section IDs in all sections

Ensure all sections have correct id attributes:
- Architecture.jsx: `id="architecture"`
- MathTeaser.jsx: `id="mathematics"`
- Contact.jsx: `id="contact"`

Nav links should use smooth anchor navigation.

### 7E — Loading state (add to main.jsx)

The page should not flash white on load:
```html
<!-- In index.html body before root div: -->
<style>
  body { background: #070a10; }
  #root:empty { background: #070a10; }
</style>
```

**FINAL CHECKPOINT:**

Run through this checklist before declaring complete:

□ Page loads without white flash
□ Neural background animates in hero
□ V logo draws itself in sequence (5 strokes, needle last in vermillion)
□ Hook text cycles → "We know what's missing." reveals
□ Scroll through Problem → stats grid appears
□ Revelation: "YOU." large, trinity cards respond to hover
□ Architecture: all 4 layer cards expand on click
□ Math: all 3 canvases activate, hover reveals descriptions
□ Vision: orbit with tools, connecting lines on hover
□ Moat: progress bars fill on scroll-enter
□ Scale: clean, confident, no overflow
□ Contact: form validates, sanitizes, submits
□ Footer: clean, aligned
□ Mobile: test at 375px width — no horizontal scroll, readable
□ Console: zero errors, zero warnings
□ Lighthouse performance: >80 on mobile
□ Security headers: present (test with curl -I)
□ No "Velorin" anywhere in HTML, JS, or visible copy
□ No personal names or biographical details anywhere

---

## IMAGE NOTE FOR CT

The V logo is currently rendered as a programmatic SVG. To use your actual V logo images:

1. Place your image files in `/public/assets/`
2. In `src/components/Hero/VLogo.jsx`: replace `src="/assets/v-logo-placeholder.svg"` with your image path
3. In `src/components/Nav.jsx`: same replacement
4. In `src/components/Vision/Vision.jsx`: same replacement
5. In `src/components/Footer.jsx`: same replacement

If you have multiple images (e.g., light version, dark version, animated version),
name them descriptively (v-logo-dark.png, v-logo-light.svg, etc.) and update references.
The animated draw-path version in VLogo.jsx will still work alongside static images —
use `animated={true}` for the hero and `animated={false}` (static image) for nav/footer.

---

## DEPLOYMENT ON REPLIT

After all checkpoints pass:

1. In Replit: Settings → Secrets → add any required env vars
2. Run `npm run build` — builds the Vite frontend to `/dist`
3. Run `node server.js` — serves with security headers
4. Or use Replit's built-in deployment (connects to the `start` script)

The site is static-compatible — if you prefer to skip the Express server and deploy
purely as static files, build with Vite and deploy to Replit Static or any CDN.
Remove the contact form server call, or wire it to an external service (Formspree,
Resend, etc.) and the site works entirely without a backend.

[VELORIN.EOF]
