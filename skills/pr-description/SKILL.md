---
name: pr-description
description: Always use whenever a pull request is being prepared, opened, updated, or described — including `gh pr create`, `gh pr edit`, opening a PR from the GitHub UI or an IDE, pushing a branch in order to open a PR, or finishing a coding task on a feature branch where a PR is the next step. Run it automatically before any action that creates or edits a pull request, even if the user never says "description" or "template", and use its output as the PR title and body. It also creates the `<type>/<PROJECT-XXX>-<description>` branch when the work still sits on the default branch.
---

# PR Description

Read git state and produce PR title/body markdown that mirrors `.github/pull_request_template.md`.

## When this runs — automatically, before any PR is created

Run this skill without being asked whenever a pull request is about to exist or change, including:

- `gh pr create`, `gh pr edit`, `gh pr create --fill`, or any wrapper/script around them;
- "open a PR", "raise a PR", "push and open a PR", "create the pull request", or the same intent in
  other words;
- opening a PR from the GitHub web UI, an IDE, or a bot, when the body is being drafted here;
- finishing work on a feature branch where a pull request is the agreed next step.

Never let a pull request be opened or updated with an ad-hoc body. Produce the title and body here first,
then use exactly that output for the PR. This applies even when the user never says "description",
"template", or "PR description".

## Ownership — content, plus the branch it lands on

- Keep repository inspection read-only. Allowed: `git diff`, `git log`, `git status`, `git branch`,
  `git ls-remote`, and `scripts/changes-table.sh`.
- Create the PR branch when one is needed, per Branch naming below. Do not edit product files, stage,
  commit, or push.
- Do not open or edit a remote PR on this skill's own initiative. When the user has explicitly asked for a
  PR to be created or updated, supply this title/body to that command (Workflow step 6) instead of
  blocking it.
- Don't fix, refactor, or clean up anything in the diff — flag it under NOTES instead.

## Branch naming — create one only when the work has nowhere to land

Check the current branch first. Create a branch only when the work sits on the default branch (`main` or
`master`) or on a branch that cannot host this PR. Already on a valid feature branch → keep it; never
rename it, never re-create it, never switch away from it.

Format: `<type>/<PROJECT-XXX>-<short-kebab-description>`

- **`<type>`** — `feature` (new behavior), `bugfix` (defect fix), `hotfix` (urgent production fix), or
  `chore` (config, docs, tooling, dependencies, or refactor with no behavior change). The type comes
  first, before the Jira key.
- **`<PROJECT-XXX>`** — the same Jira key the Ticket field uses. No key found → ask, don't guess. When the
  user confirms there is no ticket, drop the key segment: `<type>/<short-kebab-description>`.
- **`<short-kebab-description>`** — 2–5 lowercase words naming the outcome, hyphen-separated. ASCII only;
  no spaces, underscores, or uppercase; no leading/trailing hyphen; keep the whole name under ~60 chars.

Examples: `feature/PROJ-412-upload-retry`, `bugfix/PROJ-77-null-session-crash`,
`chore/remove-pr-ui-screenshots`.

Create it from the current `HEAD` so uncommitted work carries over:

```bash
git checkout -b feature/PROJ-412-upload-retry
```

Before creating, confirm the name is free with `git branch --list <name>` and
`git ls-remote --heads origin <name>`; on a collision, ask rather than reusing or overwriting. Never pass
`--force`, never delete or reset a branch, and never move work off a branch that already has commits on it.

## Format — always this exact structure, no placeholders left unfilled

```markdown
## WHAT
- **Ticket:** <PROJECT-XXX — Jira link>
- **Design / brainstorm note:** <link, if any — omit line if none>
- **Summary:** <1–3 sentences: what and why>

## CHANGES
| File | Change |
|------|--------|
| `path/to/file` | <what changed and why> |

## SCREENSHOTS
<GitHub-hosted UI image markdown — omit section if empty>

## NOTES
<risks, follow-ups, related issues/PRs — omit section if empty>

## Type: [ ] trivial  [ ] substantial
```

## Rules per section

**Ticket** — extract `PROJECT-XXX` from the branch name (see Branch naming) →
`https://synterrasoftware.atlassian.net/browse/PROJECT-XXX`. No key found → ask, don't guess. Don't fetch
ticket contents.

**Summary** — from diff + user's description; ask if context is missing. For UI changes, remind the
author to attach screenshots.

**SCREENSHOTS** — optional. Preserve it when updating an existing description. Use GitHub-hosted image
markdown when screenshots are provided.

**CHANGES**
- Trivial change → one line, no table (e.g. `Updated \`config.yml\` to bump the timeout.`).
- Substantial change → run `scripts/changes-table.sh [base]` (base defaults to `origin/main`) for a
  skeleton, then fill each row why-focused, not filename-restated (e.g. "add retry with backoff to the
  upload call", not "changed uploader.ts"). One row per meaningful file/area; collapse lockfiles,
  generated files, bulk formatting into one row.
- **≤3 rows after collapsing → table. >3 rows → drop the table**, replace with grouped bullets (one line
  per area) or, if there's no natural grouping, a 1–2 sentence summary:
  ```markdown
  ## CHANGES
  - **`src/services/`** — add retry-with-backoff to uploads; propagate cancellation to in-flight requests
  - **`src/components/upload/`** — surface retry state in the progress UI
  - **tests** — cover retry, max-attempts, and give-up paths
  ```

**NOTES** — risky areas, follow-ups, migration steps, related issues/PRs (`Closes #123`, `Refs #456`).
Omit entirely if nothing to flag.

**Type** — trivial: config/copy/docs/isolated fix, no shared/core code. substantial: logic, architecture,
shared code, or multi-project. Drives approval policy — when unsure, mark substantial.

## Workflow

1. Resolve the base branch and check the current branch. On the default branch, pick a name per Branch
   naming and create it before anything else, so later commits do not land on `main`.
2. Inspect `git log`, committed diff, staged/unstaged changes, and untracked paths. Do not infer scope from
   branch or commit titles alone.
3. Use `scripts/changes-table.sh [base]` when a committed substantial diff benefits from a skeleton; account
   separately for relevant working-tree paths because the script intentionally compares `base...HEAD`.
4. Draft the title and body per Format and Rules. Preserve user-managed screenshots and notes when revising
   an existing description.
5. Description-only request → return the title/body and stop. The title must use the Jira prefix required
   by CI.
6. A PR-creating or PR-updating action the user explicitly asked for → hand this exact title/body to it via
   a body file outside the repository:
   ```bash
   body="$(mktemp)"
   # write the drafted body into "$body"
   gh pr create --title "PROJ-XXX: <concise title>" --body-file "$body"
   rm -f "$body"
   ```
