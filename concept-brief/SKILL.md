---
version: 2.0.0
name: concept-brief
description: Writes a lean PROJECT-BRIEF.md — structured strategic framing: problem, goals, scope, users, milestones, success criteria. Saves to /context/PROJECT-BRIEF.md. Triggers: "concept brief", "write a concept brief", "project brief", "vision brief", "direction brief", "write up the vision", "what is this thing", "summarise the vision", "capture the concept".
---

**Before starting:** state your understanding of the project in one sentence and ask up to 2 clarifying questions if the input is ambiguous. Wait for confirmation before drafting.

This skill produces a single `PROJECT-BRIEF.md` — a lean, structured document that gives any reader (human or AI collaborator) a clear sense of what the project is, why it exists, what's in scope, and what success looks like. It is not a PRD. It is the document you read before the PRD.

---

## What this produces

A saved file: `/context/PROJECT-BRIEF.md` in the current working directory.

Content: ~300–400 words. Structured sections, short paragraphs. Confident voice. Something you could share with a designer, developer, stakeholder, or AI — and all of them would immediately understand what they're working on and why.

---

## Required inputs

Ask for (if not already provided):
- Project name
- What it does (1–2 sentences)
- Who it's for (be specific — not "users", a real person in a real situation)
- The central problem it solves
- Any known scope boundaries (what's definitely in, what's definitely out)
- Target timeline or major milestones (rough is fine)

---

## PROJECT-BRIEF.md Structure

Write the document in this order. Keep each section tight — 1–3 sentences or a short list. No filler. No jargon. Write like a founder who also writes well.

### 1. What it is
Plain English. What does this actually do? What category is it? What is it NOT?
One sharp paragraph. Max 3 sentences. State the category before you complicate it.

### 2. The problem
Not bullet points. A brief narrative about the pain. What happens in the world without this?
What does the user currently have to do, and why does it fall short? Make it vivid enough that the reader feels it.

### 3. What we believe
One clear positioning statement — the thesis that, if true, justifies everything. Specific enough to be mildly controversial.
Format as a blockquote.

### 4. Goals
3 bullets max. What success looks like — measurable where possible.

### 5. Scope
**In:** what's included in this project
**Out:** what's explicitly excluded (prevents scope creep — be specific)

### 6. Who it's for
One short paragraph. A real description of the person — not a persona card, not a demographic. What do they care about? What have they already tried? Why are they the right person to build this for?

### 7. Milestones
Simple phase list with target dates. Not a full roadmap — just the major checkpoints.

### 8. Success criteria
How we'll know it worked. 2–3 concrete, human outcomes — not KPIs.

### 9. Visual identity (conditional)
Only include if a `*-ARTDIRECTION.md` file exists in the current working directory.
If found: 3–5 sentences covering dominant color register, typographic personality, imagery tone, and overall feel. End with: `Full art direction: [filename]`
If not found: omit entirely.

---

## Voice rules

- Short sentences over long ones
- Confident, not hedged — avoid "might", "could", "potentially"
- No buzzwords: no "leverage", "synergy", "holistic", "seamlessly", "transformative"
- If a sentence doesn't earn its place, cut it
- Use present tense for what the product does; past tense is fine for the problem narrative

---

## File output

Save the brief as:

**Path:** `context/PROJECT-BRIEF.md`

If a `/context/` folder doesn't exist, create it first.

Confirm the save with: `Saved: context/PROJECT-BRIEF.md`

Then display the full document inline so the user can read and react without opening the file.

---

## Gotchas

<!-- Add a line here each time this skill produces the wrong output or misses something important. Fill from real failures, not hypotheses. -->

---

## Progressive Updates

Whenever the user explicitly states not to do something (e.g. "don't ask for X", "stop doing Y", "never include Z"), automatically edit the role and behaviour description at the top of this SKILL.md to reflect that constraint permanently. This ensures the skill adapts to user preferences over time without requiring repeated instructions.
