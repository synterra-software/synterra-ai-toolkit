---
name: pr-description
description: Generate a standardized pull request description in the Synterra format — WHAT (ticket link + summary), a CHANGES table of modified files with a short note on what changed in each, NOTES, and a trivial/substantial Type. Use this whenever opening or preparing a pull request, writing or updating a PR description, running `gh pr create`, summarizing a branch's changes for review, or when an agent finishes a coding task and is about to open a PR — even if the user doesn't say "template" or "description". If work has been committed to a feature branch and a PR is the next step, use this skill.
---

# PR Description

Read git state, produce PR description markdown. Mirrors `.github/pull_request_template.md`.

## Scope — read-only

- Never edit/create/move/delete/stage any file, never run a state-changing git command (`add`, `commit`,
  `push`, `restore`, `checkout`, `reset`, `stash`). Allowed: `git diff`, `git log`, `git status`,
  `git branch`, `scripts/changes-table.sh`.
- Don't fix, refactor, or clean up anything in the diff — flag it under NOTES instead.
- Only exception: a `mktemp` body file for `gh` (Workflow step 4) — must live outside the repo.

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

## NOTES
<risks, follow-ups, related issues/PRs — omit section if empty>

## Type: [ ] trivial  [ ] substantial
```

## Rules per section

**Ticket** — extract `PROJECT-XXX` from branch name (`feature|bugfix|hotfix|chore/PROJECT-XXX-desc`) →
`https://synterrasoftware.atlassian.net/browse/PROJECT-XXX`. No key found → ask, don't guess. Don't fetch
ticket contents.

**Summary** — from diff + user's description; ask if context is missing. For UI changes, remind the
author to attach before/after screenshots (you can't produce them).

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

## Example

Branch `feature/PROJ-412-upload-retry`, commits adding upload retry logic + test:

```markdown
## WHAT
- **Ticket:** [PROJ-412](https://synterrasoftware.atlassian.net/browse/PROJ-412)
- **Summary:** Uploads intermittently failed on flaky networks. Adds automatic retry with exponential
  backoff to the upload call so transient errors self-recover.

## CHANGES
| File | Change |
|------|--------|
| `src/services/uploader.ts` | add retry-with-backoff wrapper around the PUT request |
| `src/services/uploader.test.ts` | cover retry, max-attempts, and give-up paths |

## NOTES
Backoff cap is 30s; if the endpoint starts rate-limiting we may want a jitter follow-up.

## Type: [ ] trivial  [x] substantial
```

## Workflow

1. `git log` + `git diff` against the branch base to get real scope — don't infer from branch/commit titles.
2. Draft the description per Format + Rules above.
3. Description-only request → print markdown, stop. Only open a PR if explicitly asked (e.g. "open the PR").
4. To open (per Scope):
   ```bash
   body="$(mktemp)"
   gh pr create --title "PROJ-XXX: <concise title>" --body-file "$body"
   rm -f "$body"
   ```
   Title must be prefixed with the Jira key — required by CI.
