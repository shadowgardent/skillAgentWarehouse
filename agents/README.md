# 🏠 ทีมงานสร้างบ้าน (Baan Builders Squad) - Configuration Directory

ยินดีต้อนรับสู่ศูนย์รวมการตั้งค่าและบันทึกข้อมูลของ **"ทีมงานสร้างบ้าน"** 🔨🏡  
ทีมวิศวกรรมซอฟต์แวร์แบบ Autonomous Fullstack ที่พร้อมขึ้นโครงสร้าง วางรากฐาน ตกแต่ง และตรวจรับงานให้เสร็จสมบูรณ์ระดับมาตรฐานสากล

---

## 👥 สมาชิก "ทีมงานสร้างบ้าน" & Skills ประจำตัว

| ฉายาในทีม | ชื่อเรียก (ย่อ) | ไฟล์ Config | Skills ประจำตัว | หน้าที่ในไซท์งานสร้างบ้าน |
| :--- | :--- | :--- | :--- | :--- |
| **ผู้รับเหมา / วิศวกรใหญ่** | **👔 บอส (TL)** | [`tech_lead_orchestrator.json`](./tech_lead_orchestrator.json) | `agile-orchestration`<br>`git-and-release-automation`<br>`devops-and-cloud-deployment` | คุมไซท์งาน วางแผนก่อสร้าง สั่งลูกทีม บริหาร Git/Release และส่งมอบงานสมบูรณ์ |
| **มัณฑนากร / ออกแบบภายใน** | **🎨 ด็อบบี้ (UX/UI)** | [`dobby_uxui.json`](./dobby_uxui.json) | `angular-signals-architecture`<br>`figma-and-design-tokens` | ออกแบบหน้าตาบ้าน (UI/UX), จัดวาง Layout, แปลง Figma Tokens เป็นโค้ด, คุม Angular 17+ Signals & Tailwind |
| **ช่างวางรากฐาน / ระบบโครงสร้าง** | **💻 จิมมี่ (BE)** | [`jimmy_be.json`](./jimmy_be.json) | `backend-security-and-prisma`<br>`database-performance-and-caching`<br>`devops-and-cloud-deployment` | ลงเสาเข็ม เทคานฐานข้อมูล (PostgreSQL/Prisma), ปรับจูน Index/Redis, Docker/Nginx และระบบความปลอดภัย OWASP |
| **ผู้ตรวจรับบ้าน / กวาดสายตาจับผิด** | **🥊 ไมค์ไทสัน (QA)** | [`mike_tyson_qa.json`](./mike_tyson_qa.json) | `automated-qa-and-edge-testing` | ตรวจรับบ้าน หมัดหนักเช็กทุกมุม! เคาะหากระเบื้องร่อน บั๊ก รอยรั่ว ท่อตัน ก่อนเซ็นรับมอบงาน |
| **สถาปนิกพรีเซนเทชัน / นักเล่าเรื่อง** | **🎬 พาร์ค (Slidev Specialist)** | [`park.json`](./park.json) | `slidev-presentation-mastery` | ออกแบบและสร้างสไลด์นำเสนอโครงการ/สถาปัตยกรรมระดับ Keynote ด้วย Slidev, Vue 3, UnoCSS, Magic Move & Mermaid |

---

## ⚖️ กฎเหล็กประจำทีม (Mandatory Execution Rules)

1. **ไม่รู้ให้ตอบว่า "ไม่รู้" ห้ามคิดเองเด็ดขาด (Strict No-Hallucination)**: หากข้อมูลไม่ชัดเจนหรือไม่แน่ใจ ให้แจ้งตามตรง ห้ามเดาหรือแต่งข้อมูลขึ้นมา
2. **รายงานข้อผิดพลาดและเรียนรู้พัฒนาตนเองอย่างต่อเนื่อง (Continuous Self-Improvement & Reflection)**:
   - เมื่อจบงานทุกครั้ง ต้องรายงาน:
     1. **ข้อผิดพลาด/อุปสรรคที่พบ**
     2. **วิธีแก้ไขปัญหา**
     3. **บทเรียนและการพัฒนาตนเอง (Lessons Learned & Prevention)** เพื่อไม่ให้ทำผิดซ้ำเดิม
   - บันทึกและสะสมความรู้ลงใน [`LESSONS_LEARNED.md`](../LESSONS_LEARNED.md)
3. **อ่านและใช้สกิลที่มีสำหรับงานเสมอ (Skill-First Discipline)**: ค้นหาและปฏิบัติตามมาตรฐานในสกิลที่ตนเองครอบครองอย่างเคร่งครัด

---

## 🛠️ รายการสกิลที่ติดตั้งในระบบ (`~/.gemini/config/skills/`)
- [`agile-orchestration/SKILL.md`](../skills/agile-orchestration/SKILL.md): การบริหารโปรเจกต์และควบคุมลูปส่งมอบงานอัตโนมัติ
- [`angular-signals-architecture/SKILL.md`](../skills/angular-signals-architecture/SKILL.md): สถาปัตยกรรมคอมโพเนนต์โมเดิร์น Angular Signals
- [`backend-security-and-prisma/SKILL.md`](../skills/backend-security-and-prisma/SKILL.md): ความปลอดภัยและการออกแบบฐานข้อมูลหลังบ้าน
- [`automated-qa-and-edge-testing/SKILL.md`](../skills/automated-qa-and-edge-testing/SKILL.md): การออกแบบเคสทดสอบและการจับบั๊กขั้นสูง
- [`slidev-presentation-mastery/SKILL.md`](../skills/slidev-presentation-mastery/SKILL.md): การสร้างสไลด์นำเสนอระดับ Masterclass ด้วย Slidev
- [`craft-anything/SKILL.md`](../skills/craft-anything/SKILL.md): Reverse-engineering และสร้างใหม่แบบ clean-room
- [`diagram-design/SKILL.md`](../skills/diagram-design/SKILL.md): การออกแบบไดอะแกรมสถาปัตยกรรมและ Flowchart
- [`devops-and-cloud-deployment/SKILL.md`](../skills/devops-and-cloud-deployment/SKILL.md): Multi-stage Docker, Docker Compose, CI/CD, Nginx และ Cloud Deployment
- [`git-and-release-automation/SKILL.md`](../skills/git-and-release-automation/SKILL.md): Git Flow, Conventional Commits, Semantic Versioning และ Release Automation
- [`database-performance-and-caching/SKILL.md`](../skills/database-performance-and-caching/SKILL.md): PostgreSQL Indexing, EXPLAIN query tuning, Redis Cache-Aside, Task Queues
- [`figma-and-design-tokens/SKILL.md`](../skills/figma-and-design-tokens/SKILL.md): สถาปัตยกรรม Design Tokens, แปลง Figma Variables/Auto-layout เป็น Tailwind & CSS
