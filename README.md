# PM Skills Library

13 custom Claude Code skills for Product Managers, AI Builders, and UX Specialists.

Skills auto-trigger in Claude Code when your prompt matches the trigger phrases below. Install once — they're always available.

---

## Installation

```bash
cp -r skills/ ~/.claude/skills/user/
```

Or clone directly:

```bash
git clone https://github.com/Tvk-sd/pm-skills ~/.claude/skills/user
```

---

## Skill Index

### Discovery & Strategy

| Skill | What it does | Trigger phrases |
|---|---|---|
| [`pm-thinking-partner`](pm-thinking-partner/SKILL.md) | Senior PM mode — task routing, framework selection, strategic reasoning | "think through this with me" · "PM review" · "help me frame this" |
| [`concept-brief`](concept-brief/SKILL.md) | Voice-forward direction brief — what it is, what it believes, who it's for. Saves CONCEPT.md locally. | "concept brief" · "vision brief" · "direction brief" · "write up the vision" |
| [`prd-writing`](prd-writing/SKILL.md) | Two-phase PRD: challenge assumptions first, then structured draft | "write a PRD" · "feature spec" · "product requirements" |
| [`competitor-analysis`](competitor-analysis/SKILL.md) | Steelman-first competitive analysis — argues for competition before self-assessment | "competitor analysis" · "competitive landscape" |

### Research & Discovery

| Skill | What it does | Trigger phrases |
|---|---|---|
| [`user-research-synthesis`](user-research-synthesis/SKILL.md) | Quote extraction → patterns → contradiction mapping → insight hierarchy | "synthesise my research" · "analyse these interviews" |
| [`jtbd-analysis`](jtbd-analysis/SKILL.md) | Jobs, desired outcomes, four forces, overserved/underserved outcomes | "JTBD" · "jobs to be done" · "what job are we hired for" |
| [`ost-evidence`](ost-evidence/SKILL.md) | OST from real discovery data. Teresa Torres framework. Every branch traces to evidence. | "OST from my research" · "opportunity tree from data" |
| [`ost-exploration`](ost-exploration/SKILL.md) | OST without data. Assumption mode + generative extensions. Occam's razor. `[SPECULATIVE]` labeled. | "explore opportunity space" · "OST without data" · "generative OST" |

### Brand & Design

| Skill | What it does | Trigger phrases |
|---|---|---|
| [`art-direction`](art-direction/SKILL.md) | Define visual identity, brief designers/agencies, art direct campaigns, critique visual work | "art direction" · "visual identity" · "brand design" · "moodboard" · "creative brief" |

### Ideation & Before Building

| Skill | What it does | Trigger phrases |
|---|---|---|
| [`grill-me`](grill-me/SKILL.md) | Claude interrogates the user — walks the decision tree, challenges weak points, resolves each branch before moving on. Pre-flight stress test before writing a spec or brief. | "grill me" · "stress test this" · "poke holes in my plan" · "challenge this design" · "interview me on this" |
| [`brainstorming-ideation`](brainstorming-ideation/SKILL.md) | Diverge-then-converge with problem reframing and challenge round | "brainstorm ideas" · "help me ideate" · "generate solutions" |
| [`ai-decision-framework`](ai-decision-framework/SKILL.md) | 6-step: problem → AI suitability score → approach → feasibility → metrics → ethics → decision brief | "should we use AI for" · "evaluate this AI idea" · "AI or not" |
| [`ai-feature-scoping`](ai-feature-scoping/SKILL.md) | Scope a known AI feature: accuracy thresholds, failure modes, build/buy, measurement | "scope this AI feature" · "AI feature feasibility" |

### Planning & Delivery

| Skill | What it does | Trigger phrases |
|---|---|---|
| [`user-story-creation`](user-story-creation/SKILL.md) | Edge cases first, then Given/When/Then ACs. QA-ready stories with complexity estimates. | "write user stories" · "acceptance criteria" · "break into tickets" |
| [`stakeholder-communication`](stakeholder-communication/SKILL.md) | BLUF format, audience-adapted, explicitly doesn't bury bad news | "stakeholder update" · "exec comms" · "status update" |
| [`workflow-documentation`](workflow-documentation/SKILL.md) | Documents real-world messiness, not idealised flows. Surfaces implicit knowledge + exception handling. | "document this process" · "write a workflow" · "runbook" |

---

## How skills work

Skills are markdown files that Claude Code loads as context when trigger phrases are detected. Each `SKILL.md` contains:
- A frontmatter block with `name`, `description`, and trigger phrases
- A structured process the skill follows
- Constraints that enforce quality and prevent common failure modes

---

## Mandatory section for all skills

Every `SKILL.md` — new or updated — **must** include the following section at the end:

```markdown
---

## Progressive Updates

Whenever the user explicitly states not to do something (e.g. "don't ask for X", "stop doing Y", "never include Z"), automatically edit the role and behaviour description at the top of this SKILL.md to reflect that constraint permanently. This ensures the skill adapts to user preferences over time without requiring repeated instructions.
```

This is non-negotiable. When creating a new skill, always append this block as the final section.

Skills work best in Claude Code (`claude` CLI). They also work in Claude.ai Projects when uploaded as project knowledge files.

---

## How skills chain together

**Discovery → Prioritisation**
`user-research-synthesis` → `jtbd-analysis` → `ost-evidence`

**Feature development**
`ai-decision-framework` → `grill-me` → `concept-brief` → `prd-writing` → `user-story-creation`

**Competitive strategy**
`competitor-analysis` → `brainstorming-ideation` → `stakeholder-communication`

**Exploration (no data)**
`ost-exploration` → `brainstorming-ideation` → `ai-feature-scoping`
