#!/usr/bin/env python3
"""
Lightweight link and manifest checker for the CURRENT repo.

Checks:
- For each HTML file under website_code_block_ORGANIZED, find relative href/src and verify targets exist.
- Validate canonical manifest JSON (site.webmanifest or .json) has required keys and referenced icons exist if relative.

Writes a Markdown report to docs/ai_outputs/checklists/link_manifest_check_<timestamp>.md
"""
from __future__ import annotations

import json
import re
import time
from pathlib import Path

RE_REL = re.compile(r"^(?!https?://|mailto:|tel:|#|//|data:).+")
HREF_RE = re.compile(r"href\s*=\s*[\"']([^\"']+)[\"']", re.I)
SRC_RE  = re.compile(r"src\s*=\s*[\"']([^\"']+)[\"']", re.I)

ROOT = Path(__file__).resolve().parents[1]
WEB = ROOT / "website_code_block_ORGANIZED"
OUT_DIR = ROOT / "docs/ai_outputs/checklists"

def find_manifests() -> list[Path]:
    out: list[Path] = []
    for cand in [WEB / "site.webmanifest", WEB / "site.webmanifest.json"]:
        if cand.exists():
            out.append(cand)
    man_dir = WEB / "manifests"
    if man_dir.exists():
        out.extend(sorted(p for p in man_dir.iterdir() if p.suffix in (".json", "")))
    return out

def normalize(p: Path) -> str:
    return str(p).replace("\\", "/")

def check_html_links() -> list[str]:
    issues: list[str] = []
    for page in sorted(WEB.rglob("*.html")):
        try:
            txt = page.read_text(encoding="utf-8", errors="replace")
        except Exception as e:
            issues.append(f"{normalize(page)}: cannot read UTF-8 ({e})"); continue
        links = HREF_RE.findall(txt) + SRC_RE.findall(txt)
        for link in links:
            link = link.strip()
            if not RE_REL.match(link):
                continue
            # strip query/fragment
            clean = link.split("?",1)[0].split("#",1)[0]
            target = (page.parent / clean).resolve()
            if not target.exists():
                issues.append(f"{page.name}: broken relative link → {link}")
    return issues

def check_manifest() -> list[str]:
    all_issues: list[str] = []
    mfs = find_manifests()
    if not mfs:
        return ["No manifests found at website_code_block_ORGANIZED/(site.webmanifest|site.webmanifest.json|manifests/*.json)"]
    required = ["name", "short_name", "icons", "start_url", "display", "theme_color", "background_color"]
    for mf in mfs:
        issues: list[str] = []
        try:
            data = json.loads(mf.read_text(encoding="utf-8"))
        except Exception as e:
            all_issues.append(f"Manifest unreadable JSON: {normalize(mf)} ({e})");  continue
        for k in required:
            if k not in data:
                issues.append(f"{normalize(mf)}: missing key {k}")
        icons = data.get("icons", []) or []
        for i, ic in enumerate(icons):
            src = (ic or {}).get("src")
            if not src:
                issues.append(f"{normalize(mf)}: icon #{i} missing src");  continue
            if RE_REL.match(src):
                t = (mf.parent / src.split("?",1)[0].split("#",1)[0]).resolve()
                if not t.exists():
                    issues.append(f"{normalize(mf)}: icon not found → {src}")
        all_issues.extend(issues)
    return all_issues

def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    lines: list[str] = []
    lines.append("# Link & Manifest Check Report")
    lines.append("")
    lines.append(f"Root: {normalize(ROOT)}  ")
    lines.append(f"Website dir: {normalize(WEB)}  ")
    lines.append("")

    link_issues = check_html_links()
    man_issues = check_manifest()

    lines.append("## Summary")
    lines.append(f"- HTML files scanned: {len(list(WEB.rglob('*.html')))}")
    lines.append(f"- Broken links: {len(link_issues)}")
    lines.append(f"- Manifest issues: {len(man_issues)}")
    lines.append("")

    if link_issues:
        lines.append("## Broken Links")
        for it in link_issues:
            lines.append(f"- {it}")
        lines.append("")

    if man_issues:
        lines.append("## Manifest Issues")
        for it in man_issues:
            lines.append(f"- {it}")
        lines.append("")

    ts = time.strftime("%Y%m%d_%H%M%S")
    out = OUT_DIR / f"link_manifest_check_{ts}.md"
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Wrote {normalize(out)}")

if __name__ == "__main__":
    main()
