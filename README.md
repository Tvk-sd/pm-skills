# PM Skills Library

25 custom Claude Code skills for Product Managers, AI Builders, and UX Specialists.

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

Organised by Design Thinking stages: Empathize → Define → Ideate → Design → Build → Ship → Operate.

### Empathize
*Understand users, context, and the problem space before forming an opinion.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Synthesise interviews / surveys | [`user-research-synthesis`](user-research-synthesis/SKILL.md) | "synthesise my research" · "analyse these interviews" |
| Jobs to be Done analysis | [`jtbd-analysis`](jtbd-analysis/SKILL.md) | "JTBD" · "jobs to be done" · "what job are we hired for" |
| Opportunity tree from real data | [`ost-evidence`](ost-evidence/SKILL.md) | "OST from my research" · "opportunity tree from data" |
| Explore opportunity space without data | [`ost-exploration`](ost-exploration/SKILL.md) | "explore opportunity space" · "OST without data" · "generative OST" |
| AI market / competitive research | [`ai-market-research`](ai-market-research/SKILL.md) | "research X market" · "market research plan" · "what do people think about" · "research this space" |

### Define
*Frame the problem, set strategy, align on scope and success.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Strategic PM reasoning | [`pm-thinking-partner`](pm-thinking-partner/SKILL.md) | "think through this with me" · "PM review" · "help me frame this" |
| Direction / vision brief | [`concept-brief`](concept-brief/SKILL.md) | "concept brief" · "vision brief" · "direction brief" · "write up the vision" |
| Spec or PRD | [`prd-writing`](prd-writing/SKILL.md) | "write a PRD" · "feature spec" · "product requirements" |
| Success metrics and KPIs | [`metrics-definition`](metrics-definition/SKILL.md) | "define success metrics" · "what should we measure" · "KPIs for this" · "north star metric" |
| Competitive landscape | [`competitor-analysis`](competitor-analysis/SKILL.md) | "competitor analysis" · "competitive landscape" |
| Feature prioritisation | [`feature-prioritisation`](feature-prioritisation/SKILL.md) | "prioritise this backlog" · "what should we build first" · "RICE scoring" · "MoSCoW" |
| Should we use AI for this? | [`ai-decision-framework`](ai-decision-framework/SKILL.md) | "should we use AI for" · "evaluate this AI idea" · "AI or not" |
| Scope a known AI feature | [`ai-feature-scoping`](ai-feature-scoping/SKILL.md) | "scope this AI feature" · "AI feature feasibility" |

### Ideate
*Generate, challenge, and stress-test ideas before committing.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Generate and stress-test ideas | [`brainstorming-ideation`](brainstorming-ideation/SKILL.md) | "brainstorm ideas" · "help me ideate" · "generate solutions" |
| Interrogate a plan or decision | [`grill-me`](grill-me/SKILL.md) | "grill me" · "stress test this" · "poke holes in my plan" · "challenge this design" · "interview me on this" |
| User stories with edge cases | [`user-story-creation`](user-story-creation/SKILL.md) | "write user stories" · "acceptance criteria" · "break into tickets" |

### Design
*Prototype, validate visually, and establish the design contract before code.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Figma Make prompt | [`figma-make-prompt-generator`](figma-make-prompt-generator/SKILL.md) | "generate a Figma Make prompt" · "turn this brief into a Figma prompt" · "Figma Make prompt" |
| Visual identity + art direction | [`art-direction`](art-direction/SKILL.md) | "art direction" · "visual identity" · "brand design" · "moodboard" · "creative brief" |
| Analyse visual references | [`design-analysis`](design-analysis/SKILL.md) | "analyse these references" · "derive a design system" · "design analysis" · "what's the design direction here" |
| UI/UX review and build | [`ui-ux-pro-max`](ui-ux-pro-max/SKILL.md) | "review my UI" · "build this UI" · "design this page" · "improve the UX" |

### Build
*Plan and implement — feature by feature.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Scaffold a new project | [`project-setup`](project-setup/SKILL.md) | "set up a new project" · "project setup" · "/project-setup" · "scaffold this project" |

### Ship
*Deliver, communicate, and grow.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Launch planning | [`launch-planning`](launch-planning/SKILL.md) | "plan this launch" · "launch plan" · "go-to-market" · "GTM plan" · "rollout plan" |
| Stakeholder update | [`stakeholder-communication`](stakeholder-communication/SKILL.md) | "stakeholder update" · "exec comms" · "status update" |
| Project handoff | [`project-handoff`](project-handoff/SKILL.md) | "update handoff" · "project state" · "handoff update" · "pause this project" |

### Operate
*Run, maintain, and improve what's been shipped.*

| Task | Skill | Trigger phrases |
|---|---|---|
| Document a real-world process | [`workflow-documentation`](workflow-documentation/SKILL.md) | "document this process" · "write a workflow" · "runbook" |

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

**Design → Prototype**
`art-direction` → `figma-make-prompt-generator`

**New project start**
`project-setup` → `concept-brief` → `prd-writing`
