---
name: figma-and-design-tokens
description: Design tokens architecture, Figma Variables and Style extraction, Design-to-Code mapping, Style Dictionary workflows, and Tailwind/CSS variable synchronization.
---

# Figma Integration & Design Tokens Architecture

## 1. Design Token Hierarchy
- **Tier 1: Global / Reference Tokens**: Raw, context-agnostic primitives (e.g., `color.blue.500: #3b82f6`, `space.4: 16px`, `font.sans: Inter`).
- **Tier 2: Semantic / Alias Tokens**: Intent-based tokens that convey purpose and support theming (e.g., `color.background.primary: {color.blue.500}`, `color.text.muted`).
- **Tier 3: Component Tokens**: Scoped tokens tied to individual UI elements (e.g., `button.primary.bg: {color.background.primary}`, `card.border.radius`).

## 2. Figma to Code Mapping
- **Auto-Layout to Flexbox / Grid**:
  - Vertical Auto-Layout $\rightarrow$ `flex flex-col`
  - Horizontal Auto-Layout $\rightarrow$ `flex flex-row`
  - Gap / Item Spacing $\rightarrow$ `gap-*` (mapped to spacing tokens)
  - Padding (Top/Bottom, Left/Right) $\rightarrow$ `px-* py-*`
  - Space Between / Packed $\rightarrow$ `justify-between` / `justify-start`
  - Fill Container / Hug Contents $\rightarrow$ `flex-1 w-full` / `w-fit`
- **Typography & Color Styles**:
  - Extract typography styles into CSS variables or Tailwind font presets (`text-sm font-medium leading-relaxed tracking-wide`).
  - Extract shadows, border radii, and opacity into semantic utility tokens.

## 3. Dark Mode & Theme Modes
- Define Figma Variable Collections with multiple Modes (`Light`, `Dark`, `High-Contrast`).
- Map modes to CSS Custom Properties under `[data-theme="dark"]` or `.dark` classes:
  ```css
  :root {
    --bg-surface: var(--color-gray-50);
    --text-primary: var(--color-gray-900);
  }
  .dark {
    --bg-surface: var(--color-gray-900);
    --text-primary: var(--color-gray-50);
  }
  ```

## 4. Token Pipeline & Automation
- Export tokens using standard Design Tokens Format (W3C Community Group standard JSON format).
- Use Style Dictionary or custom transformers to build artifacts:
  - `tailwind.config.js` theme extensions
  - SCSS/CSS variables stylesheet
  - TypeScript token constants / types for typed UI component props
- Component mapping: maintain strict parity between Figma component variant props (e.g., `variant: "primary" | "secondary"`, `size: "sm" | "md" | "lg"`, `disabled: boolean`) and code component inputs/props.
