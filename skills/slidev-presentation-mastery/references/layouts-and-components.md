# Slidev Built-in Layouts & Components Reference

คู่มือฉบับสมบูรณ์สำหรับการใช้งาน **Built-in Layouts** ทั้งหมดของ Slidev พร้อม **Slot Sugar (`::right::`)** และ **Built-in Vue Components** ที่พร้อมใช้งานทันทีใน Markdown โดยไม่ต้อง Import

---

## 1. ตารางสรุป Built-in Layouts ทั้งหมด

คุณสามารถกำหนด Layout ให้แต่ละสไลด์ผ่าน Frontmatter `layout: <name>` (หมายเหตุ: สไลด์แผ่นแรกสุดจะมีค่าเริ่มต้นเป็น `cover` ส่วนแผ่นอื่นๆ จะมีค่าเริ่มต้นเป็น `default`):

| ชื่อ Layout | หน้าที่และการจัดวาง | Frontmatter Props & Slots ที่รองรับ |
| :--- | :--- | :--- |
| `cover` | หน้าปกสไลด์ จัดกึ่งกลางแนวตั้งพร้อมเน้นชื่อเรื่องหลัก | `background` |
| `default` | หน้ามาตรฐานสำหรับแสดงเนื้อหาทั่วไป | `class` |
| `center` | จัดเนื้อหาทั้งหมดให้อยู่กึ่งกลางทั้งแนวตั้งและแนวนอน | `class` |
| `two-cols` | แบ่งหน้าจอเป็น 2 คอลัมน์ซ้าย-ขวาเท่ากัน | Slot `::right::`, Prop `layoutClass` |
| `two-cols-header` | มีส่วนหัวเต็มความกว้างด้านบน และแบ่ง 2 คอลัมน์ซ้าย-ขวาด้านล่าง | Slots `::left::`, `::right::`, `::bottom::`, Prop `layoutClass` |
| `image` | แสดงรูปภาพเต็มหน้าจอสไลด์เป็นหลัก | `image` (required), `backgroundSize` (`cover`/`contain`) |
| `image-left` | แสดงรูปภาพฝั่งซ้ายครึ่งจอ และเนื้อหา Markdown อยู่ฝั่งขวา | `image` (required), `backgroundSize`, `class` |
| `image-right` | แสดงเนื้อหา Markdown อยู่ฝั่งซ้าย และรูปภาพอยู่ฝั่งขวาครึ่งจอ | `image` (required), `backgroundSize`, `class` |
| `iframe` | ฝังหน้าเว็บ (`<iframe>`) เต็มหน้าจอสไลด์ | `url` (required), `scale` |
| `iframe-left` | ฝังหน้าเว็บฝั่งซ้ายครึ่งจอ และเนื้อหาอยู่ฝั่งขวา | `url` (required), `scale`, `class` |
| `iframe-right` | เนื้อหาอยู่ฝั่งซ้าย และฝังหน้าเว็บอยู่ฝั่งขวาครึ่งจอ | `url` (required), `scale`, `class` |
| `quote` | แสดงคำคม (Blockquote) ขนาดใหญ่ที่โดดเด่นและสง่างาม | `class` |
| `fact` | เน้นตัวเลขสถิติ (KPI / Metric) หรือข้อเท็จจริงให้เด่นสะดุดตา | `class` |
| `statement` | แสดงประโยคสำคัญ (Key Takeaway / Manifesto) กลางหน้าจอ | `class` |
| `section` | หน้าคั่นบท (Section Divider) สำหรับเริ่มต้นหัวข้อใหม่ | `class` |
| `intro` | หน้าแนะนำตัวผู้พูด (Speaker Bio) หรือเกริ่นนำเข้าสู่เนื้อหา | `class` |
| `end` | หน้าปิดท้ายการนำเสนอ (Thank You / Q&A) | `class` |
| `full` | ใช้พื้นที่เต็มหน้าจอ 100% โดยไม่มี Padding รอบข้าง | `class` |
| `none` | ไม่ใส่สไตล์หรือ Layout Wrapper ใดๆ เลย (Raw Unstyled Canvas) | - |

---

## 2. ตัวอย่างการใช้งาน Layouts & Slot Sugar เชิงลึก

### 2.1 `two-cols` (สองคอลัมน์ซ้าย-ขวา)
ใช้ `::right::` เพื่อสลับเนื้อหาจากคอลัมน์ซ้ายไปยังคอลัมน์ขวา และใช้ `layoutClass` เพื่อปรับระยะห่าง (`gap-*`) หรือการจัดแนว (`items-center`):

```markdown
---
layout: two-cols
layoutClass: gap-10 items-center
---

# Legacy Architecture
ฝั่งซ้ายเขียนเนื้อหาตามปกติ (Default Slot)

- Monolithic Express Server
- Blocking Synchronous I/O
- Single DB Connection Pool

::right::

# Event-Driven Engine
เนื้อหาหลัง `::right::` จะถูกส่งเข้าคอลัมน์ขวา

- Worker Threads + SharedArrayBuffer
- Zero-copy Binary Serialization
- Read/Write Split Replicas
```

### 2.2 `two-cols-header` (หัวข้อด้านบน + สองคอลัมน์ด้านล่าง)
เหมาะมากสำหรับสไลด์ที่มีหัวข้อหลักและเกริ่นนำด้านบน แล้วเปรียบเทียบ 2 ฝั่งด้านล่าง:

```markdown
---
layout: two-cols-header
layoutClass: gap-8
---

# Architecture Comparison
เปรียบเทียบโครงสร้างการประมวลผลระหว่าง v1 และ v2

::left::

### v1: Row-by-Row Object Iteration
```ts
for (const candle of candles) {
  processRow(candle)
}
```

::right::

### v2: Float64Array Vectorized Loop
```ts
for (let i = 0; i < len; i++) {
  out[i] = close[i] - open[i]
}
```

::bottom::

<div class="mt-4 text-center text-sm opacity-75">
  Benchmark run on 1,000,000 M1 candles (Node.js v22)
</div>
```

### 2.3 `image-right` และ `image-left`
```markdown
---
layout: image-right
image: https://cover.sli.dev
backgroundSize: cover
class: flex flex-col justify-center
---

# Visual Storytelling
เนื้อหาฝั่งซ้ายจะถูกจัดให้อยู่กึ่งกลางแนวตั้งด้วย `class: flex flex-col justify-center` ขณะที่ฝั่งขวาแสดงรูปภาพเต็มครึ่งจอ
```

### 2.4 `iframe-right` (โชว์เว็บจริงหรือ Dashboard คู่กับเนื้อหา)
```markdown
---
layout: iframe-right
url: https://sli.dev
scale: 0.75
---

# Live Interactive Demo
ฝั่งขวาคือหน้าเว็บจริงที่ผู้พูดสามารถคลิกและโต้ตอบได้สดๆ ระหว่างนำเสนอ โดยย่อขนาดด้วย `scale: 0.75` เพื่อให้พอดีกับพื้นที่ครึ่งจอ
```

### 2.5 `fact` และ `statement`
```markdown
---
layout: fact
---

# 99.998%
System Uptime Across 14 Global Regions in 2026

---
layout: statement
---

# "Simplicity is prerequisite for reliability."
— Edsger W. Dijkstra
```

---

## 3. Built-in Components (คอมโพเนนต์ในตัวของ Slidev)

Slidev มี Vue 3 Components ในตัวที่สามารถเรียกใช้งานใน `slides.md` ได้ทันที:

### 3.1 `<Toc>` (Table of Contents อัตโนมัติ)
สร้างสารบัญสไลด์โดยดึงจากหัวข้อ (`#`) ของสไลด์ทั้งหมดใน Deck:

```markdown
# Agenda / สารบัญ

<Toc
  columns="2"
  maxDepth="2"
  minDepth="1"
  mode="all"
/>
```
- **Props สำคัญ**:
  - `columns`: จำนวนคอลัมน์ในการแสดงสารบัญ (เช่น `"1"`, `"2"`, `"3"`)
  - `minDepth` / `maxDepth`: ระดับ Heading ที่ต้องการแสดง (ค่าเริ่มต้น `1` ถึง `4`)
  - `mode`:
    - `'all'` (ค่าเริ่มต้น): แสดงทุกหัวข้อ
    - `'onlyCurrentTree'`: แสดงเฉพาะกิ่งของหัวข้อที่กำลังเปิดอยู่
    - `'onlySiblings'`: แสดงเฉพาะหัวข้อระดับเดียวกันและลูกของหัวข้อปัจจุบัน

### 3.2 `<Link>` (ลิงก์กระโดดข้ามไปยังสไลด์หน้าอื่น)
ใช้สร้างลิงก์ภายในสไลด์เพื่อกระโดดไปยังหมายเลขหน้า (`to="5"`) หรือชื่อสไลด์โดยไม่ทำให้หน้าเว็บ Reload:

```markdown
ดูรายละเอียดเพิ่มเติมได้ที่ <Link to="12" title="Deep Dive Appendix" />
หรือคลิก <Link to="next">หน้าถัดไป</Link>
```

### 3.3 `<SlidevVideo>` (เล่นวิดีโอในสไลด์อย่างสมบูรณ์แบบ)
รองรับการตั้งค่า Autoplay เมื่อเปิดมาถึงสไลด์หน้านั้น และรีเซ็ตเวลาอัตโนมัติ:

```markdown
<SlidevVideo
  autoplay
  controls
  autoreset="slide"
   poster="/images/video-poster.jpg"
  class="rounded-xl shadow-2xl border border-white/10 w-full max-h-96"
>
  <source src="/videos/demo-walkthrough.mp4" type="video/mp4" />
  <p>Your browser does not support HTML5 video.</p>
</SlidevVideo>
```
- **Props สำคัญ**:
  - `autoplay`: `'once'` (เล่นอัตโนมัติครั้งเดียว) หรือ `true` (เล่นอัตโนมัติทุกครั้งที่เปิดเข้าสไลด์นี้)
  - `autoreset`: `'slide'` (ย้อนกลับไปวินาทีที่ 0 เมื่อออกจากสไลด์) หรือ `'click'`
  - ` controls`: แสดงแถบควบคุมวิดีโอ
  - `printPoster` / `timestamp`: กำหนดวินาทีของเฟรมวิดีโอที่ต้องการแสดงเวลาสั่ง Export เป็น PDF/PNG!

### 3.4 `<Youtube>` และ `<Tweet>`
ฝังวิดีโอ YouTube หรือโพสต์ X (Twitter) ด้วย ID โดยตรง:

```markdown
<!-- ฝังวิดีโอ YouTube -->
<Youtube id="dQw4w9WgXcQ" width="600" height="340" />

<!-- ฝัง Tweet ด้วยเลขสถานะ -->
<Tweet id="1390115482657726468" scale="0.8" />
```

### 3.5 `<LightOrDark>` (แยกแสดงเนื้อหาตามโหมดสว่าง/มืด)
มีประโยชน์มากเมื่อต้องเปลี่ยนรูปโลโก้หรือไดอะแกรมตามโหมดสีของสไลด์:

```markdown
<LightOrDark>
  <template #dark>
    <img src="/images/architecture-dark.svg" alt="Dark Mode Diagram" class="h-80 mx-auto" />
  </template>
  <template #light>
    <img src="/images/architecture-light.svg" alt="Light Mode Diagram" class="h-80 mx-auto" />
  </template>
</LightOrDark>
```

### 3.6 `<RenderWhen>` (เลือกเรนเดอร์เฉพาะบริบทที่กำหนด)
ควบคุมให้แสดงเนื้อหาเฉพาะในโหมดที่ต้องการ เช่น แสดงคำใบ้เฉพาะในหน้าจอ Presenter หรือซ่อนองค์ประกอบหนักๆ เวลา Export PDF:

```markdown
<RenderWhen context="presenter">
  <div class="p-3 bg-amber-500/20 border border-amber-500 text-amber-300 rounded-lg text-sm">
    💡 อย่าลืมสาธิตการกดปุ่ม Run ใน Monaco Editor!
  </div>
</RenderWhen>

<RenderWhen :context="['slide', 'presenter']">
  <!-- แสดงเฉพาะตอนนำเสนอสด ไม่แสดงในหน้า Overview -->
  <LiveWebSocketTicker />
</RenderWhen>
```
- ค่า `context` ที่รองรับ: `'main'`, `'slide'`, `'presenter'`, `'previewNext'`, `'overview'`, `'print'`, `'visible'`

### 3.7 `<Transform>` และ `<AutoFitText>`
- **`<Transform :scale="0.75" origin="top left">`**: ย่อหรือขยายขนาดของ Component หรือตารางขนาดใหญ่ให้พอดีกับพื้นที่สไลด์โดยไม่ทำให้ Layout เพี้ยน
- **`<AutoFitText :max="120" :min="24" modelValue="Dynamic Headline" />`**: ปรับขนาดฟอนต์อัตโนมัติเพื่อให้ข้อความพอดีกับความกว้างของคอนเทนเนอร์

### 3.8 `<PoweredBySlidev>`
แสดงโลโก้และลิงก์ "Powered by Slidev" เหมาะสำหรับใส่ในหน้าสุดท้าย (`layout: end`):
```markdown
<PoweredBySlidev class="mt-10 opacity-70" />
```

---

## 4. Iconify Icons ในสไลด์ (`<carbon-...>`, `<mdi-...>`, `<logos-...>`)

Slidev ผสานรวม **`unplugin-icons`** และ **Iconify** มาให้ในตัว คุณสามารถเรียกใช้ไอคอนจากชุดใดก็ได้ใน Iconify เป็นแท็กคอมโพเนนต์ `<collection-icon-name />` หรือคลาส UnoCSS `i-collection-icon-name`:

```markdown
- <carbon-cloud-monitoring class="text-sky-400 inline mr-2 text-xl" /> Real-time Telemetry
- <mdi-shield-check class="text-emerald-400 inline mr-2 text-xl" /> Zero-Trust Security
- <logos-typescript-icon class="inline mr-2 text-xl" /> TypeScript 5.x Strict Mode
- <div class="i-ph-lightning-duotone text-3xl text-amber-400 inline-block" /> Ultra-Low Latency
```

> **💡 ทิปการติดตั้งชุดไอคอนเพิ่มเติม**:
> ค่าเริ่มต้น Slidev มักมี `@iconify-json/carbon` หรือ `@iconify-json/mdi` มาให้ หากต้องการใช้ชุดไอคอนอื่น เช่น `logos` หรือ `ph` (Phosphor Icons) สามารถติดตั้งเพิ่มได้ด้วย `npm i -D @iconify-json/logos @iconify-json/ph`
