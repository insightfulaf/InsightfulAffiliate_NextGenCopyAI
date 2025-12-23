---
title: New Asset URL Tracker
description: Guidance on uploading and using assets in Systeme.io for InsightfulAffiliate/NextGenCopyAI
---

## Purpose

This tracker helps you organise the assets required by your unified site setup. Each item should be uploaded to **Systeme.io → Media**. After uploading, copy the **public URL** and substitute it into your head snippet (`headers/head-snippet-v7-production.html`) or manifest (`site.webmanifest`).

## Required assets

| Asset | Suggested filename | Replace in | Notes |
|---|---|---|---|
| Unified CSS | `ngcai.css` | `{{NGCAI_CSS_URL}}` | Upload the CSS file located at `website_code_block_ORGANIZED/assets/ngcai.css`. Copy the public URL from Systeme and paste into `headers/head-snippet-v7-production.html`. |
| Favicon (ICO) | `favicon.ico` | `{{FAVICON_ICO_URL}}` | Use a 32×32 or 64×64 `.ico` file. Upload and copy its URL. |
| Apple touch icon | `apple-touch-icon.png` | `{{APPLE_TOUCH_ICON_URL}}` | 180×180 PNG for iOS homescreen bookmarking. |
| Maskable icon | `maskable-512x512.png` | `{{ICON_512_MASKABLE_URL}}` & `{{MASKABLE_ICON_URL}}` | Use a 512×512 PNG with safe margins for Android adaptive icons. |
| Icon (192×192) | `icon-192.png` | `{{ICON_192_URL}}` | Optional, used by some browsers. |
| Icon (512×512) | `icon-512.png` | `{{ICON_512_URL}}` | General purpose high‑resolution icon. |
| Web Manifest | `site.webmanifest` | `{{MANIFEST_URL}}` | Upload the provided manifest and copy the resulting URL. Replace the icon placeholders in the file with the URLs of your uploaded icons before uploading, or update the manifest after upload. |
| Default OG image | `og-default.png` | `{{OG_IMAGE_URL}}` | 1200×630 PNG used for social sharing previews. |
| Default Twitter image | `twitter-default.png` | `{{TWITTER_IMAGE_URL}}` | 1200×628 PNG used specifically for Twitter cards. |

## Usage tips

1. **Upload first, copy later.** For each file, upload it via Systeme’s Media manager. Once uploaded, copy the file's public URL.
2. **Update the head snippet.** Open `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html` and replace the placeholders with the copied URLs and your brand details (page titles, descriptions, social profile links, etc.).
3. **Update the manifest.** Open `website_code_block_ORGANIZED/site.webmanifest` and replace the `{{ICON_XXX_URL}}` placeholders with the URLs of your uploaded icons. Then upload the manifest itself and paste its URL into the head snippet.
4. **Keep this tracker.** Store this file in your project to remember where to substitute new asset URLs when you update or add images.
