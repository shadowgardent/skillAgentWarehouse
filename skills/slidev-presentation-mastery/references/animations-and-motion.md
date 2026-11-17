# Animations, Motion, Annotations & Transitions Reference

คู่มือฉบับสมบูรณ์สำหรับการสร้างอนิเมชันบนสไลด์ด้วยระบบ Clicks (`v-click`, `v-clicks`, `v-after`, `<v-switch>`), การขีดเขียนเน้นข้อความด้วย **Rough Notation (`v-mark`)**, ฟิสิกส์อนิเมชันด้วย **`@vueuse/motion` (`v-motion`)**, การลากวาง `v-drag`, และ **Slide Transitions / View Transitions**

---

## 1. ระบบ Click Animations (`v-click`, `v-clicks`, `v-after`)

หัวใจสำคัญของการเล่าเรื่องบนเวทีคือ **Progressive Disclosure** (ค่อยๆ เปิดเผยข้อมูลทีละสเต็ปตามการกด Spacebar หรือคลิกเมาส์)

### 1.1 `v-click` (ใช้เป็น Directive หรือ Component)
ซ่อนองค์ประกอบไว้จนกว่าผู้พูดจะกดคลิก:

```markdown
<!-- 1. ใช้เป็น Vue Directive บนแท็ก HTML หรือ Component -->
<div v-click class="p-4 bg-slate-800 rounded-xl">
  ปรากฏเมื่อคลิกครั้งที่ 1
</div>

<!-- 2. ใช้เป็น Component ครอบข้อความ Markdown -->
<v-click>

- ข้อความหรือตาราง Markdown ข้างในนี้จะปรากฏเมื่อคลิกครั้งที่ 2

</v-click>
```

### 1.2 `v-clicks` (ให้รายการย่อยปรากฏทีละข้ออัตโนมัติ)
ใช้ครอบ Bullet List (`<ul>`, `<ol>`) หรือกลุ่มของ Elements เพื่อให้ลูกทุกตัวปรากฏทีละคลิก:

```markdown
<!-- ค่าเริ่มต้น: ลูกชั้นแรกปรากฏทีละข้อ -->
<v-clicks>

- Step 1: Parse OHLCV binary stream
- Step 2: Detect Swing Highs & Swing Lows
- Step 3: Identify Order Blocks & Fair Value Gaps

</v-clicks>

<!-- กำหนด depth="2" เพื่อให้รายการย่อยระดับที่ 2 ค่อยๆ ปรากฏทีละข้อด้วย -->
<v-clicks depth="2">

- Phase 1: Data Ingestion
  - Connect WebSocket feed
  - Normalize tick timestamps
- Phase 2: Signal Execution
  - Validate risk limits
  - Dispatch order

</v-clicks>

<!-- กำหนด every="2" ให้แสดงผลทีละ 2 องค์ประกอบต่อ 1 คลิก (เหมาะกับตารางหรือ Grid Cards) -->
<v-clicks every="2">
  <div>Card 1A</div>
  <div>Card 1B (มาพร้อม 1A)</div>
  <div>Card 2A</div>
  <div>Card 2B (มาพร้อม 2A)</div>
</v-clicks>
```

### 1.3 `v-after` (ปรากฏพร้อมกับ `v-click` ก่อนหน้าโดยไม่ต้องคลิกเพิ่ม)
```markdown
<div v-click class="text-2xl font-bold">Main Feature Launched</div>
<div v-after class="text-sm text-emerald-400">↳ Sub-caption appears at the exact same click!</div>
```

### 1.4 การซ่อนองค์ประกอบเมื่อคลิก (`v-click.hide` และช่วงคลิก `[start, end]`)
- `v-click.hide`: แสดงอยู่ตั้งแต่แรก แล้ว **ซ่อนหายไป** เมื่อกดคลิก
- `v-click="[2, 4]"`: แสดงขึ้นมาในคลิกที่ `2` และ **ซ่อนหายไป** เมื่อถึงคลิกที่ `4` (แสดงเฉพาะช่วงคลิก `2` และ `3`)

```markdown
<!-- แสดงตั้งแต่ต้น และหายไปในคลิกที่ 2 -->
<div v-click.hide="2">Initial Legacy Diagram</div>

<!-- ปรากฏในคลิกที่ 2 และหายไปเมื่อถึงคลิกที่ 5 -->
<div v-click="[2, 5]">Temporary Callout Box (Visible during clicks 2, 3, 4)</div>
```

### 1.5 การกำหนดลำดับคลิกแบบ Absolute & Relative (`+1`, `-1`)
- **Absolute Index**: `v-click="3"` (ปรากฏที่คลิกหมายเลข 3 เสมอ)
- **Relative Index**: `v-click="'+1'"` (หลังตัวก่อนหน้า 1 คลิก, ค่าเริ่มต้น) หรือ `v-click="'-1'"` (ย้อนกลับไปทำงานพร้อมคลิกก่อนหน้า)

---

## 2. `<v-switch>` (สลับเนื้อหาในตำแหน่งเดิมตามสเต็ปคลิก)

เมื่อต้องการเปลี่ยนรูปภาพ ไดอะแกรม หรือข้อความในตำแหน่งเดิมไปเรื่อยๆ ตามการคลิกโดยไม่ให้ซ้อนทับกัน ให้ใช้ `<v-switch>`:

```markdown
<v-switch>
  <template #0>
    <div class="p-6 bg-slate-800 rounded-xl">State 0: Initial Idle State (ก่อนคลิก)</div>
  </template>
  <template #1>
    <div class="p-6 bg-blue-900/50 rounded-xl">State 1: Scanning Market Liquidity...</div>
  </template>
  <template #2-4>
    <div class="p-6 bg-amber-900/50 rounded-xl">State 2 to 4: Order Block Mitigated! (แสดงตั้งแตคลิก 2 ถึง 3)</div>
  </template>
  <template #4>
    <div class="p-6 bg-emerald-900/50 rounded-xl">State 4+: Take Profit Target Hit 🎯</div>
  </template>
</v-switch>
```
- Tip: เติมพร็อพ `unmount` (`<v-switch unmount>`) หากต้องการให้ Component ถูกลบออกจาก DOM จริงๆ แทนการใช้ `display: none`

---

## 3. Rough Notation (`v-mark` วาดเส้นเน้นข้อความเหมือนเขียนด้วยมือ)

Slidev ผสานรวมไลบรารี **Rough Notation** เข้ากับระบบ `v-click` ผ่าน Directive **`v-mark`** เพื่อขีดเส้นใต้ วงกลม หรือป้ายสีไฮไลต์ข้อความด้วยลายเส้นวาดมือสุดเท่!

### 3.1 รูปแบบเส้น (`type`) ที่รองรับ:
- `v-mark.underline` (ค่าเริ่มต้น: ขีดเส้นใต้)
- `v-mark.circle` (วงกลมล้อมรอบ)
- `v-mark.highlight` (ป้ายสีปากกาเน้นข้อความ)
- `v-mark.box` (ตีกรอบสี่เหลี่ยมล้อมรอบ)
- `v-mark.strike-through` (ขีดฆ่าทับข้อความ)
- `v-mark.crossed-off` (กากบาท X ทับข้อความ)
- `v-mark.bracket` (ใส่วงเล็บปีกกาด้านข้าง)

### 3.2 ตัวอย่างการใช้งาน `v-mark`
```markdown
ระบบใหม่ช่วยลด Latency ลงเหลือเพียง <span v-mark.circle.orange="1">0.42 ms</span>
และตัดปัญหา <span v-mark.crossed-off.red="2">Memory Leak</span> ออกไปอย่างถาวร
ส่งผลให้ได้ <span v-mark="{ at: 3, color: '#10b981', type: 'underline', strokeWidth: 3 }">Zero Downtime Deployment</span>
```
- หากไม่ระบุตัวเลขคลิก (`v-mark.underline.sky`) มันจะนับเป็น `v-click` ถัดไปให้อัตโนมัติ!
- หากระบุ `v-mark.circle.amber="0"` เส้นจะถูกวาดทันทีที่เปิดสไลด์โดยไม่ต้องรอคลิก

---

## 4. Physics-based Motion (`v-motion` จาก `@vueuse/motion`)

สร้างอนิเมชันการเคลื่อนที่ หมุน ซูม หรือเด้งแบบ Spring Physics ที่ผูกกับจังหวะการเปิดสไลด์ (`:enter`) และจังหวะคลิก (`:click-1`, `:click-2-4`):

```markdown
<div
  v-motion
  :initial="{ x: -100, opacity: 0, scale: 0.9 }"
  :enter="{ x: 0, opacity: 1, scale: 1, transition: { type: 'spring', stiffness: 250, damping: 20 } }"
  :click-1="{ y: -20, scale: 1.08, borderColor: '#38bdf8' }"
  :click-2-4="{ x: 120, rotate: 3 }"
  :leave="{ opacity: 0, scale: 0.5 }"
  class="p-6 rounded-2xl bg-slate-800/80 border-2 border-slate-600 w-80"
>
  <h3 class="font-bold text-lg text-sky-400">Execution Core</h3>
  <p class="text-xs opacity-75">Physics-driven interactive card</p>
</div>
```

---

## 5. Custom CSS Click Transitions (`.slidev-vclick-target`)

โดยค่าเริ่มต้น `v-click` จะใช้อนิเมชัน Fade-in เบาๆ หากคุณต้องการให้ `v-click` เลื่อนขึ้นมาจากด้านล่าง (`translateY`) หรือซูมเข้า (`scale`) สามารถปรับแต่งผ่าน CSS Classes ของ Slidev ได้ง่ายมาก:

```html
<style>
/* กำหนดสถานะเริ่มต้นและการเคลื่อนไหวของทุก v-click ในสไลด์นี้ */
.slidev-vclick-target {
  transition: all 400ms cubic-bezier(0.16, 1, 0.3, 1);
}

/* สถานะตอนที่ยังไม่ถูกคลิก (ซ่อนอยู่) */
.slidev-vclick-hidden {
  opacity: 0;
  transform: translateY(24px) scale(0.96);
  pointer-events: none;
}

/* สถานะขององค์ประกอบที่ถูกคลิกผ่านไปแล้ว (เมื่อมีการคลิกสเต็ปถัดไป) */
.slidev-vclick-prior {
  opacity: 0.45;
  transform: scale(0.98);
}
</style>
```
- การแต่ง `.slidev-vclick-prior` ให้มี `opacity: 0.45` เป็นเทคนิคระดับ Keynote ที่ช่วยให้ผู้ฟังโฟกัสเฉพาะบรรทัดที่เพิ่งคลิกขึ้นมาใหม่ ขณะที่บรรทัดเก่าจะหรี่แสงลงอัตโนมัติ!

---

## 6. การลากวางองค์ประกอบแบบอิสระ (`v-drag` & `<v-drag-arrow>`)

หากต้องการจัดวางกล่องข้อความ รูปภาพ หรือลูกศรแบบอิสระด้วยเมาส์ (เหมือนใน Keynote/Figma) โดยให้ค่าพิกัดบันทึกกลับลงไฟล์ `slides.md` อัตโนมัติ:

```markdown
---
dragPos:
  callout: 580,140,260,110,-4
---

<!-- ดับเบิลคลิกที่องค์ประกอบนี้บนหน้าสไลด์เพื่อลากย้าย หมุน หรือย่อขยายขนาด! -->
<div v-drag="'callout'" class="p-4 rounded-xl bg-amber-500/20 border border-amber-400 text-amber-200 shadow-xl">
  ⚡ Hot Path: 99% of CPU cycles spent here!
</div>

<!-- ลากเส้นลูกศรชี้จุดสำคัญบนหน้าจอ -->
<v-drag-arrow two-way color="#38bdf8" width="3" />
```

---

## 7. Slide Transitions & View Transitions API (การเปลี่ยนหน้าสไลด์)

กำหนดใน Headmatter (ทั้ง Deck) หรือ Per-slide Frontmatter:

### 7.1 Built-in Slide Transitions
| ค่า `transition` | เอฟเฟกต์การเปลี่ยนหน้า |
| :--- | :--- |
| `slide-left` | เลื่อนสไลด์ไปทางซ้าย (และเมื่อกดย้อนกลับจะเลื่อนไปทางขวา `slide-right` อัตโนมัติ) |
| `slide-right` | เลื่อนสไลด์ไปทางขวา |
| `slide-up` | เลื่อนสไลด์ขึ้นด้านบน (เมื่อกดย้อนกลับจะเลื่อนลง `slide-down` อัตโนมัติ) |
| `slide-down` | เลื่อนสไลด์ลงด้านล่าง |
| `fade` | Crossfade จางสลับกันอย่างนุ่มนวล |
| `fade-out` | หน้าเก่าจางหายไปจนมืดก่อน แล้วหน้าใหม่ค่อยจางปรากฏขึ้นมา |
| `view-transition` | ใช้ **Browser Native View Transitions API** ทำ Morphing ข้ามหน้าสไลด์! |
| `slide-left \| fade` | ใช้ `slide-left` เมื่อเดินหน้า และใช้ `fade` เมื่อกดย้อนกลับ |

### 7.2 การทำ Magic Morph ข้ามสไลด์ด้วย `view-transition`
เมื่อตั้งค่า `transition: view-transition` และกำหนด CSS `view-transition-name` (หรือคลาส inline style) ให้ตรงกันระหว่าง 2 สไลด์ เบราว์เซอร์จะทำอนิเมชันย้ายตำแหน่งและเปลี่ยนขนาดของ Element นั้นข้ามสไลด์ให้อัตโนมัติเหมือน Keynote Magic Move:

```markdown
---
transition: view-transition
---

# Slide 1
<div class="w-32 h-32 rounded-2xl bg-sky-500" style="view-transition-name: hero-card"></div>

---
transition: view-transition
---

# Slide 2 (กล่องสีฟ้าจะบินและขยายขนาดจาก Slide 1 มาที่ตำแหน่งใหม่นี้!)
<div class="w-96 h-48 rounded-3xl bg-indigo-600 ml-auto" style="view-transition-name: hero-card"></div>
```
