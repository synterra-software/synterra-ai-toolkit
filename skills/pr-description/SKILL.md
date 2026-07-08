---
name: pr-description
description: Generate a standardized pull request description in the Synterra format — WHAT (ticket link + summary), a CHANGES table of modified files with a short note on what changed in each, NOTES, and a trivial/substantial Type. Use this whenever opening or preparing a pull request, writing or updating a PR description, running `gh pr create`, summarizing a branch's changes for review, or when an agent finishes a coding task and is about to open a PR — even if the user doesn't say "template" or "description". If work has been committed to a feature branch and a PR is the next step, use this skill.
---

# PR Description

Produce the PR description in our company-standard shape so reviewers get context without knowing
the project. A good description makes review fast and cheap: the reviewer sees *what* changed, *where*,
and *why*, plus anything to watch. This mirrors `.github/pull_request_template.md`.

## Scope — read-only, never modify the repo

This skill's entire job is to READ the git state and PRODUCE description text. It must not change the
project. This matters especially because the skill usually runs right after a commit, when the agent
was just editing code — switch fully out of edit mode now.

- Do NOT edit, create, move, delete, or stage any file in the working tree — not code, not configs,
  not the PR template, nothing.
- Do NOT "fix," refactor, or clean up anything you notice in the diff. If the diff reveals a bug,
  typo, or risky change, describe it under NOTES — flagging it *is* the deliverable, fixing it is not.
- Do NOT run any state-changing git command: no `add`, `commit`, `commit --amend`, `push`,
  `restore`, `checkout`, `reset`, or `stash`. Use read-only commands only: `git diff`, `git log`,
  `git status`, `git branch`, and `scripts/changes-table.sh`.
- The only file you may write is a throwaway body file for `gh` (see the end), and it must live
  OUTSIDE the repo (via `mktemp`), never inside the working tree.

The deliverable is the markdown description — text, not a change to the codebase.

## Output format — ALWAYS use this exact structure

```markdown
## WHAT
- **Ticket:** <PROJECT-XXX — Jira link>
- **Design / brainstorm note:** <link, if any — omit the line if none>
- **Summary:** <1–3 sentences: what this PR does and why.>

## CHANGES
| File | Change |
|------|--------|
| `path/to/file` | <what changed and why> |

## NOTES
<Anything the reviewer should pay special attention to. Omit this section if there is nothing.>

## Type: [ ] trivial  [ ] substantial
```

Never leave placeholders (`<...>`) or empty sections in the final output. If a value is unknown, get it
(see below) or ask — don't ship the template half-filled.

## How to fill each part

### Ticket (WHAT)
Derive the Jira key from the branch name. Branches follow `feature|bugfix|hotfix|chore/PROJECT-XXX-desc`,
so extract the `PROJECT-XXX` token (uppercase letters, a hyphen, then digits) from the branch name.

- If a key is found, build the link and use it as the ticket:
  `https://synterrasoftware.atlassian.net/browse/PROJECT-XXX`
- If the branch has no key, ask the user for the ticket rather than guessing.

Don't fetch the ticket's contents — just build the link from the key. For the WHAT summary, use the
diff and the user's description; if you need more context, ask.

### CHANGES table
If the change is **trivial** (see Type below), skip the full table — a one-line summary of what
changed is enough (e.g. `Updated \`config.yml\` to bump the timeout.`). Only build the full table for
**substantial** changes.

Run the helper to get a table skeleton from the actual diff, then fill the "what & why" per row:

```bash
scripts/changes-table.sh [base]     # base defaults to origin/main
```

Then refine the skeleton:
- One row per **meaningful** file or area — collapse noise. Lockfiles, generated files, and bulk
  formatting-only changes get a single summary row (e.g. `| lockfile / generated | dependency bump |`),
  not one row each.
- The "Change" cell is **why-focused**, not a restatement of the filename: say what behavior changed and
  the reason, e.g. "add retry with backoff to the upload call" — not "changed uploader.ts".
- Keep each cell to one line.

If the table ends up large or hard to scan (many rows, e.g. touching 15+ files), drop the per-file
table and group by area/directory instead — a short bulleted list with one line per area and the key
change, e.g.:

```markdown
## CHANGES
- **`src/services/`** — add retry-with-backoff to uploads; propagate cancellation to in-flight requests
- **`src/components/upload/`** — surface retry state in the progress UI
- **tests** — cover retry, max-attempts, and give-up paths
```

Keep it to the handful of areas that matter — this is still a map for the reviewer, not a full file list.

### Summary (WHAT)
1–3 sentences describing the change and its purpose. For frontend work, remind the author to attach UI
screenshots (the skill can't produce them).

### NOTES
Call out risky areas, follow-ups, migration steps, or things the reviewer should scrutinize. If there's
genuinely nothing, omit the whole section — don't pad it.

### Type
- **trivial** — config, copy, docs, or an isolated fix; no shared/core code, no architectural impact.
- **substantial** — logic, architecture, shared code, or anything touching multiple projects.
This drives the approval policy, so choose deliberately; when unsure, mark substantial.

## Example

**Input:** branch `feature/PROJ-412-upload-retry`, commits adding retry logic to the file uploader and a test.

**Output:**
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

## If `gh` is available

Opening a PR is a side effect, so only do it when the user actually asked to (e.g. "open the PR" or
they ran `gh pr create`). If they only wanted the description, print the markdown and stop — don't
create anything.

When you do open it, write the body to a temp file OUTSIDE the repo so the working tree stays clean:

```bash
body="$(mktemp)"     # e.g. /tmp/tmp.XXXXXX — never a path inside the repo
# write the composed description into "$body"
gh pr create --title "PROJ-XXX: <concise title>" --body-file "$body"
rm -f "$body"
```

Keep the PR title prefixed with the Jira key — a CI check requires it.
