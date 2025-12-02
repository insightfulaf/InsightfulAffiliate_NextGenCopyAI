#!/usr/bin/env python3
"""Fix manifest icon URLs that are accidentally wrapped in double curly braces.

Usage:
  python scripts/fix_manifest_urls.py [paths...]

If no paths are provided, the script checks the common manifest locations used in this repo.
It replaces occurrences like "{{https://...}}" with "https://..." and reports files changed.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path


URL_WRAP_RE = re.compile(r"\{\{(https?://[^\}]+)\}\}")


def fix_file(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    new_text, n = URL_WRAP_RE.subn(r"\1", text)
    if n:
        path.write_text(new_text, encoding="utf-8")
        print(f"Fixed {n} occurrences in: {path}")
        return True
    return False


def main(argv: list[str] | None = None) -> int:
    argv = list(argv or sys.argv[1:])
    if not argv:
        argv = [
            "website_code_block_ORGANIZED/site.webmanifest",
            "website_code_block_ORGANIZED/site.webmanifest.json",
            "website_code_block_ORGANIZED/assets/site.webmanifest",
        ]

    fixed_any = False
    for p in argv:
        path = Path(p)
        if not path.exists():
            print(f"Not found, skipping: {path}")
            continue
        try:
            changed = fix_file(path)
            fixed_any = fixed_any or changed
        except Exception as exc:  # pragma: no cover - best-effort tool
            print(f"Error processing {path}: {exc}")

    if not fixed_any:
        print("No wrapped HTTP(S) URLs found in given files.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
