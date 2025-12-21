# Pre-publish Checklist (Systeme + NGCAI)

## Technical
- [ ] `ngcai.css` loads (Network 200 OK; MIME `text/css`)
- [ ] `site.webmanifest` loads (Network 200 OK; MIME `application/manifest+json`)
- [ ] No 404s; Console free of red errors (MIME/CORS/CSP)
- [ ] `<link rel="canonical">` points to final URL
- [ ] OG/Twitter share image is 1200×630 and returns 200 OK

## Content & UX
- [ ] One H1; clear H2/H3 outline
- [ ] Buttons/CTAs link to correct next step
- [ ] Forms submit and route to the thank-you page
- [ ] Mobile view looks good; tap targets OK

## Analytics (if used)
- [ ] GA/Tag Manager/Pixel present and firing on key events
- [ ] UTM parameters preserved across steps

## Performance (quick)
- [ ] No accidental multi-MB images
- [ ] Lighthouse SEO has no critical warnings
