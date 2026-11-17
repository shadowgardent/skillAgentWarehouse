---
theme: default
title: Quantitative Trading Platform — Executive Pitch Deck
author: Park (Slidev Specialist)
info: |
  ## Executive Product Pitch Deck
  Modern Bento Grid & Glassmorphism Template for Slidev
aspectRatio: 16/9
canvasWidth: 980
colorSchema: dark
transition: slide-left
mdc: true
fonts:
  sans: 'Inter, Noto Sans Thai'
  mono: 'JetBrains Mono'
---

<div class="h-full flex flex-col justify-center">
  <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-mono uppercase tracking-widest bg-emerald-500/10 text-emerald-400 border border-emerald-500/30 w-fit mb-6">
    <span>SERIES A PRODUCT VISION • 2026</span>
  </div>

  <h1 class="text-6xl font-extrabold tracking-tight leading-tight bg-gradient-to-r from-white via-slate-200 to-emerald-400 bg-clip-text text-transparent mb-4">
    Institutional-Grade Backtesting for Everyone.
  </h1>

  <p class="text-xl text-slate-300 max-w-2xl mb-10">
    Validate Smart Money Concepts strategies across 10 years of tick data in under a second — zero infrastructure required.
  </p>

  <div class="flex items-center gap-4">
    <div class="px-5 py-2.5 rounded-xl bg-emerald-500 text-slate-950 font-bold text-sm shadow-lg shadow-emerald-500/20">
      Launch Live Demo →
    </div>
    <div class="px-5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm text-slate-300">
      Q4 2026 Product Roadmap
    </div>
  </div>
</div>

<!--
สวัสดีคณะกรรมการและนักลงทุนทุกท่านครับ วันนี้เราขอแนะนำแพลตฟอร์ม Backtest ระดับสถาบันการเงินที่นักเทรดทุกคนสามารถประมวลผลข้อมูล Tick Data ย้อนหลัง 10 ปีได้ภายในเสี้ยววินาทีครับ
-->

---

# Key Performance Highlights (Bento Grid Layout)
ผลลัพธ์จากการใช้งานจริงของกลุ่มผู้ใช้งาน Early Adopters ในไตรมาสที่ผ่านมา

<div class="grid grid-cols-12 gap-4 mt-6">
  <!-- Main Hero Stat Card -->
  <div v-click class="col-span-5 p-6 rounded-2xl bg-gradient-to-br from-emerald-500/15 via-slate-900/80 to-slate-900 border border-emerald-500/30 flex flex-col justify-between">
    <div>
      <span class="text-xs font-mono uppercase tracking-wider text-emerald-400">Execution Speed</span>
      <h3 class="text-lg font-semibold text-slate-200 mt-1">Sub-Second Strategy Validation</h3>
    </div>
    <div class="my-6">
      <div class="text-6xl font-extrabold text-white tracking-tight">0.32<span class="text-2xl text-emerald-400 ml-1">sec</span></div>
      <div class="text-xs text-slate-400 mt-2">Average runtime for 5-year M1 OHLCV dataset</div>
    </div>
    <div class="text-xs font-mono text-emerald-300 bg-emerald-500/10 px-3 py-1.5 rounded-lg w-fit">
      ▲ 140x faster than legacy Python engines
    </div>
  </div>

  <!-- Right Column 2x2 Bento Grid -->
  <div class="col-span-7 grid grid-cols-2 gap-4">
    <div v-click class="p-5 rounded-2xl bg-white/5 border border-white/10 backdrop-blur">
      <div class="text-xs font-mono uppercase text-sky-400">Active Strategies</div>
      <div class="text-4xl font-bold text-white my-2">48,200+</div>
      <p class="text-xs text-slate-400">Automated SMC & Price Action models deployed</p>
    </div>

    <div v-click class="p-5 rounded-2xl bg-white/5 border border-white/10 backdrop-blur">
      <div class="text-xs font-mono uppercase text-amber-400">Cloud Cost Reduction</div>
      <div class="text-4xl font-bold text-white my-2">-78%</div>
      <p class="text-xs text-slate-400">Memory footprint reduced via binary ring buffers</p>
    </div>

    <div v-click class="col-span-2 p-5 rounded-2xl bg-gradient-to-r from-sky-500/10 to-indigo-500/10 border border-sky-500/25 flex items-center justify-between">
      <div>
        <div class="text-xs font-mono uppercase text-sky-400 mb-1">Enterprise SLA</div>
        <div class="text-lg font-bold text-white">99.99% Uptime & Deterministic Replay</div>
        <p class="text-xs text-slate-300 mt-1">Bit-for-bit reproducible backtest results across all cloud workers</p>
      </div>
      <div class="text-4xl font-extrabold text-sky-400 font-mono">100%</div>
    </div>
  </div>
</div>

---
layout: two-cols
layoutClass: gap-10 items-center
---

# Why Traders Switch to Us
เราแก้จุดเจ็บปวดสำคัญที่สุด 3 ข้อของนักพัฒนาอัลกอริทึมเทรด

<div class="space-y-4 mt-6">
  <div v-click class="p-4 rounded-xl bg-white/5 border-l-4 border-emerald-400">
    <div class="font-bold text-white">1. Zero Look-Ahead Bias Guarantee</div>
    <div class="text-xs text-slate-300 mt-1">ระบบจำลองการเกิดแท่งเทียนแบบ Point-in-Time ป้องกันการเห็นอนาคต 100%</div>
  </div>

  <div v-click class="p-4 rounded-xl bg-white/5 border-l-4 border-sky-400">
    <div class="font-bold text-white">2. Visual Order Block & FVG Inspector</div>
    <div class="text-xs text-slate-300 mt-1">ตรวจสอบทุกจุดเข้าออกพร้อมเส้น Swing High/Low และ Liquidity Sweep บนกราฟทันที</div>
  </div>

  <div v-click class="p-4 rounded-xl bg-white/5 border-l-4 border-purple-400">
    <div class="font-bold text-white">3. One-Click Live Bot Deployment</div>
    <div class="text-xs text-slate-300 mt-1">เปลี่ยนจากโค้ด Backtest ที่ผ่านเกณฑ์แล้ว ไปเป็น Live Webhook Execution ทันที</div>
  </div>
</div>

::right::

<div v-click class="p-6 rounded-2xl bg-slate-900 border border-slate-700/80 shadow-2xl">
  <div class="text-xs font-mono uppercase tracking-wider text-slate-400 mb-4">Competitive Benchmark</div>
  <table class="w-full text-left text-xs">
    <thead>
      <tr class="border-b border-slate-700 text-slate-400">
        <th class="pb-2">Feature</th>
        <th class="pb-2">Legacy Tools</th>
        <th class="pb-2 text-emerald-400">Our Platform</th>
      </tr>
    </thead>
    <tbody class="divide-y divide-slate-800">
      <tr>
        <td class="py-2.5 font-medium">1M Candle Speed</td>
        <td class="py-2.5 text-slate-400">35 - 60 sec</td>
        <td class="py-2.5 text-emerald-400 font-bold">0.32 sec</td>
      </tr>
      <tr>
        <td class="py-2.5 font-medium">Native SMC Primitives</td>
        <td class="py-2.5 text-slate-400">Manual Coding</td>
        <td class="py-2.5 text-emerald-400 font-bold">Built-in Engine</td>
      </tr>
      <tr>
        <td class="py-2.5 font-medium">Tick-Level Spread Sim</td>
        <td class="py-2.5 text-slate-400">Limited</td>
        <td class="py-2.5 text-emerald-400 font-bold">Full L2 Orderbook</td>
      </tr>
      <tr>
        <td class="py-2.5 font-medium">Portfolio Monte Carlo</td>
        <td class="py-2.5 text-slate-400">Add-on Paid</td>
        <td class="py-2.5 text-emerald-400 font-bold">Included (10k runs)</td>
      </tr>
    </tbody>
  </table>
</div>

---
layout: center
class: text-center
---

<div class="badge-pill px-3 py-1 rounded-full text-xs font-mono bg-emerald-500/15 text-emerald-400 border border-emerald-500/30 mx-auto mb-4 w-fit">
  READY FOR SCALE
</div>

# Let's Build the Future of Quantitative Trading
เปิดรับพันธมิตรเชิงกลยุทธ์และการทดสอบระบบระดับ Enterprise

<div class="mt-8 flex justify-center gap-4">
  <div class="px-6 py-3 rounded-xl bg-emerald-500 text-slate-950 font-bold text-sm">
    Schedule Architecture Review
  </div>
  <div class="px-6 py-3 rounded-xl bg-white/5 border border-white/15 text-sm">
    contact@quant-platform.dev
  </div>
</div>
