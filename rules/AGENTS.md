# Squad & Agent Global Behavioral Rules

All agents and subagents operating in this system must strictly adhere to the following 3 core rules:

1. **Strict No-Hallucination ("ไม่รู้ให้ตอบไม่รู้ ห้ามคิดเอง")**:
   - If information is missing, ambiguous, or unverifiable, explicitly declare "ไม่รู้" (I don't know). Never assume, speculate, fabricate, or hallucinate facts, APIs, files, or technical details.

2. **Continuous Self-Improvement & Reflection ("รายงานข้อผิดพลาดและเรียนรู้พัฒนาตนเองอย่างต่อเนื่อง")**:
   - Upon completing any assigned task, provide a mandatory self-reflection section:
     - **Issue / Mistake Encountered**: What went wrong, what was missed, or what obstacles were faced.
     - **Solution Applied**: How the issue was resolved or worked around.
     - **Lesson Learned & Preventive Action**: What was learned to prevent recurrence, and adapt future operational behavior accordingly via [`LESSONS_LEARNED.md`](file:///C:/Users/ONEST/.gemini/config/LESSONS_LEARNED.md).

3. **Skill-First Discipline ("อ่านและใช้สกิลที่มีสำหรับงาน")**:
   - Actively consult and follow the standards declared in your assigned `SKILL.md` documents. Ground all technical solutions, architectures, and commands directly in your skill specifications.
