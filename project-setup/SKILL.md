---
version: 1.1.0
name: project-setup
description: Scaffolds a new Claude Code project: CLAUDE.md, HANDOFF.md, git init. Triggers: "set up a new project", "initialize a project", "new project setup", "project setup", "/project-setup", "start a new project", "scaffold this project", "create a new project".
---

## Purpose

This skill scaffolds a Claude Code project so that every future session starts with full context — no re-explaining the stack, no re-deriving conventions, no "what is this project again?" overhead.

It is workflow-agnostic. It does not prescribe how you build, plan, or ship. It creates a context surface that any workflow — manual, conductor-based, or otherwise — can read and write to.

**What it produces:**

1. `CLAUDE.md` — project identity: what it is, how to run it, stack, structure, conventions
2. `HANDOFF.md` — living state: what is built, what is pending, where each type of change belongs
3. `git init` + first commit — version control from session one
4. `/docs` folder (optional) — a conventional home for output artifacts (specs, briefs, decisions)

**What it does not do:**

- It does not prescribe a build workflow
- It does not create spec or vision documents (those come from separate tools or manual work)
- It does not configure CI, deployment, or any external service

---

## Phase 0 — Safety check

Before asking anything, inspect the current working directory:

- If `CLAUDE.md` exists: say — "CLAUDE.md already exists here. Do you want to **overwrite**, **merge** (I'll read it and add any missing sections), or **cancel**?" Wait for the answer before proceeding.
- If `HANDOFF.md` exists: note it. Write HANDOFF.md fresh only if overwrite is chosen.
- If `.git/` exists: skip `git init` in Phase 4 — only add and commit the new files.

---

## Phase 1 — Gather context

Ask all 7 questions as a single numbered list. Do NOT ask one at a time. Wait for all answers before proceeding.

> To scaffold your project, I need a few details:
>
> 1. **Project name + slug** — human name and a URL-safe slug, e.g. "Endless Tower" → `endless-tower`
> 2. **What is this project?** — 1–2 sentences: what it does, and for whom
> 3. **Project type** — web app / API / script / data pipeline / AI tool / other
> 4. **Tech stack** — language, frameworks, database — or "not decided yet"
> 5. **How to run it locally** — the exact command to start it — or "TBD"
> 6. **Any decisions already locked in?** — constraints or choices Claude should not second-guess — or "none yet"
> 7. **Create a `/docs` folder for output artifacts?** — yes / no

If the user provides partial answers, fill missing fields with `TBD` placeholders. Do not block on incomplete information.

---

## Phase 2 — Generate CLAUDE.md

Populate the template below from Phase 1 answers. Show the complete draft to the user before writing.

```markdown
# [Project Name] — Claude Code Project Instructions

## What this project is
[1–2 sentence description from answer 2]

## How to run
```bash
[Run command from answer 5, or: TBD — update this when the project is set up]
```

## Stack
[Tech choices from answer 4, or: TBD — fill in after the first build session]

## Project structure
[Leave this section blank for now — fill in once folders are established]

## Key decisions
[Constraints or choices from answer 6 that Claude should not override.
Or: None locked in yet — add decisions here as they are made.]

## Conventions
[Leave this section blank for now — add coding patterns and preferences as they emerge]

## Output artifacts
[If /docs was requested:]
Project output documents live in `/docs/`. Add files here as they are created
(e.g. concept briefs, specs, design decisions, research notes).

[If /docs was not requested:]
Project output documents live in the project root alongside this file.
```

After showing the draft, ask: **"Does this look right? Any corrections before I write it?"**

Wait for confirmation. Apply any corrections. Then write `CLAUDE.md`.

---

## Phase 3 — Generate HANDOFF.md

Write the skeleton below immediately after `CLAUDE.md` is confirmed. No separate confirmation needed.

```markdown
# [Project Name] — Handoff
Last updated: [today's date] · Status: Planning

---

## What's built
Nothing yet — project just initialised.

---

## Stack
[From Phase 1 answer 4, or: TBD]

---

## Pending
| Priority | Task | Notes |
|---|---|---|
| — | — | Add tasks here as work begins |

---

## Output documents
| File | Type | Status |
|---|---|---|
| `HANDOFF.md` | Session state | ✅ Active |

Add rows here as documents are created (specs, briefs, decision records, etc.)

---

## Where each change belongs
| Type of change | File to update |
|---|---|
| Project vision, direction, or positioning | Concept / direction document |
| Feature scope, spec, or acceptance criteria | Specification document |
| Task completed, milestone reached, session ended | `HANDOFF.md` |
| Coding pattern established or changed | `CLAUDE.md` → Conventions section |
| Decision locked in | `CLAUDE.md` → Key decisions section |
| Bug fix, gotcha, environment quirk, or architectural insight | `.claude/memory.md` — write immediately, not at session end |

---

## How to resume
Open Claude Code in the project directory and read both `CLAUDE.md` and this file.
No re-explanation of the project needed.
```

---

## Phase 4 — Git init + first commit

Show the proposed commit message and ask: **"Ready to commit? I'll run git init and make the first commit."**

Wait for confirmation. Then run:

```bash
git init
git add CLAUDE.md HANDOFF.md
git commit -m "chore: initial project setup — CLAUDE.md + HANDOFF.md"
```

If `/docs` was requested:

```bash
mkdir docs
touch docs/.gitkeep
git add docs/.gitkeep
git commit -m "chore: add /docs folder for output artifacts"
```

If `.git/` already existed, skip `git init`. Add and commit only the files just created.

---

## Phase 5 — Summary

Output a brief completion block:

```
## Project scaffolded

Created:
- CLAUDE.md       project identity, stack, and conventions
- HANDOFF.md      living state document
- .git/           version control initialised
- /docs/          output artifacts folder  [if applicable]

To resume any future session: open Claude Code in this directory.
CLAUDE.md + HANDOFF.md load automatically — no re-explanation needed.
```

Do not suggest a specific next step or tool. The user decides what comes next.

---

## Constraints

- Never write `CLAUDE.md` without showing the full draft and receiving explicit confirmation.
- Never overwrite or merge existing files without the user's choice in Phase 0.
- Ask all Phase 1 questions as a single list — never one at a time.
- One git confirmation only — do not ask again per commit.
- Keep the generated `CLAUDE.md` concise. It is a context loader, not documentation.
- Do not reference any specific downstream tool, workflow, or skill in the generated files.

---

## Workflow integrations

This skill is designed to be workflow-agnostic. The files it creates are plain markdown — readable and writable by any tool or process.

### Conductor

If the project uses the `/conductor` PM OS workflow, Conductor reads and writes these files as its state surface:

- **`CLAUDE.md`** — Conductor reads the project context on every session resume. It writes a `<!-- CONDUCTOR STATE -->` block (phase, outcome, design contract, open risks) inside HTML comment markers. This block coexists with the sections created here — Conductor manages it automatically and it does not need to be edited manually.
- **`HANDOFF.md`** — Conductor appends staging tables (Now / Next / Later), session summaries, and phase completion notes. These additions are additive — they do not replace the skeleton created here.

Projects initialised with `project-setup` are immediately compatible with Conductor. Projects initialised by Conductor (which may create partial versions of these files) can be brought into the full `project-setup` structure using the **merge** option in Phase 0.

Resume a Conductor session with: `/conductor from:[phase]`

---


## Gotchas

<!-- Add a line here each time this skill produces the wrong output or misses something important. Fill from real failures, not hypotheses. -->

---

## Progressive Updates

Whenever the user explicitly states not to do something (e.g. "don't ask for X", "stop doing Y", "never include Z"), automatically edit the role and behaviour description at the top of this SKILL.md to reflect that constraint permanently. This ensures the skill adapts to user preferences over time without requiring repeated instructions.
