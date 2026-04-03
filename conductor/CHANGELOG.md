# Conductor v2 — Changelog

## v2.1.0 — 2026-03-19

First real end-to-end session exposed multiple self-advance violations. All fixes are backwards-compatible — existing sessions resume cleanly with `/conductor from:[phase]`.

### Bug fixes

**Gate self-approval (all 4 gates)**
The conductor was treating user answers to phase questions as implicit approval to advance. Added explicit CRITICAL blocks to Gates 1–4: the conductor may not say "Approving to continue" or advance to the next phase without an explicit "approve / yes / continue" from the human.

**Tool selection self-decision (Phase 3)**
Conductor was selecting Path B (HTML prototype) unilaterally without presenting the A/B/C/D choice. Added CRITICAL block: must present all options and wait for human selection.

**Plan mode bleed (Phase 3)**
`compound-engineering:workflows:plan` was triggering during the Design phase, collapsing Design + Three Amigos + Build into a single automated pass. Explicitly blocked: `workflows:plan` is forbidden in Phase 3. It may only be used in Phase 5 (Build) for large features.

**Build loop auto-advance after browser open**
After opening the file in the browser for review, the conductor continued into planning mode instead of stopping. Fixed: after opening for review, output one line and stop — wait for feedback before proceeding.

**`workflows:plan` firing for all changes regardless of size**
The full PRD-weight plan was triggering even for small changes (label fix, < 30 lines). Added size check to Build loop: small changes (1–2 files, < ~30 lines) get a 3-bullet inline summary and a "proceed?" prompt. Full `workflows:plan` only for genuinely large or architecturally significant features.

---

### New features

**Pause reflection step**
When the user says "pause" or "stop", the conductor now runs a 2-question reflection before saving state:
1. Anything that went wrong or felt off this session?
2. Anything that worked better than expected?

Answers are written to Memory (cross-project). Project decisions go to HANDOFF.md as usual. Phase state goes to CLAUDE.md as usual. Press Enter to skip either question.

**Parallel Patterns — Worktrees**
New section in the conductor skill. Trigger: "run this in parallel", "open a parallel session", "new branch for this". The conductor produces:
- `git worktree add` command with correct branch and path
- `osascript` command to open a new Terminal session in the worktree (macOS)
- Merge and cleanup commands for when the parallel work is approved

**Parallel Patterns — Delegate**
New section in the conductor skill. Trigger: "delegate X to a subagent", "run X without eating my context". The conductor spawns the correct agent from a delegate map and returns the result inline:

| Task | Agent |
|---|---|
| Design critique | `design:design-critique` |
| Code review | `compound-engineering:workflows:review` |
| Accessibility audit | `design:accessibility-review` |
| Research / docs | `compound-engineering:research:best-practices-researcher` |
| Build plan | `compound-engineering:workflows:plan` |
| Feature build | `compound-engineering:workflows:work` |

---

### New slash commands

**`/delegate [task]`**
Spawns a subagent for a context-heavy task. Result returns inline. Main context stays clean. Works inside or outside a conductor session.

**`/worktree [feature-name]`**
Creates an isolated git worktree and opens a parallel Claude session in a new Terminal window. Works inside or outside a conductor session.

---

## v2.1.3 — 2026-03-22

### Fixed

**`workflows:plan` self-approval in Build loop**
After invoking `workflows:plan` for a large feature, the conductor was treating the plan preview (ExitPlanMode / "Ready to code?") as implicit approval to start building. Fixed: after `workflows:plan` completes, the conductor now explicitly stops and asks "Plan ready — approve to start building [feature name], or tell me what to change." Building does not begin without explicit "approve", "yes", or "continue" from the human.

---

## v2.1.2 — 2026-03-19 ⚠️ UNTESTED

**Stage 2+ parallel offer** *(written, not yet tested in a real conductor session)*
When a stage contains multiple independent deliverables (e.g. two separate pages), the conductor now proactively offers parallel vs sequential execution at the stage transition. Parallel: generates worktree setup for each deliverable, each runs its own conductor session with clean context. Sequential: original behaviour.

**Test required:** Run a conductor session through to Stage 2 with multiple independent deliverables. Verify:
1. Conductor correctly detects multiple independent items and offers the A/B choice
2. Parallel path produces correct `git worktree add` + `osascript` commands for each deliverable
3. Each worktree session resumes correctly with `/conductor from:specify` (or appropriate phase)
4. Merge/cleanup commands are provided when parallel work is approved

---

## v2.1.1 — 2026-03-19

**Build loop review auto-advance**
After R1/R2/R3 all passed on the final section (Footer), the conductor declared "Stage 1 complete" and locked the design contract without waiting for explicit human approval of that section. Fixed: after every R1/R2/R3 review, the conductor now stops and asks "Approve [section] to continue, or tell me what to change." Passing all checks is a recommendation, not a gate pass.

---

## v2.0.0 — original release

Scope Zero → Specify → Design → Three Amigos → Build → Ship. Gates require explicit human approval. Loops iterate until exit conditions are met. State persists via CONDUCTOR STATE block in CLAUDE.md + HANDOFF.md.
