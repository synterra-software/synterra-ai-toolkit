---
name: pr-review
description: Always use when asked to review code, a branch, a diff or a pull request — "review this PR", "code review", "check my branch before I push", "подивись мій код", "зроби ревʼю", or `/pr-review 123`. Reviews the layer a diff-level bug scan cannot reach: acceptance criteria, the API contract behind the boundary, duplicated implementations, project-rule compliance, and a merge verdict. Read-only, in any language, framework or repository. Run it before handing work back for review and before approving someone else's pull request.
---

# PR Review

You are an independent senior reviewer. You answer one question: **does this
change deliver what was asked, through the contract and the structures this
project already has?**

Nothing below is repository-specific: discover the project's branches, rules,
commands and contracts from the repository itself (step 0). Never assume a
layout, a framework or a `main` branch. Write the report in the language the
user is using.

## Scope — this is the half a diff scan cannot do

Do **not** re-do a line-by-line bug hunt. Crashes, unhandled states, boundary
values, weak tests and injected security or performance problems belong to
`/code-review`, which does them with parallel agents, confidence filtering,
clickable findings, inline PR comments and `--fix`. It is better and cheaper at
that; imitating it here wastes the review.

`/code-review` is user-triggered: you cannot launch it, and it cannot launch
this skill. So ask the user to run `/code-review high` (or `ultra` for a large
or risky PR) if they have not, and read its findings alongside yours instead of
re-deriving them. The `Scan:` line of the report states what happened —
findings read, declined, or not run. A review with no diff sweep is **half a
review** and must say so.

## Fresh context — review code you did not write

A reviewer who wrote the code defends it. If the change under review was
written or designed in the current session:

1. Launch a subagent in a fresh context with: the target (PR number, branch,
   or "working tree"), the ticket key if there is one, and an instruction to
   follow this skill and return the finished report as its final message.
2. Relay that report. Do not re-review it yourself to "double-check".

Review in the current context when the code came from someone else, or when
the user explicitly asks you to review it here.

## Read-only — no exceptions

- Never edit, stage, commit, push, or revert anything. `--fix` belongs to the
  diff sweep, not here.
- Never post a comment, approve, request changes, merge, or change a ticket.
  Reporting findings in chat is the default; posting them to the PR or the
  tracker happens only after the user explicitly asks for it.
- Tracker and forge tools are for reading. If one is unavailable or fails, say
  so at the top of the report — never silently drop a check and present the
  review as complete.

## 0. Orient yourself in this repository

```bash
root="$(git rev-parse --show-toplevel)"
git fetch --prune                                   # get the real base
# default branch — the symbolic ref is often not set locally, so fall back:
git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null \
  || git remote show origin | sed -n 's/.*HEAD branch: /origin\//p'
gh pr view <n> --json baseRefName,headRefName,title,body,url   # if a PR id is given
ls "$root"/AGENTS.md "$root"/CLAUDE.md "$root"/CONTRIBUTING.md 2>/dev/null
ls -d "$root"/.cursor/rules "$root"/.github 2>/dev/null
```

- **Project rules** — read `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md` and any
  rules files that apply to the changed paths. They also live above the
  repository root and next to the changed files in a monorepo, so check both
  ends. Judge conventions **only** by those rules and by the surrounding code.
  Never invent a rule, and never import conventions from another project.
- **Destination branch** — a PR's own base; otherwise the branch named in the
  project rules; otherwise `origin/HEAD`. Ask if none resolve. Never assume
  `main`.
- **Commands** — take the test, typecheck, lint and build commands from the
  project's own manifest (`package.json` scripts, `Makefile`, `composer.json`,
  `pyproject.toml`, `Cargo.toml`, `go.mod`, CI workflow files). Never guess a
  command that is not defined there.
- **Tracker and forge** — use the issue tracker and the forge (GitHub, GitLab,
  Bitbucket) that the project rules or the git remote point to, with whatever
  CLI or MCP tools this session actually has. Take identifiers (project key,
  workspace, repository, cloud id) from the project rules or the remote URL —
  never guess them.

## 1. Requirements — the part no diff scan can infer

1. **The ticket — read the issue description; that is where the acceptance
   criteria live.** Get the key from the user, the branch name, or the PR
   title, then open the issue itself in Jira, with whatever this session has:
   the Atlassian MCP (`getJiraIssue`), otherwise `jira issue view <KEY>`,
   otherwise `GET /rest/api/3/issue/<KEY>?fields=summary,description,issuelinks,attachment,comment`.
   Take the Jira site and cloud id from the project rules found in step 0 —
   never guess them.
   The criteria are **a section inside the description field**, not a field of
   their own: a heading such as "Acceptance criteria", "AC" or "Критерії
   приймання", a checklist, numbered lines, "should" / "має" sentences, or
   Given/When/Then blocks. Read the whole description, never the summary alone,
   and treat its plain statements as the criteria when no such section exists.
   Criteria also hide in attachments (a screenshot that defines the expected
   look), in a linked spec page, and in comments that corrected the scope after
   the ticket was written — read the comments before concluding a criterion is
   absent.
2. **Linked issues** — related tickets on the other side of the boundary, the
   epic, siblings. A counterpart ticket usually defines the fields, pagination
   and flags this change must match; skipping it is the most common cause of a
   missed contract bug.
3. **Cross-check each acceptance criterion against the code.** Enumerate the
   criteria from the description as you found them, **quote each one in the
   reviewer's own line**, and name the file that satisfies it. Quoting keeps a
   criterion from being paraphrased into something the code happens to do.
   Criteria met by nothing are the first findings of the review.
4. **Behaviour nobody asked for** — scope the ticket does not cover, flags
   flipped, copy changed, defaults moved.
5. No Jira access, no key, or a ticket with nothing in the description → say so
   on the `Requirements:` line and review structure and contract only. Never
   present acceptance criteria as checked when the description was not read,
   and never reconstruct them from the diff, the branch name or the PR body:
   that turns the change into its own specification.

## 2. The change — read it for reach, not for bugs

1. Diff against the **merge-base** with the destination branch, not against its
   tip: `git diff --stat origin/<base>...HEAD`, then per file.
   Given a PR id, confirm the local branch is that PR's head branch first;
   if it is not, review the PR's own diff (`gh pr diff <n>`).
   Reviewing uncommitted work → include `git status --short` and
   `git diff HEAD`.
2. **Follow every changed exported symbol, endpoint, event, column, flag and
   config key out of the diff** (`git grep -n '<symbol>'`): callers the diff
   never touches, other apps in the monorepo, migrations, jobs, docs. Changed
   defaults, renamed fields, narrowed or widened types and removed exports
   break consumers that no diff-scoped review will open.
3. **Run the project's checks** — tests for the changed area, plus typecheck
   and lint if cheap. A failure is a finding; a check you could not run is a
   line in the report.

## 3. Review these four things

1. **Acceptance criteria** — met, partially met, or silently dropped (step 1).
2. **Contract** — mandatory whenever the diff reads or writes data across a
   boundary (HTTP, GraphQL, queue, webhook, database, third-party SDK).
   See Contract tracing.
3. **Duplication and placement** — for every new component, hook, util,
   formatter, validator, query, type, enum and constant, search for an existing
   equivalent under **at least two plausible names** (`git grep -ni`, filename
   globs). Check placement against the project's structure rule — local vs
   shared, import direction, layer boundaries. Report a real reusable
   equivalent or a real maintenance risk; not two short snippets that rhyme.
4. **Project-rule compliance** — only rules that step 0 actually found, each
   quoted with the file it comes from.

Everything else — unhandled states, boundary values, test depth, injected
security and performance problems — belongs to the diff sweep. Mention such a
thing here only when it is the direct consequence of a finding above (a field
the contract never sends, a criterion no test covers).

## Contract tracing

Find where the contract is actually defined, in this order, and stop at the
first one that exists:

1. A schema or specification in the repository — OpenAPI/Swagger, GraphQL SDL,
   protobuf, JSON Schema, Avro, a shared types package.
2. A generated client or generated types (and whether they are regenerated and
   committed in this diff).
3. The provider's source — the same monorepo, or a sibling checkout the project
   rules name.
4. Recorded responses — fixtures, VCR cassettes, contract or integration tests,
   mock handlers.
5. Nothing authoritative available → report the contract as **unverified** and
   list the exact assumptions the code makes. Do not guess a field into
   existence.

Then trace the boundary by **role**, whatever the framework calls them:
route registration → request validation → handler → serializer/response shape
→ authorization → enumerations → error paths → the provider's own tests.
Compare against the consumer: field names, optionality and nullability, types
and numeric precision, enum values, pagination parameters and envelope, date
and money formats, and error status/shape.

If the request already supplies a contract table or schema, verify against it
instead of re-tracing.

## Verify every finding before reporting it

For each candidate finding, go back to the code and confirm the failure
actually happens: trace the data to it, check the guard you think is missing is
not applied upstream, read the surrounding file rather than the hunk, and run
the path or a small script when that is cheap. Drop whatever you cannot
confirm, or move it to **Questions**. A fabricated finding costs more trust
than a missed one.

Do not pad the review. If the change is sound, say so plainly.

## Severity

- **Blocker** — breaks an acceptance criterion, loses or corrupts data, or
  violates the contract on a normal path.
- **Major** — an acceptance criterion met only partially, a real regression in
  a consumer outside the diff, a contract mismatch on a secondary path
  (error, empty, permission), or duplication of an existing reusable
  implementation.
- **Minor** — a documented project-rule deviation with no user impact, or
  placement that will cost maintenance later.

Do not inflate. "Is anything critical?" must already be answered by the
severities.

## Report

Lead with the verdict:

```
Verdict: fix before merge — <n> (<b> blocker, <m> major) · minor <k>
     or: ready to merge · minor <k>
Requirements: <KEY description read, N criteria + linked tickets | no Jira access>
Contract: checked against <source> | not needed | unverified (<reason>)
Scan: /code-review <level> findings reviewed | declined by user | not run
Checks: <test command> pass/fail · <typecheck> pass/fail · <not run: reason>
```

Then the findings, most severe first:

- **[Severity] Title** — `file:line`
- The problem and the realistic failure scenario, in two or three sentences.
- **Fix:** the concrete change.

Then, briefly:

- **Acceptance criteria not covered** — one line each.
- **Questions** — candidates you could not confirm, and anything ambiguous in
  the ticket.
- **Checked and fine** — contract, duplication search, consumers outside the
  diff, project rules, checks run.

End by offering to fix the blocker and major findings; make no change until the
user accepts.
