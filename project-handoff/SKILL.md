---
version: 2.1.0
name: project-handoff
description: Creates or updates /context/PROJECT-TRACKER.md — living project state, session log, and Signal. Moves completed items to CHANGELOG. Triggers: "update tracker", "update handoff", "project state", "handoff update", "milestone reached", "onboard a collaborator", "pause this project", "update project status", "what's the state of this project", "document what's been built", "wrap up this session", "end of session".
---

Detect whether `/context/PROJECT-TRACKER.md` exists in the working directory:
- **Not found → Create mode:** build a skeleton from available context
- **Found → Update mode:** read the file, update only what changed, preserve everything else

Never overwrite sections that haven't changed. Never truncate existing content.

---

## PROJECT-TRACKER.md template

```markdown
# [Project name] — Tracker
**Status:** Planning | In Progress | Shipped | Paused
**Last updated:** YYYY-MM-DD

---

## How Claude should update this tracker

<!-- These rules apply during regular project sessions, not during the project-handoff skill execution itself. -->

Rules that apply in every session — follow automatically, no instruction needed:

1. **On task complete** → mark `[x]`, move item to `### Done` within the same stage block
2. **Ad-hoc tasks** → any work done mid-session that was not pre-tracked must be added to `### Done` immediately when shipped — do not leave untracked work out of the record
3. **Now is empty** → pull the top item from Next into Now
4. **Stage complete** → collapse the stage block to a one-line summary under `## Completed Stages`
5. **Done section > 8 items** → oldest items move to `CHANGELOG.md` (append entry, dated, 1–3 sentences)
6. **Update `Last updated`** at the end of every session that touches the tracker

---

## [Stage name] — Active

### Now
- [ ] [active focus]

### Next
*(empty — pull from Later when Now is clear)*

### Later
- [ ] [future work]

### Done
- [x] [completed item] — YYYY-MM-DD

---

## Completed Stages
*(archive collapsed stage summaries here)*

---

## Resume

**Prompt:** "Resume [Project Name]. Read CLAUDE.md and PROJECT-TRACKER.md."

[Key context: production URL, deploy command, Figma reference, environment notes, etc.]

---

## Session Log

<!-- Most recent entry at top. AI writes Situation, Action, Result and suggests Signal. Human owns the Signal. -->

### YYYY-MM-DD
**Situation:** [One sentence — state when this session started]
**Action:** [2–3 sentences — what happened, what was built or decided]
**Result:** [One sentence — what changed or was accomplished]
**Signal:** [One sentence — the single thing to carry into the next session. Human's call.]
```

---

## Create mode

When no PROJECT-TRACKER.md exists, build the skeleton using whatever context is available:

- **Project name** — from PROJECT-BRIEF.md, PRD.md, CLAUDE.md, or ask
- **Status** — `Planning` if no code exists, `In Progress` if build has started
- **How to resume** — derive from current project state; ask if unclear
- **Now / Next / Later** — derive from PRD open questions, brief, or ask for top priorities
- **Active tasks** — leave as placeholder if nothing is started yet

If `/context/` folder doesn't exist, create it first.

---

## Update mode

When PROJECT-TRACKER.md already exists:

1. Read the current file
2. Identify what has changed since last update (ask if unclear)
3. Update only the affected sections:
   - Status change → update the status field
   - Task completed → mark `[x]`, move to `### Done` within the same stage block
   - New work scoped → add to `### Now`, `### Next`, or `### Later` as appropriate
   - Now is empty → pull top item from Next
   - Stage complete → collapse to one-line summary under `## Completed Stages`
4. Update `Last updated` date
5. Update `Resume` section to reflect current state
6. Leave everything else untouched
7. If `### Done` has > 8 items → move oldest to CHANGELOG.md (dated, 1–3 sentence prose entry)

### Session wrap (end of session)

When triggered at end of session ("wrap up", "end of session", "pause this project"):

1. Draft three fields from the conversation:
   - **Situation:** one sentence — state when session started
   - **Action:** 2–3 sentences — what happened, what was built or decided
   - **Result:** one sentence — what changed or was accomplished
2. Draft a suggested Signal — one sentence written as a note to future-you: what would you wish you'd remembered? Could be a task, a warning, a method, a hunch — whatever has the most carry.
3. Present to the human:
   - The Situation / Action / Result draft
   - "Here's a suggested Signal: [draft]. Think of it as a note to future you — edit it or replace it, one sentence, your call."
4. After the human responds, prepend the complete entry to the Session Log in PROJECT-TRACKER.md using today's date

---

## CHANGELOG sync

When tasks move to Completed, check if Completed (recent) has more than 10 items:

- If yes: take the oldest completed items and append a log entry to `/context/CHANGELOG.md`
- Format: `## YYYY-MM-DD\n[What was done and why it was done]`
- Keep it to 1–3 sentences. Plain prose, not a list.

If `/context/CHANGELOG.md` doesn't exist, create it with a header: `# Changelog`

---

## File output

Save as `context/PROJECT-TRACKER.md` in the current working directory.

Confirm save with a brief changes summary — what sections were updated and how. Do NOT display the full file. Example format:

```
Updated: context/PROJECT-TRACKER.md
- Status: In Progress → Shipped
- Moved 2 tasks to Done
- 3 items archived to CHANGELOG.md
- Resume section updated
```

---

## Gotchas

- **Looping on save:** "Display the full file inline after saving" caused Claude to re-read the embedded automation rules and act on them recursively. Fix: replaced full-file display with a changes summary (what sections changed and how). The automation rules block also carries a comment clarifying it applies during sessions, not during skill execution.

---

## Progressive Updates

Whenever the user explicitly states not to do something (e.g. "don't ask for X", "stop doing Y", "never include Z"), automatically edit the role and behaviour description at the top of this SKILL.md to reflect that constraint permanently. This ensures the skill adapts to user preferences over time without requiring repeated instructions.
