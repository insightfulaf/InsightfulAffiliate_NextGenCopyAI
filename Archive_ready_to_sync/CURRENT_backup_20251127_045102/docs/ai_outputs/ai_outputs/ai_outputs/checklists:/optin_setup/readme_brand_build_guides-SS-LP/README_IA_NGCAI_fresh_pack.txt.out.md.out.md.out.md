## Notes
This document outlines the steps for setting up the IA + NGCAI Fresh Pack, emphasizing key technical details.

## IA + NGCAI Fresh Pack Setup

### Date: 2025-09-01

1. **Upload Assets**
   - Go to **Systeme -> Media**.
   - Upload images and `brand-ui.css`.
   - Copy the public URLs for each asset.

2. **Edit Header Code**
   - Navigate to **Page Settings**.
   - Open `brand-head-include.html` and update the following placeholders:
     - `FAVICON_ICO_URL`: Your favicon `.ico` URL.
     - `APPLE_TOUCH_ICON_URL`: 180x180 PNG URL.
     - `MASKABLE_ICON_URL`: Optional 512x512 PNG URL.
     - `OG_IMAGE_URL`: Use `ngcai og_dark_1200x630` or `og_light_1200x630`.
     - `TWITTER_IMAGE_URL`: Use `twitter_dark_1200x628` or `twitter_light_1200x628`.
     - `CSS_ABSOLUTE_URL`: URL for `brand-ui.css`.
     - `CANONICAL_URL`: Set for each page.

3. **Opt-in Page Setup**
   - Access the **/optin page**.
   - Add Custom HTML and insert `hero_block.html`.
   - Replace `ICON_URL` with your square icon URL.

4. **Thank You Page Setup**
   - Go to the **/thank-you page**.
   - Add Custom HTML and insert `thank_you_block.html`.

5. **Blog Posts**
   - Add `post_rytr_vs_koala_2025.md` and `post_best_budget_ai_writers_2025.md`.
   - Include the corresponding JSON-LD files in the page HTML.

6. **Optional Shortlinks**
   - Create shortlinks for:
     - `/go/systeme`
     - `/go/rytr`
     - `/go/koala`
   - Ensure these redirect to your affiliate URLs.