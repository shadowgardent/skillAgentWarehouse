# Slidev Markdown Syntax & Frontmatter Reference

คู่มือฉบับสมบูรณ์สำหรับการเขียนสไลด์ด้วย Markdown Syntax, กฎการใช้ตัวคั่นสไลด์ (`---`), ตัวเลือกทั้งหมดของ **Headmatter** (ตั้งค่าทั้ง Deck) และ **Per-slide Frontmatter** (ตั้งค่ารายสไลด์), Presenter Notes, การแยกไฟล์สไลด์ (`src:`), และ Scoped CSS

---

## 1. Slide Separators (`---`) และโครงสร้างไฟล์ `slides.md`

ใน Slidev เครื่องหมายขีดสามตัว `---` ที่เว้นบรรทัดว่างด้านบนและด้านล่าง ทำหน้าที่เป็น **ตัวคั่นสไลด์ (Slide Separator)** และเป็นจุดเริ่มต้นของบล็อก **Frontmatter** ได้พร้อมกัน:

```markdown
---
theme: seriph
title: Deck Title (This first block is the Headmatter)
---

# Slide 1: Cover Slide
เนื้อหาของสไลด์แผ่นที่ 1 (ไม่มี Frontmatter เฉพาะตัว ใช้ค่าเริ่มต้นจาก Headmatter)

---
layout: two-cols
class: px-8
---

# Slide 2: Two Columns Slide
เนื้อหาฝั่งซ้าย (บล็อก `---` ด้านบนคือ Frontmatter ของสไลด์แผ่นที่ 2)

::right::

เนื้อหาฝั่งขวา

---

# Slide 3: Standard Slide
สไลด์แผ่นที่ 3 คั่นด้วย `---` เดี่ยวๆ โดยไม่มี Frontmatter เฉพาะหน้า
```

> **⚠️ ข้อควรระวังเรื่อง `---` กับ Markdown Horizontal Rule**:
> เนื่องจาก `---` ถูกใช้เป็นตัวคั่นสไลด์ หากคุณต้องการขีดเส้นคั่นแนวนอน (`<hr>`) ภายในสไลด์เดียวกัน ให้ใช้ `* * *` หรือ `___` หรือแท็ก `<hr class="my-4 opacity-30" />` แทนการใช้ `---`

---

## 2. Headmatter Options (ตั้งค่าระดับ Global ทั้ง Deck)

**Headmatter** คือบล็อก YAML แรกสุดที่อยู่บรรทัดบนสุดของไฟล์ `slides.md` ใช้กำหนดค่าเริ่มต้นให้กับทั้งงานนำเสนอ:

```yaml
---
# 1. ธีมและส่วนเสริม
theme: seriph                      # ชื่อธีม (เช่น 'default', 'seriph', 'apple-basic', หรือ path โฟลเดอร์ธีม)
addons:                            # รายชื่อ Slidev Addons ที่ต้องการใช้งาน
  - slidev-addon-qrcode

# 2. ข้อมูลเมตาของสไลด์
title: High-Frequency Backtest Architecture  # ชื่อเรื่องหลัก (ใช้เป็นชื่อแท็บเบราว์เซอร์)
titleTemplate: '%s - Tech Talk 2026'         # รูปแบบชื่อแท็บ (%s จะถูกแทนที่ด้วย title ของแต่ละสไลด์)
author: Park (Slidev Specialist)             # ชื่อผู้จัดทำ
info: |                                      # คำอธิบายสไลด์ (แสดงในหน้า Overview และลิงก์ดาวน์โหลด)
  ## Architecture Deep Dive
  Built with Slidev, Vue 3, and UnoCSS.
keywords: slidev, architecture, trading, typescript

# 3. การแสดงผล ขนาดหน้าจอ และโหมดสี
aspectRatio: 16/9                  # อัตราส่วนหน้าจอ ('16/9', '4/3', '16/10', '1:1')
canvasWidth: 980                   # ความกว้างอ้างอิงของ Canvas (หน่วยเป็น px, ค่าเริ่มต้นคือ 980)
colorSchema: dark                  # โหมดสี ('auto' | 'light' | 'dark')
favicon: 'https://sli.dev/favicon.png'

# 4. การเรนเดอร์โค้ดและฟีเจอร์เสริม
highlighter: shiki                 # ตัวทำ Syntax Highlighting (ปัจจุบันใช้ Shiki เป็นหลัก)
lineNumbers: false                 # แสดงเลขบรรทัดในบล็อกโค้ดทั้งหมดหรือไม่ ('true' | 'false')
twoslash: true                     # เปิดใช้งาน TwoSlash (`true` | `false` | `'build'`)
monaco: true                       # เปิดใช้งาน Monaco Editor (`true` | `false` | `'dev'` | `'build'`)
mdc: true                          # เปิดใช้งาน Markdown Component Syntax (MDC) เช่น `[text]{.text-red-500}`
contextMenu: true                  # เปิด/ปิดเมนูคลิกขวาของ Slidev

# 5. ฟอนต์ (Google Fonts หรือ Local Fonts)
fonts:
  sans: 'Inter, Noto Sans Thai'    # ฟอนต์หลัก (เนื้อหาทั่วไป)
  serif: 'Playfair Display'        # ฟอนต์มีหัว
  mono: 'JetBrains Mono'           # ฟอนต์สำหรับบล็อกโค้ด
  weights: '300,400,500,600,700'   # น้ำหนักฟอนต์ที่ต้องการโหลด
  italic: true                     # โหลดฟอนต์ตัวเอียงด้วยหรือไม่
  provider: google                 # แหล่งโหลดฟอนต์ ('google' | 'none')

# 6. การเปลี่ยนหน้าสไลด์เริ่มต้น (Default Slide Transition)
transition: slide-left             # เช่น 'slide-left', 'slide-up', 'fade', 'view-transition'

# 7. การวาดเขียน อัดวิดีโอ และ Presenter Mode
drawings:
  enabled: true                    # เปิดใช้งานปากกาวาดบนสไลด์ (`true` | `false` | `'dev'`)
  persist: false                   # บันทึกรอยวาดลงโฟลเดอร์ `.slidev/drawings` หรือไม่
  presenterOnly: false             # ให้วาดได้เฉพาะหน้าจอ Presenter หรือไม่
  syncAll: true                    # ซิงค์รอยวาดไปยังทุกหน้าจอหรือไม่
record: dev                        # เปิดใช้งานการอัดวิดีโอ (`true` | `false` | `'dev'`)
presenter: true                    # เปิดใช้งาน Presenter Mode (`true` | `false` | `'dev'`)

# 8. การส่งออกไฟล์ (Export & Download)
download: false                    # แสดงปุ่มดาวน์โหลด PDF ในโหมด SPA (`true` | `false` | URL ของไฟล์ PDF)
exportFilename: architecture-deck  # ชื่อไฟล์เริ่มต้นเวลาสั่ง `slidev export`
export:
  format: pdf
  timeout: 30000
  dark: false
  withClicks: false
  withToc: false
---
```

---

## 3. Per-Slide Frontmatter Options (ตั้งค่าเฉพาะสไลด์แต่ละหน้า)

ในแต่ละสไลด์ คุณสามารถกำหนด Frontmatter เพื่อควบคุม Layout, พื้นหลัง, Transition และจำนวนคลิกเฉพาะหน้านั้นๆ ได้:

```yaml
---
# 1. โครงสร้างและการจัดวาง
layout: two-cols                   # ชื่อ Layout ของสไลด์ใบนี้ (เช่น 'cover', 'center', 'two-cols', 'fact')
class: 'text-white px-10'          # คลาส UnoCSS/CSS ที่ใส่ให้กับคอนเทนเนอร์เนื้อหาของสไลด์
layoutClass: 'gap-12 items-center' # คลาสที่ส่งไปยัง Layout Wrapper (รองรับในบาง Layout เช่น two-cols)

# 2. พื้นหลังและรูปภาพ (สำหรับทุก Layout หรือ image layouts)
background: /images/hero-bg.jpg    # URL หรือ Path รูปพื้นหลัง หรือค่าสี CSS
backgroundSize: cover              # ขนาดรูปพื้นหลัง ('cover' | 'contain' | '100% 100%')
image: /images/diagram.png         # รูปภาพสำหรับ `layout: image`, `image-left`, `image-right`
url: https://sli.dev               # URL สำหรับ `layout: iframe`, `iframe-left`, `iframe-right`

# 3. อนิเมชันและจำนวนคลิก
transition: fade-out               # Override การเปลี่ยนหน้าเมื่อออกจากสไลด์ใบนี้ไปยังใบถัดไป
clicks: 5                          # บังคับกำหนดจำนวนคลิกทั้งหมดของสไลด์ใบนี้ (ปกติ Slidev คำนวณให้อัตโนมัติ)
clicksStart: 0                     # กำหนดค่าเริ่มต้นของ `$clicks` เมื่อเปิดเข้าสไลด์ใบนี้ (เช่น เริ่มที่คลิก 1)

# 4. การซูม การซ่อน และการโหลดล่วงหน้า
zoom: 0.9                          # ปรับสเกลเนื้อหาทั้งสไลด์ (เช่น `0.85` เมื่อเนื้อหาแน่น หรือ `1.2` เพื่อขยาย)
disabled: false                    #(หรือ `hide: true`) ซ่อนสไลด์ใบนี้ไม่ให้แสดงผลในการนำเสนอจริง
hideInToc: true                    # ซ่อนหัวข้อของสไลด์ใบนี้จาก `<Toc />` (Table of Contents)
preload: true                      # โหลด Component ในสไลด์นี้ล่วงหน้าก่อนเปิดถึงหรือไม่ (`true` | `false`)
level: 2                           # กำหนดระดับ Heading Level ของสไลด์สำหรับแสดงใน `<Toc />`
title: Custom Slide Title          # กำหนดชื่อสไลด์สำหรับแสดงใน `<Toc />` และ Overview

# 5. การดึงเนื้อหาจากไฟล์ภายนอก และตำแหน่งการลาก
src: ./pages/02-architecture.md    # นำเข้าเนื้อหาสไลด์จากไฟล์ Markdown ภายนอก
dragPos:                           # พิกัดของ `<v-drag>` ที่ถูกบันทึกอัตโนมัติ
  box1: 120,80,300,150,0
---
```

---

## 4. MDC (Markdown Component) Syntax (`mdc: true`)

เมื่อเปิด `mdc: true` ใน Headmatter คุณสามารถใส่คลาส CSS, สไตล์ หรือเรียกใช้ Component ด้วยไวยากรณ์สั้นกระชับโดยไม่ต้องเขียนแท็ก HTML ยาวๆ:

```markdown
---
mdc: true
---

# การใช้งาน [MDC Syntax]{.text-emerald-400 .font-bold}

คุณสามารถใส่สไตล์อินไลน์ได้ง่ายๆ เช่น [ข้อความเรืองแสง]{style="text-shadow: 0 0 12px #38bdf8"}
หรือใส่คลาสให้กับรูปภาพ ![Logo](/logo.png){.w-32 .rounded-xl .shadow-lg}

::div{.p-6 .rounded-2xl .bg-slate-800/60 .border .border-slate-700}
บล็อกคอนเทนเนอร์ที่สร้างด้วย MDC Block Syntax!
::
```

---

## 5. Presenter Notes & Click-Synced Markers (`<!-- ... -->`)

ความคิดเห็น HTML (`<!-- ... -->`) ที่วางไว้ **ท้ายสุดของแต่ละสไลด์** จะถูกแปลงเป็น **Speaker Notes** สำหรับแสดงในหน้าจอ **Presenter Mode** (`/presenter`) โดยรองรับการจัดรูปแบบด้วย Markdown และรองรับการซิงค์ไฮไลต์ตามการคลิก (`[click]`):

```markdown
# Database Sharding Strategy

<div v-click>1. Consistent Hashing Ring</div>
<div v-click>2. Read Replicas with Lag Monitoring</div>
<div v-click>3. Automated Failover via Raft Consensus</div>

<!--
เกริ่นนำเรื่องปัญหาคอขวดของ Single Primary DB ก่อนเริ่มคลิกแรก

[click] อธิบายการทำงานของ Consistent Hashing ว่าช่วยลดการย้ายข้อมูลเวลาเพิ่ม Node ได้อย่างไร

[click] ชี้ให้เห็นว่า Read Replicas ต้องระวังเรื่อง Replication Lag เสมอในระบบการเงิน

[click:3] สรุปด้วยการใช้ Raft Consensus เพื่อรับประกัน Zero Data Loss
-->
```
- เมื่อผู้พูดกดคลิกในสไลด์ หน้าจอ Presenter จะขยับ (Auto-scroll) และไฮไลต์ย่อหน้าใน Notes ที่ตรงกับ `[click]` ปัจจุบันให้อัตโนมัติ!

---

## 6. การแยกไฟล์สไลด์เป็นโมดูล (`src:` Importing Multiple Files)

สำหรับสไลด์ขนาดใหญ่ (เช่น 30–100 หน้า) หรือการทำงานร่วมกันหลายคน สามารถแยกสไลด์ออกเป็นไฟล์ย่อยในโฟลเดอร์ `pages/` แล้วดึงเข้ามารวมใน `slides.md` หลักด้วย `src:`:

```markdown
---
theme: seriph
title: Full Enterprise Architecture Deck
---

# Welcome to the Master Deck

---
src: ./pages/01-introduction.md
---

---
src: ./pages/02-backend-services.md
hide: false
---
```
- **สำคัญ**: ไฟล์ย่อยที่ถูกดึงด้วย `src:` สามารถมีได้หลายสไลด์ข้างใน (คั่นด้วย `---` ตามปกติ) และหากใน `slides.md` หลักมีการกำหนด Frontmatter เพิ่มเติมควบคู่กับ `src:` ค่าใน `slides.md` หลักจะมีความสำคัญสูงกว่า (Override) หน้าแรกของไฟล์ย่อยนั้น

---

## 7. Scoped CSS & Inline `<script setup>` ในสไลด์

คุณสามารถใส่แท็ก `<style>` และ `<script setup>` ลงในสไลด์หน้าใดหน้าหนึ่งได้โดยตรง:
- แท็ก `<style>` ในสไลด์จะถูกแปลงเป็น **Scoped CSS (`<style scoped>`) โดยอัตโนมัติ** มีผลเฉพาะสไลด์ใบนั้นใบเดียว ไม่กระทบหน้าอื่น!

```markdown
# Interactive Counter Slide

<div class="custom-card">
  <p class="text-lg">Current Velocity: <span class="font-mono text-2xl">{{ count }}</span> req/s</p>
  <button class="btn-boost" @click="count += 500">Boost Throughput ⚡</button>
</div>

<script setup lang="ts">
import { ref } from 'vue'
const count = ref(1500)
</script>

<style>
/* มีผลเฉพาะสไลด์หน้านี้เท่านั้น! */
h1 {
  background: linear-gradient(90deg, #38bdf8, #818cf8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
.custom-card {
  padding: 1.5rem;
  border-radius: 1rem;
  background: rgba(30, 41, 59, 0.7);
  border: 1px solid rgba(56, 189, 248, 0.3);
}
.btn-boost {
  margin-top: 1rem;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  background: #0284c7;
  color: white;
}
</style>
```
