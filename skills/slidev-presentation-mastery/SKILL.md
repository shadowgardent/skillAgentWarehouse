---
name: slidev-presentation-mastery
description: Masterclass guide and toolkit for building interactive, developer-friendly, Keynote-grade presentations with Slidev (Markdown, Vue 3, Vite, UnoCSS, Shiki Magic Move, Mermaid, KaTeX, @vueuse/motion, and PDF/PPTX/SPA exporting).
---

# 🎬 Slidev Presentation Mastery (`slidev-presentation-mastery`)

ยินดีต้อนรับสู่คัมภีร์ระดับ Masterclass สำหรับการออกแบบและพัฒนาสไลด์นำเสนอด้วย **Slidev** ([https://sli.dev](https://sli.dev)) — เครื่องมือสร้าง Presentation ยุคใหม่สำหรับนักพัฒนาและนักออกแบบที่ขับเคลื่อนด้วย **Markdown + Vue 3 + Vite + UnoCSS + Shiki + Mermaid + KaTeX**

---

## 🌟 1. Why Slidev? (ทำไมต้อง Slidev)

เครื่องมือแบบ WYSIWYG ดั้งเดิม (PowerPoint, Keynote, Google Slides) มักสร้างความหงุดหงิดเมื่อต้องจัดหน้าโค้ด ทำ Syntax Highlighting อัปเดตไดอะแกรม หรือทำ Version Control ด้วย Git **Slidev** จึงถูกสร้างขึ้นมาเพื่อแก้ปัญหานี้โดยเฉพาะด้วย 8 เสาหลัก:

1. **📝 Markdown-based**: เขียนเนื้อหาสไลด์ทั้งหมดในไฟล์ `.md` ไฟล์เดียว แยกเนื้อหาออกจากดีไซน์ โฟกัสที่ Storytelling และทำ Git Diff/PR ได้เต็มรูปแบบ
2. **🎨 Themable**: เปลี่ยนธีมระดับมืออาชีพผ่านแพ็กเกจ npm ได้ด้วยบรรทัดเดียว (`theme: seriph`, `theme: apple-basic`, ฯลฯ)
3. **💻 Developer Friendly**: รองรับ Shiki Syntax Highlighting, Line Highlighting, **Shiki Magic Move** (อนิเมชันแปลงร่างโค้ด), **TwoSlash** (แสดง Type Tooltip ของ TypeScript), และ **Monaco Editor** (แก้ไขและรันโค้ดสดบนสไลด์)
4. **⚡ Fast (Vite-powered)**: ขับเคลื่อนด้วย Vite ให้ Hot Module Replacement (HMR) ทันทีที่แก้ไฟล์ Markdown หรือ Vue Component
5. **🧩 Interactive & Expressive (Vue 3)**: แทรก Vue 3 Component, กราฟแบบ Interactive, หรือ UnoCSS/Tailwind Utility Classes ลงในสไลด์ได้โดยตรง
6. **🎥 Recording & Presenter Mode**: มีหน้าจอ Presenter View พร้อม Speaker Notes, ตัวจับเวลา, ปากกาวาดเขียนบนสไลด์ (Drauu) และระบบอัดวิดีโอพร้อมกล้อง Webcam ในตัว
7. **📦 Portable**: ส่งออกเป็นไฟล์ **PDF**, **PPTX**, **PNG** ด้วย Playwright หรือ Build เป็น **Static Single-Page Application (SPA)** โฮสต์ขึ้น GitHub Pages / Vercel / Netlify ได้ทันที
8. **🛠️ Hackable**: ทุกอย่างที่ทำได้บนเว็บแอปพลิเคชัน สามารถนำมาใส่ในสไลด์ได้ทั้งหมด ผ่าน `setup/`, Custom Layouts, และ Vite Plugins

---

## 🏆 2. Golden Rules of Keynote-Grade Slide Design (กฎเหล็กการออกแบบสไลด์ให้สวยระดับโลก)

1. **One Idea Per Slide (1 สไลด์ = 1 แก่นสำคัญ)**
   - ห้ามยัดข้อความเป็นกำแพง (Wall of Text) เด็ดขาด
   - จำกัด Bullet ไม่เกิน 3–5 ข้อต่อสไลด์ หรือใช้ **Bento Grid / Feature Cards** แทน Bullet ธรรมดา
2. **Visual Hierarchy & Contrast (ลำดับสายตาต้องชัดเจน)**
   - ใช้ Eyebrow Badge เล็กๆ ด้านบนหัวข้อ (เช่น `<span class="px-3 py-1 rounded-full text-xs font-mono bg-blue-500/10 text-blue-400 border border-blue-500/20">SYSTEM ARCHITECTURE</span>`)
   - หัวข้อหลัก (`<h1>`) ควรโดดเด่นและใช้ Gradient Text หรือสีที่มี Contrast สูง
   - ข้อมูลตัวเลขสำคัญ (Metrics / KPIs) ต้องใช้ตัวอักษรขนาดใหญ่ (`text-5xl font-bold`) พร้อมคำอธิบายสั้นๆ ด้านล่าง
3. **Progressive Disclosure (ค่อยๆ เปิดเผยเนื้อหาตามจังหวะการพูด)**
   - ใช้ `v-click`, `v-clicks`, `v-after`, และ `v-mark` เพื่อดึงสายตาผู้ฟังทีละจุดตามจังหวะการเล่าเรื่อง
   - สำหรับการอธิบายโค้ดยาวๆ ให้ใช้ Line Highlighting Step (`{1-3|5-8|all}`) หรือ `magic-move` เสมอ
4. **Code & Diagram Readability (โค้ดและไดอะแกรมต้องอ่านง่ายจากหลังห้อง)**
   - โค้ดในสไลด์ไม่ควรเกิน 15–20 บรรทัดต่อหน้า หากยาวกว่านั้นให้กำหนด `{maxHeight:'320px'}` หรือแบ่งเป็นสเต็ปด้วย `magic-move`
   - ไดอะแกรม Mermaid ควรกำหนด `{theme: 'neutral', scale: 0.85}` หรือปรับแต่งผ่าน `setup/mermaid.ts` ให้เข้ากับโทนสีสไลด์
5. **Consistent Visual Rhythm (สลับ Layout ไม่ให้ผู้ฟังเบื่อ)**
   - สลับจังหวะ Layout ระหว่าง `cover` -> `two-cols` -> `center` -> `image-right` -> `fact` -> `section` เพื่อรักษาความน่าสนใจตลอดการนำเสนอ

---

## 🔄 3. Standard Slidev Workflow (ขั้นตอนการทำงานมาตรฐาน)

### Step 1: วางโครงเรื่อง (Storyboarding)
แบ่งสไลด์ออกเป็นโครงสร้างการเล่าเรื่องที่ทรงพลัง:
- **Hook / Cover**: ชื่อเรื่องที่ดึงดูดใจ + ชื่อผู้พูด + บริบท
- **Problem / Context**: ปัญหาที่พบ หรือตัวเลข Impact (`layout: fact` หรือ `quote`)
- **Architecture / Solution**: แผนภาพระบบ (`mermaid`) + การเปรียบเทียบ (`layout: two-cols`)
- **Deep Dive / Code Demo**: เจาะลึกโค้ดด้วย Shiki Line Stepping หรือ `magic-move`
- **Results / Benchmarks**: ตารางเปรียบเทียบ หรือ Bento Grid แสดงผลลัพธ์
- **Summary / Q&A**: สรุปประเด็นสำคัญ (`layout: end` หรือ `center`)

### Step 2: โครงสร้างไฟล์ `slides.md` พื้นฐาน
```markdown
---
theme: seriph
title: Architecture Deep Dive
info: |
  ## Next-Gen Trading Engine Architecture
  Designed with Slidev
aspectRatio: 16/9
canvasWidth: 980
colorSchema: dark
transition: slide-left
mdc: true
lineNumbers: false
fonts:
  sans: Inter
  mono: JetBrains Mono
---

# Next-Gen Trading Engine
High-Frequency Smart Money Concepts Backtesting Architecture

<div class="pt-12">
  <span class="px-4 py-2 rounded-lg bg-white/10 backdrop-blur border border-white/20 text-sm">
    Press <kbd>Space</kbd> for next slide <carbon:arrow-right class="inline"/>
  </span>
</div>

<!--
สวัสดีครับทุกคน วันนี้เราจะมาเจาะลึกสถาปัตยกรรมระบบ Backtest ความเร็วสูงกันครับ
-->

---
layout: two-cols
layoutClass: gap-8
---

# Why Rethink the Engine?

<v-clicks>

- **Legacy Bottleneck**: Sequential candle loop took 45s per run
- **Memory Spikes**: Unbounded OHLCV cloning in Node.js workers
- **Zero Observability**: No real-time progress telemetry

</v-clicks>

::right::

<div v-click class="p-6 rounded-2xl bg-gradient-to-br from-emerald-500/10 to-cyan-500/10 border border-emerald-500/30">
  <div class="text-xs uppercase tracking-wider text-emerald-400 mb-2">New Throughput</div>
  <div class="text-6xl font-bold text-white mb-2">120x</div>
  <div class="text-sm opacity-75">Faster execution using vectorized typed arrays & worker pools</div>
</div>
```

---

## 💻 4. Essential CLI Commands

| คำสั่ง | คำอธิบาย |
| :--- | :--- |
| `npx @slidev/cli slides.md` หรือ `npm run dev` | รัน Dev Server พร้อม HMR และเปิดเบราว์เซอร์ (`http://localhost:3030`) |
| `npx slidev build` | Build สไลด์เป็น Static Single-Page App (SPA) ลงโฟลเดอร์ `dist/` |
| `npx slidev export` | ส่งออกสไลด์เป็นไฟล์ **PDF** (`slides-export.pdf`) ต้องมี `playwright-chromium` |
| `npx slidev export --format pptx` | ส่งออกสไลด์เป็นไฟล์ **PowerPoint (PPTX)** |
| `npx slidev export --format png` | ส่งออกสไลด์แต่ละหน้าเป็นรูปภาพ **PNG** |
| `npx slidev export --with-clicks` | ส่งออก PDF/PPTX โดยแยกทุกสเต็ปของ `v-click` ออกเป็นคนละหน้า |
| `npx slidev export --dark` | บังคับส่งออกในโหมด Dark Mode |
| `npx slidev format slides.md` | จัดระเบียบฟอร์แมตไฟล์ `slides.md` อัตโนมัติ |

---

## 📚 5. Deep-Dive Reference Library (`references/`)

ศึกษาคู่มือเจาะลึกแต่ละหมวดหมู่ได้ในโฟลเดอร์ `references/` ของสกิลนี้:

1. **[Why Slidev & Core Concepts](./references/why-and-core-concepts.md)**
   - ปรัชญา 8 ประการของ Slidev, สถาปัตยกรรมภายใน (Vite + Vue 3 + UnoCSS + Shiki), โครงสร้างโปรเจกต์มาตรฐาน, และ Global Context Variables (`$slidev`, `$nav`, `$clicks`, `$page`, `useSlideContext()`)
2. **[Syntax & Frontmatter Reference](./references/syntax-and-frontmatter.md)**
   - กฎการใช้ `---` คั่นสไลด์, ตารางตัวเลือก Headmatter และ Per-slide Frontmatter ทั้งหมด, MDC Syntax (`mdc: true`), Presenter Notes พร้อม `[click]` Markers, การแยกไฟล์สไลด์ (`src:`), และ Scoped CSS
3. **[Built-in Layouts & Components](./references/layouts-and-components.md)**
   - คู่มือ Built-in Layouts ครบทุกแบบ (`cover`, `center`, `two-cols`, `two-cols-header`, `image-left/right`, `iframe`, `quote`, `fact`, `statement`, `section`, `intro`, `end`, `full`, `none`), การใช้ Named Slots (`::right::`, `::left::`), และ Built-in Components (`<SlidevVideo>`, `<LightOrDark>`, `<RenderWhen>`, `<AutoFitText>`, `<Transform>`, `<Toc>`, `<Link>`, Iconify)
4. **[Code Blocks, Diagrams & LaTeX Math](./references/code-and-diagrams.md)**
   - Shiki Syntax Highlighting, Line Highlighting (`{1|2-4|all}`), **Shiki Magic Move** (` ````md magic-move `), **TwoSlash** TypeScript, **Monaco Editor** (`{monaco}`, `{monaco-run}`, `{monaco-diff}`), Code Groups, Snippet Imports (`<<< @/...`), **Mermaid Diagrams**, **PlantUML**, และ **KaTeX Math** (`$$...$$`)
5. **[Animations, Motion & Transitions](./references/animations-and-motion.md)**
   - การควบคุม `v-click`, `v-clicks`, `v-after`, `v-click.hide`, `<v-switch>`, ตำแหน่งคลิกแบบ Relative/Absolute, **Rough Notation (`v-mark`)**, **`@vueuse/motion` (`v-motion`)**, การลากวาง `v-drag`, และ Slide Transitions (`slide-left`, `fade`, `view-transition`)
6. **[Styling, Themes, Customizations & Exporting](./references/styling-themes-and-export.md)**
   - เทคนิคแต่งสไลด์ด้วย UnoCSS (Glassmorphism, Bento Grid, Gradients), การตั้งค่าฟอนต์ Google Fonts, การสร้าง Custom Layouts (`./layouts/`) และ Components (`./components/`), Global Layers (`global-top.vue`, `global-bottom.vue`), Addons, และการ Export ทุกฟอร์แมต + Deploy ขึ้น Cloud

---

## 🎨 6. Ready-to-Use Templates (`examples/`) & Automation Scripts (`scripts/`)

- **Templates (`examples/`)**:
  - [`examples/tech-architecture-deck.md`](./examples/tech-architecture-deck.md) — เทมเพลตสไลด์ System Architecture & Engineering Tech Talk แบบครบเครื่อง (Magic Move, Mermaid, TwoSlash, Monaco, LaTeX, Metrics)
  - [`examples/product-pitch-deck.md`](./examples/product-pitch-deck.md) — เทมเพลตสไลด์ Product Pitch / Executive Summary สไตล์โมเดิร์นพรีเมียม (Bento Grid, Glassmorphism, KPI Cards, Roadmap)
- **Helper Scripts (`scripts/`)**:
  - [`scripts/init-slidev.ps1`](./scripts/init-slidev.ps1) / [`scripts/init-slidev.sh`](./scripts/init-slidev.sh) — สคริปต์สร้างโปรเจกต์ Slidev พร้อมโครงสร้างโฟลเดอร์และแพ็กเกจครบชุด
  - [`scripts/export-slidev.ps1`](./scripts/export-slidev.ps1) / [`scripts/export-slidev.sh`](./scripts/export-slidev.sh) — สคริปต์ส่งออกสไลด์เป็น PDF, PPTX, PNG หรือ SPA พร้อมออปชันครบครัน
