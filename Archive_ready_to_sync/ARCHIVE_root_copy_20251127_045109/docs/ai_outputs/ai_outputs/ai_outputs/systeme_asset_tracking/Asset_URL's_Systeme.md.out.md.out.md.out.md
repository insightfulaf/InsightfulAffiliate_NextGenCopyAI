## Notes
This document outlines asset URLs and integration steps for Systeme.io in a straightforward manner.

## Asset URLs

### CSS / Webmanifest
- **Brand-ui.css:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b75bff8673d_brand-ui.css)  
- **Brand-ui.css #2:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b939ecc4901_brand-ui.css)  
- **Webmanifest:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b7ac4471c03_site.webmanifest.json)

### Workmarks
- **NextGenCopyAI Horizontal Transparent Dark:**
  - [240w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bc00626cfb7_NextGenCopyAI_horizontal_transparent_dark-fg_240w.png)  
  - [640w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bc0bd222e38_NextGenCopyAI_horizontal_transparent_dark-fg_640w.png)  
- **NextGenCopyAI Horizontal Transparent Light:**
  - [480w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bd5a88961c9_NextGenCopyAI_horizontal_transparent_light-fg_480w.png)  
  - [640w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bc0bd223245_NextGenCopyAI_horizontal_transparent_light-fg_640w.png)  
- **InsightfulAffiliate Horizontal Transparent Dark:**
  - [240w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bc006265a35_InsightfulAffiliate_horizontal_transparent_dark-fg_240w.png)  
  - [640w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bc0bd21be8b_InsightfulAffiliate_horizontal_transparent_dark-fg_640w.png)  
- **InsightfulAffiliate Horizontal Transparent Light:**
  - [480w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bd5a8896193_InsightfulAffiliate_horizontal_transparent_light-fg_480w.png)  
  - [640w](https://d1yei2z3i6k35z.cloudfront.net/13254463/68bc0bd220aed_InsightfulAffiliate_horizontal_transparent_light-fg_640w.png)  

### OG / Twitter Images
- **OG Default:**  
  [NextGenCopyAI Dark](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b7b43c6ac34_NextGenCopyAI_by_InsightfulAffiliate_og_dark_1200x630.png)  
- **Twitter Default:**  
  [NextGenCopyAI Dark](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b7b43c6961a_NextGenCopyAI_by_InsightfulAffiliate_twitter_dark_1200x628.png)  
- **NextGenCopyAI Light:**  
  - [OG](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b7cbd026195_NextGenCopyAI_by_InsightfulAffiliate_og_light_1200x630.png)  
  - [Twitter](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b7cbd026195_NextGenCopyAI_by_InsightfulAffiliate_twitter_light_1200x628.png)  
- **InsightfulAffiliate Light:**  
  - [OG](https://d1yei2z3i6k35z.cloudfront.net/13254463/68c25df1dc6f4_InsightfulAffiliate_og_light_1200x630.png)  
  - [Dark](https://d1yei2z3i6k35z.cloudfront.net/13254463/68c25df1c5160_InsightfulAffiliate_og_dark_1200x630.png)  

### ICO / Favicon
- **Favicon Dark:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b7b43c6aa85_favicon.ico)  
- **Favicon Light:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68c13281652cd_favicon_light.ico)  
- **Favicon 512x512 Dark:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68c115bc6ae32_favicon-512x512.png)  
- **Favicon 512x512 Light:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68c115930a4c4_favicon-512x512.png)  
- **Apple Touch Icon:**  
  [Download](https://d1yei2z3i6k35z.cloudfront.net/13254463/68b2b075f0945_apple-touch-icon.png)  

## Integration Steps (Systeme.io)
1. Go to **Media** and upload the images.
2. Click each file to copy its **public URL**.
3. Open `brand-head-include.html` and replace:
   - `CSS_ABSOLUTE_URL` with the URL for brand-ui.css #2
   - `OG_IMAGE_URL` with your `og_default.png` URL
   - `TWITTER_IMAGE_URL` with your `twitter_default.png` URL
   - `FAVICON_ICO_URL` with your .ico URL
   - `APPLE_TOUCH_ICON_URL` with your 180×180 PNG URL
   - `WEB_MANIFEST_URL` (optional) with your manifest URL if needed
4. Paste the contents of `brand-head-include.html` into each page’s **Settings → Edit header code**.
5. The default theme is dark in hero/thank-you blocks. For other pages, add `class="theme-dark"` to `<body>`.

## Tip
You don’t need `/icons/` folders in Systeme. Use the **public URLs** from Media to replace placeholder paths directly.