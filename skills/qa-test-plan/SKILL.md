---
name: qa-test-plan
description: Always use when asked how QA should verify a ticket or PR — "write a test plan", "explain how QA should check this", "test instructions for the tester", "розпиши як тестувальнику перевірити", or `/qa-test-plan PROJ-XXX`. Produces a step-by-step plan a tester without code knowledge can run on stage: preconditions, one shared test fixture, a test-case table with a status column, and an explicit out-of-scope list. The plan itself is written in Ukrainian unless the user asks for another language.
---

# QA test plan

Produce a plan that lets a tester verify one feature on a test environment
without reading code. **Write the plan in Ukrainian** unless the user asks for
another language; keep UI labels, field names and identifiers exactly as they
appear in the app.

Input: a Jira key (`PROJ-XXX`) and, if one exists, the PR. With no PR given,
look for one whose head branch or title contains the key
(`gh pr list --search PROJ-XXX --state all`).

## 1. Gather facts first — never invent behaviour

1. **Ticket** — read the Jira issue: description, acceptance criteria,
   attachments (screenshots often define the expected look).
2. **Diff** — read the PR diff (`gh pr diff <n>` or `git diff <base>...HEAD`).
   From the code, establish:
   - where the feature shows up: which roles, pages, public or anonymous
     flows, preview vs editor modes;
   - exact user-facing strings for every supported locale, from the project's
     translation files;
   - what the feature deliberately does **not** do (e.g. "never makes the
     field required", "not shown in the PDF export");
   - how it is configured, including every alternative path to the same
     setting;
   - persistence: does it survive autosave, reload, reopening a draft?
3. **Cross-check the acceptance criteria against the code.** If an item is not
   implemented, or is implemented differently, list it under the out-of-scope
   section with the reason, or ask the user. Never write a case that is bound
   to fail.

## 2. Document structure

Use these sections in this order (headings in the plan's language; Ukrainian
shown here):

1. **Title** `<PROJ-XXX>: як перевірити <feature>`, date, author, then one
   sentence on what is being verified, with links to the ticket and the PR.
2. **Передумови** — bullets:
   - environment and build that contain the PR, plus how to make sure the new
     build is loaded (hard reload, clearing a service worker or CDN cache);
   - accounts and roles needed;
   - UI language and the exact feature text for each locale;
   - devices: desktop and a 375px mobile width.
3. **Налаштування тестових даних** — a numbered list that builds **one**
   fixture reused by every case, with concrete names, titles, values, and
   exact field and button labels as shown in the UI. If there is a second way to
   configure the feature, describe it here and point to the case covering it.
4. **Тест-кейси** — one table:
   `ID | Сценарій | Кроки | Очікуваний результат | Status`.
   `Status` is a `Not run / Pass / Fail` dropdown where the format supports
   one, otherwise a plain column. One line above the table says where the
   cases run and that a Fail needs a comment with a screenshot.
5. **Що не входить у задачу** — things that may look like bugs but are not,
   each with a short reason, so testers don't file false Fails.

## 3. Case coverage checklist

Walk this list and include every item that applies, roughly simple → complex.
IDs are `TC-01`, `TC-02`, …

- Initial state: nothing entered or configured.
- Happy path: the trigger happens and the feature appears.
- Revert: the trigger stops holding and the feature goes away, then back.
- Control: an element without the configuration stays unchanged.
- Negative acceptance criterion: what the feature must **not** do.
- Persistence: save → leave → reopen or reload.
- Localization: switch every supported language with the feature visible.
- Mobile 375px: wrapping, no clipping, no horizontal scroll.
- Other roles and entry points (public flow, preview, admin view…).
- Alternative configuration path, with both directions kept in sync.
- Complex trigger: combined conditions (`and` / `or`, multi-select).
- Interaction with the neighbouring feature it resembles or builds on.
- Regression on one or two real existing records that don't use the feature.

## 4. Writing rules

- An expected result is something **visible**: text, colour, position, count,
  "immediately, without reload". Never "works correctly".
- Steps refer to the fixture's concrete data, not "field A".
- Quote UI text verbatim, as rendered.
- Leave out implementation details the tester doesn't need (class names,
  hooks, internal properties). Values the tester types into the UI are fine.
- Short sentences; one action per step where possible.

## 5. Output and delivery

- Create the plan as a shared document when a docs connector is available,
  so the Status column can be filled in place. Otherwise write Markdown and
  show it to the user.
- Capture two or three screenshots of the key states (feature shown, feature
  not shown, mobile width) from a running build. A local dev server with
  mocked data is fine.
- **Ask before posting anywhere.** On the user's yes, add the plan as a comment
  on the Jira ticket with the screenshots inline. Jira may reorder pasted
  images, so check the posted comment and make the captions match the real
  order. Report the comment link afterwards.
