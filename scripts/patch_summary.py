#!/usr/bin/env python3
"""
Summarize proposed patches in docs/ai_outputs/patches.
Outputs a report in docs/ai_outputs/checklists/patch_summary_<timestamp>.md
"""
from __future__ import annotations

import re
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PATCH_DIR = ROOT / "docs/ai_outputs/patches"
OUT_DIR = ROOT / "docs/ai_outputs/checklists"

HDR_NEW = re.compile(r"^\+\+\+ b/(.+)")

def summarize() -> str:
    files = sorted(PATCH_DIR.rglob("*.patch"))
    lines: list[str] = []
    lines.append("# Patch Summary")
    lines.append("")
    lines.append(f"Patch dir: {PATCH_DIR}")
    lines.append(f"Total patches: {len(files)}\n")
    if not files:
        return "\n".join(lines) + "\n"
    for p in files:
        text = p.read_text(encoding="utf-8", errors="replace")
        target = None
        add = rem = 0
        for ln in text.splitlines():
            m = HDR_NEW.match(ln)
            if m:
                target = m.group(1)
            if ln.startswith("+++") or ln.startswith("---"):
                continue
            if ln.startswith("+"):
                add += 1
            elif ln.startswith("-"):
                rem += 1
        lines.append(f"- {p.name} → {target or '(unknown)'}  (+{add} / -{rem})")
    return "\n".join(lines) + "\n"

def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    ts = time.strftime("%Y%m%d_%H%M%S")
    out = OUT_DIR / f"patch_summary_{ts}.md"
    out.write_text(summarize(), encoding="utf-8")
    print(f"Wrote {out}")

if __name__ == "__main__":
    main()

