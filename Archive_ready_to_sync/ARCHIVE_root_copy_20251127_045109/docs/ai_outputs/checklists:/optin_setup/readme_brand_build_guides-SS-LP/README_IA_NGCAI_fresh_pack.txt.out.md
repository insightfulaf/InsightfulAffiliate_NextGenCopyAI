## Notes
This document provides a straightforward guide for setting up the IA + NGCAI Fresh Pack. The instructions are clear and concise, focusing on the necessary steps without unnecessary embellishments.

## IA + NGCAI Fresh Pack Setup

### Date: 2025-09-01

1. **Upload Assets**
   - Go to **Systeme -> Media**.
   - Upload your images and `brand-ui.css`.
   - Copy the public URLs of the uploaded files.

2. **Edit Page Settings**
   - Navigate to **Page Settings -> Edit header code**.
   - Open `brand-head-include.html` and replace the placeholders:
     - `FAVICON_ICO_URL`: Your favicon `.ico` URL.
     - `APPLE_TOUCH_ICON_URL`: 180x180 PNG URL.
     - `MASKABLE_ICON_URL`: Optional maskable 512x512 PNG URL.
     - `OG_IMAGE_URL`: Default OG image URL (use `ngcai og_dark_1200x630` or `og_light_1200x630`).
     - `TWITTER_IMAGE_URL`: Twitter card image URL (use `twitter_dark_1200x628` or `twitter_light_1200x628`).
     - `CSS_ABSOLUTE_URL`: URL of the uploaded `brand-ui.css`.
     - `CANONICAL_URL`: Set this for each page.

3. **Opt-in Page Setup**
   - For the **/optin page**, add Custom HTML.
   - Paste `hero_block.html` and replace `ICON_URL` with your square icon URL.

4. **Thank You Page Setup**
   - For the **/thank-you page**, add Custom HTML.
   - Paste `thank_you_block.html`.

5. **Blog Setup**
   - Paste `post_rytr_vs_koala_2025.md` and `post_best_budget_ai_writers_2025.md`.
   - Add the corresponding JSON-LD files to the page HTML.

6. **Optional Shortlinks**
   - Create shortlinks:
     - `/go/systeme`
     - `/go/rytr`
     - `/go/koala`
   - Ensure these redirect to your affiliate URLs.