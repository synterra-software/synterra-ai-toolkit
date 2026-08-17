---
name: add-pr-ui-screenshots
description: Capture screenshots of UI introduced or changed by the current branch and add them to the description of an existing GitHub pull request without replacing its other content. Use when a user asks to screenshot new frontend work, attach UI evidence to a PR, add visual proof to the current PR, update an existing pull request description with screenshots, or confirms the mandatory screenshot prompt shown after pr-description creates a PR.
---

# Add PR UI Screenshots

Capture the real changed UI, upload the images as GitHub attachments, and merge a `## SCREENSHOTS`
section into an existing PR description.

## Boundaries

- Require an existing pull request. Never create one as part of this workflow.
- Treat the user's request to add screenshots as authorization to update only that PR description.
- Do not change, stage, commit, or push source files. Keep screenshots and PR body files in a temporary
  directory outside the repository.
- Preserve every existing PR section and all user-authored text. Only add or replace
  `## SCREENSHOTS`.
- Never fabricate UI, attachment URLs, successful uploads, or successful PR updates.
- Do not capture secrets, personal data, debug panels, unrelated tabs, browser chrome, or local paths.

## Dependencies

1. Read and follow `../pr-description/SKILL.md` so the resulting body keeps the Synterra PR format.
2. Before controlling a browser, read and follow the available browser-control skill completely. Use
   its supported browser screenshot and file-upload APIs rather than OS-level capture.
3. Prefer a GitHub connector for structured PR reads when available. Use `gh` for current-branch PR
   discovery and for updating a body from a file when the connector lacks that operation.

## Workflow

### 1. Resolve the pull request and changed UI

- Use an explicit PR URL or number when provided. Otherwise resolve the current branch's PR with:

  ```bash
  gh pr view --json number,url,title,body,headRefName,baseRefName
  ```

- Stop and ask for the PR when no existing PR can be resolved. Never silently target a different PR.
- Read repository instructions and inspect the PR diff against its base. Identify the changed routes,
  components, states, and viewport(s) that materially demonstrate the new code.
- Default to screenshots of the changed result only. Capture before/after pairs only when requested or
  when the visual difference is otherwise ambiguous.

### 2. Run and prepare the UI

- Reuse an already-running development server when possible. Otherwise use the repository's documented
  command and keep the process available until capture is complete.
- Navigate to a deterministic state that exercises the changed code. Prefer fixtures, stories, seeded
  data, or existing local test credentials over manually altering production-like data.
- Do not bypass authentication, inspect credential stores, or create external data unless the user has
  authorized it.
- If the changed UI cannot be reached or rendered faithfully, report the blocker and do not upload a
  substitute image.

### 3. Capture and verify screenshots

- Create a temporary working directory with `mktemp -d` and save PNG files there.
- Use a desktop viewport around 1440x900 by default. Add a mobile viewport only for responsive changes.
- Capture the smallest viewport or element that preserves enough context to understand the feature.
  Avoid full-page screenshots dominated by unchanged UI.
- Use concise, semantic names and labels such as `checkout-error-state` or `mobile-filter-drawer`.
- Inspect every image before upload. Verify that it shows the intended changed state, is readable, has
  no loading artifacts, and contains no sensitive or unrelated information.

### 4. Upload images as GitHub attachments

- Open the exact PR in an authenticated browser and enter description edit mode.
- Upload each PNG through the PR description editor. Wait until GitHub replaces the upload placeholder
  with attachment markdown containing a real `https://github.com/user-attachments/...` URL.
- Record the generated URL for each image. Do not use a local path, `file://` URL, base64 data, branch
  file, or guessed URL in the PR body.
- If upload or authentication fails, leave the PR unchanged and ask the user to restore access.

### 5. Merge and publish the description

- Save the exact current PR body to a temporary file. Re-read it immediately before updating to reduce
  the chance of overwriting a concurrent edit.
- Resolve the bundled script relative to this `SKILL.md`, not relative to the target repository. Then
  generate the updated body:

  ```bash
  python3 "$skill_dir/scripts/merge-screenshots.py" \
    --body "$tmp_dir/current-body.md" \
    --output "$tmp_dir/updated-body.md" \
    --image "Checkout error state=https://github.com/user-attachments/assets/<id>"
  ```

- Pass `--image` once per screenshot. The script replaces an existing `## SCREENSHOTS` section or
  inserts it before `## NOTES`, then `## Type`, then the end of the body.
- Review the complete generated body and confirm that only `## SCREENSHOTS` changed.
- Update the exact resolved PR, for example:

  ```bash
  gh pr edit "$pr_url" --body-file "$tmp_dir/updated-body.md"
  ```

- Re-fetch the PR and verify that the saved body contains every uploaded image URL and all original
  non-screenshot content. Report the PR URL and the screenshot labels added.

## Screenshot Section Format

Use this structure, with one labeled image block per changed state:

```markdown
## SCREENSHOTS

**Checkout error state**

![Checkout error state](https://github.com/user-attachments/assets/<id>)
```

Keep before/after images explicitly labeled and ordered `Before`, then `After`.
