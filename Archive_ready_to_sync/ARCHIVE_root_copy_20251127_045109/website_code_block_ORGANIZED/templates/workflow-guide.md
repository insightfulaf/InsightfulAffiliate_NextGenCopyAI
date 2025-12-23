# Website Code Blocks - Quick Reference Guide

## 📁 Organized File Structure

```
website_code_block_ORGANIZED/
├── 📁 headers/
│   ├── head-snippet-v7-production.html    # Ready-to-use header (current content)
│   └── head-snippet-template.html         # Template with {{PLACEHOLDERS}}
├── 📁 hero-sections/
│   ├── ai-affiliate-launchpad.html        # AI Launchpad hero (ready-to-use)
│   └── hero-template.html                 # Template with {{PLACEHOLDERS}}
├── 📁 thank-you/
│   ├── ai-affiliate-launchpad-thank-you.html  # AI Launchpad thank-you
│   └── thank-you-template.html             # Template with {{PLACEHOLDERS}}
├── 📁 components/
│   ├── cta-slim-bar.html                   # Call-to-action bar
│   ├── guarantee-badge.html                # Money-back guarantee
│   ├── order-bump.html                     # Order bump section
│   └── faq-section.html                    # FAQ accordion
├── 📁 assets/
│   ├── ngcai.css                           # Canonical brand stylesheet
│   └── site.webmanifest                    # PWA manifest
└── 📁 templates/
    └── workflow-guide.md                   # This file
```

## 🚀 New Streamlined Workflow

### Old Process (5 steps):
1. Finder → Right-click file → Open in Markdown app
2. Menu → Publish → Copy HTML
3. Systeme.io → Settings/Raw HTML Block
4. Paste HTML → Save

### New Process (3 steps):
1. **Finder** → Double-click .html file (opens in browser/text editor)
2. **Select All** (Cmd+A) → **Copy** (Cmd+C)
3. **Systeme.io** → Paste directly → Save

## 📋 How to Use Each Component

### Headers (Head Snippets)
**Location in Systeme.io:** Funnel Page → Settings → Edit Header
- Use `head-snippet-v7-production.html` for AI Affiliate Launchpad
- Use `head-snippet-template.html` for new pages (replace {{PLACEHOLDERS}})

### Hero Sections
**Location in Systeme.io:** Page → Insert Raw HTML Block
- Use `ai-affiliate-launchpad.html` for current opt-in
- Use `hero-template.html` for new pages (replace {{PLACEHOLDERS}})

### Thank You Blocks  
**Location in Systeme.io:** Thank-you Page → Insert Raw HTML Block
- Use `ai-affiliate-launchpad-thank-you.html` for current funnel
- Use `thank-you-template.html` for new pages

### Small Components
**Location in Systeme.io:** Any Page → Insert Raw HTML Block
- `cta-slim-bar.html` - Inline call-to-action
- `guarantee-badge.html` - Money-back guarantee badge  
- `order-bump.html` - Upsell/cross-sell section
- `faq-section.html` - Collapsible FAQ section

## 🎯 Template Placeholder System

All templates use `{{PLACEHOLDER_NAME}}` format for easy find/replace:

### Common Placeholders:
- `{{PAGE_TITLE}}` - Your page title (50-60 chars ideal)
- `{{PAGE_DESCRIPTION}}` - Meta description (150-160 chars ideal) 
- `{{CANONICAL_URL}}` - Full URL to the page
- `{{BASE_URL}}` - Your domain (e.g., https://www.yourdomain.com)

### Quick Replace Method:
1. Copy template file content
2. Use Find/Replace (Cmd+F) to replace all {{PLACEHOLDERS}}
3. Save as new file or paste directly to Systeme.io

## ✅ What's Fixed/Improved:

### Header Issues Resolved:
- ✅ Fixed malformed HTML comments (`<!—` → `<!--`)
- ✅ Consistent placeholder format (`{{}}` instead of `[[]]`)
- ✅ Proper font loading optimization
- ✅ Complete meta tag structure
- ✅ Added structured data for SEO

### Code Quality Improvements:
- ✅ Self-contained CSS in each component
- ✅ Responsive design for all screen sizes
- ✅ Hover effects and smooth transitions
- ✅ Consistent brand colors and typography
- ✅ Semantic HTML structure
- ✅ Accessibility improvements

### File Organization:
- ✅ Clear naming convention (kebab-case)
- ✅ Logical folder structure
- ✅ Eliminated duplicate files
- ✅ Ready-to-use + template versions
- ✅ All files are .html (no more .md conversions needed)

## 🛠️ Quick Testing Checklist:

Before uploading to Systeme.io:
1. Open .html file in browser - does it display correctly?
2. Check responsive design (resize browser window)
3. Verify all links work
4. Confirm colors match your brand
5. Test buttons and interactive elements

## 📞 Need Customizations?

To modify components:
1. Copy the existing .html file
2. Edit the CSS in the `<style>` section
3. Update HTML content as needed
4. Test in browser before uploading
5. Save with descriptive filename

## 🏆 Pro Tips:

- **Backup First**: Keep your old folder as backup until you're comfortable with the new system
- **Browser Bookmarks**: Bookmark your most-used files for quick access
- **Version Control**: When making changes, save new versions with v2, v3, etc.
- **Quick Edits**: For small text changes, you can edit directly in Systeme.io's HTML editor

---

## 📁 File Migration Status:

Your original files are safely preserved. The new organized files are:
- ✅ Cleaned and optimized
- ✅ Ready for direct copy/paste to Systeme.io  
- ✅ No more Markdown app dependency
- ✅ Consistent branding and quality

**Next Step**: Test the new workflow with one file, then gradually transition to the new system!
