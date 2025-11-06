#!/usr/bin/env python3
"""
Minimal Playwright automation to update a Systeme.io page header.

SECURITY: This script reads credentials from environment variables and does not store them.
Required env vars:
  SYSTEME_EMAIL, SYSTEME_PASSWORD, PAGE_URL, HEAD_FILE

Install once:
  python -m pip install playwright
  python -m playwright install chromium

Run:
  SYSTEME_EMAIL=you@example.com SYSTEME_PASSWORD=secret \
  PAGE_URL=https://app.systeme.io/workspaces/.../pages/... \
  HEAD_FILE=docs/ai_outputs/_snippets/head-snippet-IA.html.out.html \
  python scripts/systeme_update_header.py

NOTE: The DOM structure of Systeme.io may change; this script uses robust selectors but may require updates.
"""
from __future__ import annotations

import os
import sys
from pathlib import Path

try:
    from playwright.sync_api import sync_playwright
except Exception:
    print("Missing dependency: playwright. Install with: python -m pip install playwright && python -m playwright install chromium", file=sys.stderr)
    sys.exit(1)


def main() -> None:
    email = os.getenv("SYSTEME_EMAIL", "").strip()
    password = os.getenv("SYSTEME_PASSWORD", "").strip()
    page_url = os.getenv("PAGE_URL", "").strip()
    head_file = os.getenv("HEAD_FILE", "").strip()
    if not (email and password and page_url and head_file):
        print("Missing env vars. Require SYSTEME_EMAIL, SYSTEME_PASSWORD, PAGE_URL, HEAD_FILE", file=sys.stderr)
        sys.exit(2)
    head_html = Path(head_file).read_text(encoding="utf-8")

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        context = browser.new_context()
        page = context.new_page()

        # Login
        page.goto("https://app.systeme.io/login", wait_until="load")
        page.fill("input[type=email]", email)
        page.fill("input[type=password]", password)
        page.click("button[type=submit]")
        page.wait_for_load_state("networkidle")

        # Navigate to target page editor
        page.goto(page_url, wait_until="load")
        page.wait_for_load_state("networkidle")

        # Open Settings → SEO/Head panel; selectors may vary, try common patterns
        # Try to click Settings
        try:
            page.click("text=Settings")
        except Exception:
            pass
        # Try “SEO/Head” tab
        try:
            page.click("text=SEO/Head")
        except Exception:
            # Fallback: look for textarea by label
            pass

        # Focus header textarea and paste content
        # Common selector attempts; adjust as needed in future
        candidates = [
            "textarea[name='head']",
            "textarea[placeholder*='Header']",
            "textarea",
        ]
        for sel in candidates:
            try:
                page.fill(sel, head_html)
                break
            except Exception:
                continue

        # Save / Publish
        for label in ("Save", "Publish", "Update"):
            try:
                page.click(f"text={label}")
                break
            except Exception:
                continue

        print("Header update flow executed. Please verify in the browser.")
        # Keep browser open for manual confirm
        page.wait_for_timeout(3000)
        context.close()
        browser.close()

if __name__ == "__main__":
    main()

