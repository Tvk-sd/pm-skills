# Conductor v2 — PM OS for Claude Code

A human-in-the-loop build conductor for Claude Code. Takes a fuzzy idea through a structured PM workflow — from scope to shipped feature — with explicit approval gates at every phase transition.

## What it does

Conductor runs a six-phase PM workflow:

```
Scope Zero → Specify → Design → Three Amigos → Build → Ship
```

Each phase has a defined exit condition. Nothing moves forward without explicit human approval. The conductor saves session state to `CLAUDE.md` and `context/PROJECT-TRACKER.md` so sessions can be paused and resumed cleanly.

## Core design principle

> **Positive outcomes are not approvals.**

This is the foundational rule the entire conductor is built on. Passing a review, answering a question, completing a build iteration — none of these count as approval to advance. Only an explicit human confirmation ("approve", "yes", "continue") passes a gate.

Every self-advance bug found in testing followed the same pattern: the model treated a good outcome as implicit permission to keep going. All gate CRITICAL blocks exist to prevent exactly this.

## Usage

```
/conductor
```

Start a new session from Scope Zero.

```
/conductor from:build
```

Resume an existing session from a specific phase. Valid phases: `scope`, `specify`, `design`, `amigos`, `build`, `ship`.

## Phases

### Phase 1 — Scope Zero
Three questions that establish the outcome, opportunity, and user. Forces early scope constraint. Exit: gate approval.

### Phase 2 — Specify
Vertical slices into Stage 1. Sizes the work (S/M/L). Separates Now / Next / Later. Exit: gate approval.

### Phase 3 — Design
Path A (existing reference), B (HTML prototype), C (MCP canvas). Design loop with R1/R2/R3 review per iteration. Exit: gate approval + Three Amigos agenda seeded.

### Phase 4 — Three Amigos
PM, Engineering, and UX lenses in sequence. Surfaces blockers and risks before code starts. Exits with a locked design contract written to `CLAUDE.md`. Exit: gate approval.

### Phase 5 — Build
Feature by feature, held against the locked design contract. Size check before each feature (small = inline 3-bullet, large = full plan). R1/R2/R3 review after each build. **Human approves each unit before the next starts.** Exit: all acceptance criteria met + explicit approval.

### Phase 6 — Ship
Later items surfaced. Session closed cleanly. context/PROJECT-TRACKER.md updated. CONDUCTOR STATE cleared.

## Session state

The conductor writes two state files at every gate and on pause:

- **`CLAUDE.md`** (CONDUCTOR STATE block) — current phase, stage, outcome, opportunity, design contract status, open risks, next step. Machine-readable for resumption.
- **`context/PROJECT-TRACKER.md`** — narrative state: what was built, decisions made, what's next. Human-readable context for the next session.

## Pause protocol

Say `pause` or `stop` at any point. The conductor will:

1. Ask two reflection questions before saving:
   - Anything that went wrong or felt off this session?
   - Anything that worked better than expected?
2. Write answers to Memory (cross-project, persists to future sessions)
3. Write project decisions to `context/PROJECT-TRACKER.md`
4. Write phase state to `CLAUDE.md`
5. Confirm: `State saved. Resume with: /conductor from:[phase]`

Press Enter to skip either reflection question.

## Parallel patterns

### Stage transition — parallel offer *(untested — needs real session validation)*

When a stage contains multiple independent deliverables (e.g. two separate pages), the conductor proactively offers at the stage transition:

```
Stage 2 has 2 independent deliverables: work.html and contact.html.
Want to build them in parallel or sequentially?

A) Parallel — worktree for each, independent conductor session per deliverable
B) Sequential — build one after the other in this session
```

Parallel keeps the main session context clean. Sequential is simpler but accumulates context across both builds.

### Worktrees
Trigger: "run this in parallel", the parallel offer above, or `/worktree [feature-name]`

Creates an isolated git branch + opens a new Terminal session in the worktree. The parallel session runs its own conductor instance. Merge commands provided when the work is approved.

### Delegate
Trigger: "delegate X to a subagent" or use `/delegate [task]`

Spawns the right agent for a context-heavy task, returns the result inline, and keeps the main conductor context clean.

| Task | Agent |
|---|---|
| Design critique | `design:design-critique` |
| Code review | `compound-engineering:workflows:review` |
| Accessibility audit | `design:accessibility-review` |
| Research / docs | `compound-engineering:research:best-practices-researcher` |
| Build plan | `compound-engineering:workflows:plan` |
| Feature build | `compound-engineering:workflows:work` |

## Slash commands

| Command | What it does |
|---|---|
| `/conductor` | Start a new session |
| `/conductor from:[phase]` | Resume an existing session |
| `/pause` | Save state + run reflection (inside conductor session) |
| `/delegate [task]` | Spawn a subagent for a context-heavy task |
| `/worktree [feature-name]` | Create an isolated branch + parallel Terminal session |

## Context management

The conductor monitors context length during the Build phase. When the session is getting long, it will warn:

> "Context is getting full. I recommend pausing now before auto-compact hits — auto-compact erases my conductor awareness and you'll need to resume manually."

A SessionStart hook (configured in `~/.claude/settings.json`) detects active conductor sessions when a new Claude Code session opens and reminds you to resume with the correct command.

## Known behaviour

- The conductor does not self-approve gates — ever. If it does, interrupt (Esc) and report it as a bug.
- `compound-engineering:workflows:plan` is forbidden in Phase 3 (Design). It may only be used in Phase 5 (Build) for large features.
- Small changes in the Build loop (1–2 files, < ~30 lines) get an inline 3-bullet summary, not a full plan.
- After opening a file in the browser for review, the conductor outputs one line and stops. It does not start planning.

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for full version history and bug fixes.
