#!/usr/bin/env python3
"""
Render brand-specific head snippets from the template with simple placeholder replacement.

Usage:
  python scripts/generate_head_snippets.py \
    --template landing_pages/headers/head-snippet-ngcai.html \
    --config configs/brands/ia.yml \
    --output docs/ai_outputs/_snippets/head-snippet-IA.html.out.html

Placeholders in the template use {{NAME}} and are provided by YAML keys
like NAME: "value". If `override_css_url` is set, a second <link rel="stylesheet">
is injected after the main CSS link.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

try:
    import yaml  # type: ignore
except Exception:
    print("Missing dependency: pyyaml. Install with: python -m pip install pyyaml", file=sys.stderr)
    sys.exit(1)

CSS_PLACEHOLDER_RE = re.compile(r"<link[^>]+href=\"\{\{NGCAI_CSS_URL\}\}\"[\s\S]*?>", re.I)

def render(template: str, mapping: dict[str, str]) -> str:
    out = template
    for k, v in mapping.items():
        out = out.replace(f"{{{{{k}}}}}", v)
    # Inject override CSS after the main CSS link if provided
    override = mapping.get("OVERRIDE_CSS_URL") or mapping.get("override_css_url")
    if override:
        tag = f"\n<link rel=\"stylesheet\" href=\"{override}\" />"
        out, n = CSS_PLACEHOLDER_RE.subn(lambda m: m.group(0) + tag, out, count=1)
        if n == 0:
            # Fall back to injecting before </head>
            out = out.replace("</head>", tag + "\n</head>")
    return out

def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--template", required=True, type=Path)
    ap.add_argument("--config", required=True, type=Path)
    ap.add_argument("--output", required=True, type=Path)
    args = ap.parse_args()

    tpl = args.template.read_text(encoding="utf-8")
    data = yaml.safe_load(args.config.read_text(encoding="utf-8")) or {}
    # Flatten keys, uppercase variant for convenience
    mapping: dict[str, str] = {}
    for k, v in data.items():
        if v is None:
            continue
        mapping[k] = str(v)
        mapping[k.upper()] = str(v)

    rendered = render(tpl, mapping)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(rendered, encoding="utf-8")
    print(f"Wrote {args.output}")

if __name__ == "__main__":
    main()

