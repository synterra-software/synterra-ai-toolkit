#!/usr/bin/env python3
"""Add or replace a SCREENSHOTS section in a pull request body."""

from __future__ import annotations

import argparse
import re
from pathlib import Path
from urllib.parse import urlparse


SCREENSHOTS_HEADING = "## SCREENSHOTS"
NEXT_SECTION_RE = re.compile(r"(?m)^##\s+.+$")
INSERT_BEFORE_RE = re.compile(r"(?m)^##\s+(?:NOTES\b|Type\s*:)")


def parse_image(value: str) -> tuple[str, str]:
    if "=" not in value:
        raise argparse.ArgumentTypeError("image must use LABEL=URL")

    label, url = (part.strip() for part in value.split("=", 1))
    parsed = urlparse(url)
    is_github_attachment = (
        parsed.scheme == "https"
        and parsed.netloc == "github.com"
        and parsed.path.startswith("/user-attachments/")
    )
    if not label or not is_github_attachment:
        raise argparse.ArgumentTypeError(
            "image must contain a label and a GitHub user-attachments URL"
        )

    return label, url


def alt_text(label: str) -> str:
    return label.replace("\\", "\\\\").replace("[", "\\[").replace("]", "\\]")


def build_section(images: list[tuple[str, str]]) -> str:
    blocks = []
    for label, url in images:
        blocks.append(f"**{label}**\n\n![{alt_text(label)}]({url})")
    return f"{SCREENSHOTS_HEADING}\n\n" + "\n\n".join(blocks)


def merge_screenshots(body: str, section: str) -> str:
    normalized = body.rstrip()
    heading_match = re.search(r"(?m)^## SCREENSHOTS\s*$", normalized)

    if heading_match:
        next_match = NEXT_SECTION_RE.search(normalized, heading_match.end())
        end = next_match.start() if next_match else len(normalized)
        prefix = normalized[: heading_match.start()].rstrip()
        suffix = normalized[end:].lstrip()
    else:
        insert_match = INSERT_BEFORE_RE.search(normalized)
        end = insert_match.start() if insert_match else len(normalized)
        prefix = normalized[:end].rstrip()
        suffix = normalized[end:].lstrip()

    parts = [part for part in (prefix, section, suffix) if part]
    return "\n\n".join(parts) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Add or replace the SCREENSHOTS section in a PR body."
    )
    parser.add_argument("--body", required=True, type=Path, help="Existing PR body file")
    parser.add_argument("--output", required=True, type=Path, help="Updated PR body file")
    parser.add_argument(
        "--image",
        required=True,
        action="append",
        type=parse_image,
        metavar="LABEL=URL",
        help="Screenshot label and uploaded GitHub attachment URL; repeat as needed",
    )
    args = parser.parse_args()

    body = args.body.read_text(encoding="utf-8")
    updated = merge_screenshots(body, build_section(args.image))
    args.output.write_text(updated, encoding="utf-8")


if __name__ == "__main__":
    main()
