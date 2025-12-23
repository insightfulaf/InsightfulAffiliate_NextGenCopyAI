# Current State Report

Date: 2025-11-19

This report summarizes the current repository layout, duplicate file situations between the repo root and the `CURRENT/` subfolder, the Python environment status, and an analysis of the pytest "Import file mismatch" error.

## 1. Project Structure

Text-based tree focusing on the relationship between repository root (`.`) and `CURRENT/`.

Root (.) top-level

```
Archive_ready_to_sync/
COMPLETION_SUMMARY.md
CURRENT/
CURRENT_STATE_REPORT.md
InsightfulAffiliate_NextGenCopyAI/
PR1_INSTRUCTIONS.md
PR1_REVIEW_GUIDE.md
Prompt_to_Profit_Playbook_Pack_2025/
README.md
assets/
codex_out/
codex_scope.txt
copywriting/
docs/
eval "$(ssh-agent -s)"
eval "$(ssh-agent -s)".pub
init_git_url.sh
javascripts/
landing_pages/
logs/
prompts/
pytest.ini
scripts/
tests/
website_code_block_ORGANIZED/
```

`CURRENT/` immediate children

```
COMPLETION_SUMMARY.md
PR1_INSTRUCTIONS.md
PR1_REVIEW_GUIDE.md
Prompt_to_Profit_Playbook_Pack_2025/
README.md
REVIEW_PENDING/
assets/
codex_scope.txt
configs/
copywriting/
docs/
eval "$(ssh-agent -s)"
eval "$(ssh-agent -s)".pub
init_git_url.sh
landing_pages/
prompts/
pytest.ini
scripts/
tests/
website_code_block_ORGANIZED/
```

`CURRENT/` key subfolders (depth 2 sample)

```
CURRENT/
  copywriting/
    product_pages/
  landing_pages/
    link-hub/
    assest_2/
    FAQs/
    headers/
  tests/
    __pycache__/
  REVIEW_PENDING/
  docs/
    checklists:/
    ai_outputs/
    checklists/
    affiliate_links/
    systeme_asset_tracking/
    reference/
  configs/
    brands/
  .venv/
    bin/
    include/
    lib/
  scripts/
  prompts/
    prompts/
  Prompt_to_Profit_Playbook_Pack_2025/
    license/
    sales/
    email-launch/
    prompts/
    templates/
    jsonld/
  .vscode/
  assets/
    css/
    images/
    icons/
    downloads/
  website_code_block_ORGANIZED/
    thank-you/
    components/
    headers/
    templates/
    manifests/
    hero-sections/
    assets/
```

Observation: The `CURRENT/` folder mirrors many files/directories present at the repository root, including configuration (`pytest.ini`), documentation, assets, prompts, and tests. This nested duplication is a candidate cause for tooling confusion.

## 2. Duplicate Detection (root vs CURRENT)

Method: Compared files by relative path between repo root (`.`) and `CURRENT/` using SHA-256 content hashes, excluding bulky/derived folders: `.git`, `.venv`, `node_modules`, `dist`, `build`, `docs/ai_outputs`, `codex_out`, `.vscode`, `__pycache__`.

- Total identical files: 277
- Example: `tests/test_hello.py` is identical in both locations.

Full list (sorted; truncated none):

```
TOTAL_DUPLICATES=277
.connection-check.txt
.editorconfig
.gitattributes
.github/copilot-instructions.md
.gitkeep
COMPLETION_SUMMARY.md
PR1_INSTRUCTIONS.md
PR1_REVIEW_GUIDE.md
Prompt_to_Profit_Playbook_Pack_2025/Deliverability_Checklist_PPP.md
Prompt_to_Profit_Playbook_Pack_2025/IMPLEMENTATION_Checklist_PPP.md
Prompt_to_Profit_Playbook_Pack_2025/README_Master_Guide_PPP.md
Prompt_to_Profit_Playbook_Pack_2025/SEO_Checklist_PPP.md
Prompt_to_Profit_Playbook_Pack_2025/email-launch/01-announce.md
Prompt_to_Profit_Playbook_Pack_2025/email-launch/02-inside-tour.md
Prompt_to_Profit_Playbook_Pack_2025/email-launch/03-proof-miniwin.md
Prompt_to_Profit_Playbook_Pack_2025/email-launch/04-objections.md
Prompt_to_Profit_Playbook_Pack_2025/email-launch/05-last-call.md
Prompt_to_Profit_Playbook_Pack_2025/jsonld/faq.jsonld
Prompt_to_Profit_Playbook_Pack_2025/jsonld/product.jsonld
Prompt_to_Profit_Playbook_Pack_2025/license/terms.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/bloggers/prompts.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/bloggers/sops.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/bloggers/workflows.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/course_info/prompts.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/course_info/sops.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/course_info/workflows.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/ecom/prompts.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/ecom/sops.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/ecom/workflows.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/hooks.md
Prompt_to_Profit_Playbook_Pack_2025/prompts/shortform-scripts.md
Prompt_to_Profit_Playbook_Pack_2025/sales/FAQ_block_PPP.html
Prompt_to_Profit_Playbook_Pack_2025/sales/benefits-block.html
Prompt_to_Profit_Playbook_Pack_2025/sales/cta-slim-bar.html
Prompt_to_Profit_Playbook_Pack_2025/sales/guarantee-badge.html
Prompt_to_Profit_Playbook_Pack_2025/sales/hero-block.html
Prompt_to_Profit_Playbook_Pack_2025/sales/orderbump-snippet.html
Prompt_to_Profit_Playbook_Pack_2025/sales/pricing-block.html
Prompt_to_Profit_Playbook_Pack_2025/sales/testimonials-cards.html
Prompt_to_Profit_Playbook_Pack_2025/templates/campaign_planner.csv
Prompt_to_Profit_Playbook_Pack_2025/templates/editorial_calendar.csv
Prompt_to_Profit_Playbook_Pack_2025/templates/personal_brand_content_bank.md
Prompt_to_Profit_Playbook_Pack_2025/templates/pricing_grid.csv
assets/downloads/AI Copywriting Starter Kit/NextGenCopyAI_Daily_Checklist_v2.md
assets/downloads/AI Copywriting Starter Kit/NextGenCopyAI_Daily_Checklist_v2.pdf
assets/downloads/AI Copywriting Starter Kit/NextGenCopyAI_Master_Guide_2025_v2.md
assets/downloads/AI Copywriting Starter Kit/NextGenCopyAI_Master_Guide_2025_v2.pdf
assets/icons/ico/favicon.ico
assets/icons/ico/favicon_dark.ico
assets/icons/ico/favicon_dk.ico
assets/icons/ico/favicon_light.ico
assets/icons/svg/Endorsed_NextGenCopyAI_by_InsightfulAffiliate_dark.svg
assets/icons/svg/Endorsed_NextGenCopyAI_by_InsightfulAffiliate_light.svg
assets/icons/svg/InsightfulAffiliate_logo_horizontal_dark.svg
assets/icons/svg/InsightfulAffiliate_logo_horizontal_light.svg
assets/icons/svg/neuro-pen-icon_dark.svg
assets/icons/svg/neuro-pen-icon_light.svg
assets/images/avatars/avatar_dark_1024x1024.png
assets/images/avatars/avatar_dark_512x512.png
assets/images/avatars/avatar_light_1024x1024.png
assets/images/avatars/avatar_light_512x512.png
assets/images/business_headshots_2025/*Headshot 2025.png
assets/images/headers/InsightfulAffiliate/bg-dark/InsightfulAffiliate_horizontal_dark_240w.png
assets/images/headers/InsightfulAffiliate/bg-dark/InsightfulAffiliate_horizontal_dark_320w.png
assets/images/headers/InsightfulAffiliate/bg-dark/InsightfulAffiliate_horizontal_dark_480w.png
assets/images/headers/InsightfulAffiliate/bg-dark/InsightfulAffiliate_horizontal_dark_640w.png
assets/images/headers/InsightfulAffiliate/bg-light/InsightfulAffiliate_horizontal_light_240w.png
assets/images/headers/InsightfulAffiliate/bg-light/InsightfulAffiliate_horizontal_light_320w.png
assets/images/headers/InsightfulAffiliate/bg-light/InsightfulAffiliate_horizontal_light_480w.png
assets/images/headers/InsightfulAffiliate/bg-light/InsightfulAffiliate_horizontal_light_640w.png
assets/images/headers/InsightfulAffiliate/transparent-dark-fg/InsightfulAffiliate_horizontal_transparent_dark-fg_240w.png
assets/images/headers/InsightfulAffiliate/transparent-dark-fg/InsightfulAffiliate_horizontal_transparent_dark-fg_320w.png
assets/images/headers/InsightfulAffiliate/transparent-dark-fg/InsightfulAffiliate_horizontal_transparent_dark-fg_480w.png
assets/images/headers/InsightfulAffiliate/transparent-dark-fg/InsightfulAffiliate_horizontal_transparent_dark-fg_640w.png
assets/images/headers/InsightfulAffiliate/transparent-light-fg/InsightfulAffiliate_horizontal_transparent_light-fg_240w.png
assets/images/headers/InsightfulAffiliate/transparent-light-fg/InsightfulAffiliate_horizontal_transparent_light-fg_320w.png
assets/images/headers/InsightfulAffiliate/transparent-light-fg/InsightfulAffiliate_horizontal_transparent_light-fg_480w.png
assets/images/headers/InsightfulAffiliate/transparent-light-fg/InsightfulAffiliate_horizontal_transparent_light-fg_640w.png
assets/images/headers/NextGenCopyAI/bg-dark/NextGenCopyAI_horizontal_dark_240w.png
assets/images/headers/NextGenCopyAI/bg-dark/NextGenCopyAI_horizontal_dark_320w.png
assets/images/headers/NextGenCopyAI/bg-dark/NextGenCopyAI_horizontal_dark_480w.png
assets/images/headers/NextGenCopyAI/bg-dark/NextGenCopyAI_horizontal_dark_640w.png
assets/images/headers/NextGenCopyAI/bg-light/NextGenCopyAI_horizontal_light_240w.png
assets/images/headers/NextGenCopyAI/bg-light/NextGenCopyAI_horizontal_light_320w.png
assets/images/headers/NextGenCopyAI/bg-light/NextGenCopyAI_horizontal_light_480w.png
assets/images/headers/NextGenCopyAI/bg-light/NextGenCopyAI_horizontal_light_640w.png
assets/images/headers/NextGenCopyAI/transparent-dark-fg/NextGenCopyAI_horizontal_transparent_dark-fg_240w.png
assets/images/headers/NextGenCopyAI/transparent-dark-fg/NextGenCopyAI_horizontal_transparent_dark-fg_320w.png
assets/images/headers/NextGenCopyAI/transparent-dark-fg/NextGenCopyAI_horizontal_transparent_dark-fg_480w.png
assets/images/headers/NextGenCopyAI/transparent-dark-fg/NextGenCopyAI_horizontal_transparent_dark-fg_640w.png
assets/images/headers/NextGenCopyAI/transparent-light-fg/NextGenCopyAI_horizontal_transparent_light-fg_240w.png
assets/images/headers/NextGenCopyAI/transparent-light-fg/NextGenCopyAI_horizontal_transparent_light-fg_320w.png
assets/images/headers/NextGenCopyAI/transparent-light-fg/NextGenCopyAI_horizontal_transparent_light-fg_480w.png
assets/images/headers/NextGenCopyAI/transparent-light-fg/NextGenCopyAI_horizontal_transparent_light-fg_640w.png
assets/images/icon_dark/apple-touch-icon.png
assets/images/icon_dark/favicon-16x16.png
assets/images/icon_dark/favicon-180x180.png
assets/images/icon_dark/favicon-256x256.png
assets/images/icon_dark/favicon-32x32.png
assets/images/icon_dark/favicon-384x384.png
assets/images/icon_dark/favicon-48x48.png
assets/images/icon_dark/favicon-64x64.png
assets/images/icon_dark/icon-192.png
assets/images/icon_dark/icon-512.png
assets/images/icon_dark/maskable-512x512.png
assets/images/icon_light/favicon-16x16.png
assets/images/icon_light/favicon-180x180.png
assets/images/icon_light/favicon-192x192.png
assets/images/icon_light/favicon-256x256.png
assets/images/icon_light/favicon-32x32.png
assets/images/icon_light/favicon-384x384.png
assets/images/icon_light/favicon-48x48.png
assets/images/icon_light/favicon-512x512.png
assets/images/icon_light/favicon-64x64.png
assets/images/icon_light/maskable-512x512.png
assets/images/social/InsightfulAffiliate_og-default.png
assets/images/social/InsightfulAffiliate_og_light_1200x630.png
assets/images/social/InsightfulAffiliate_twitter-default.png
assets/images/social/InsightfulAffiliate_twitter_light_1200x628.png
assets/images/social/NextGenCopyAI_by_InsightfulAffiliate_og_light_1200x630.png
assets/images/social/NextGenCopyAI_by_InsightfulAffiliate_twitter_light_1200x628.png
assets/images/social/NextGenCopyAI_og_dark_1200x630.png
assets/images/social/NextGenCopyAI_og_light_1200x630.png
assets/images/social/NextGenCopyAI_twitter_dark_1200x628.png
assets/images/social/NextGenCopyAI_twitter_light_1200x628.png
assets/images/social/og-default.png
assets/images/social/twitter-default.png
assets/images/square/InsightfulAffiliate_square_dark_1080x1080.png
assets/images/square/InsightfulAffiliate_square_light_1080x1080.png
assets/images/square/NextGenCopyAI_by_InsightfulAffiliate_square_dark_1080x1080.png
assets/images/square/NextGenCopyAI_by_InsightfulAffiliate_square_light_1080x1080.png
assets/images/square/NextGenCopyAI_square_dark_1080x1080.png
assets/images/square/NextGenCopyAI_square_light_1080x1080.png
assets/images/transparent/InsightfulAffiliate_horizontal_transparent_dark-fg_320w.png
assets/images/transparent/InsightfulAffiliate_horizontal_transparent_dark-fg_480w.png
assets/images/transparent/InsightfulAffiliate_horizontal_transparent_dark-fg_640w.png
assets/images/transparent/InsightfulAffiliate_horizontal_transparent_light-fg_320w.png
assets/images/transparent/InsightfulAffiliate_horizontal_transparent_light-fg_480w.png
assets/images/transparent/InsightfulAffiliate_horizontal_transparent_light-fg_640w.png
assets/images/transparent/NextGenCopyAI_horizontal_transparent_dark-fg_320w.png
assets/images/transparent/NextGenCopyAI_horizontal_transparent_dark-fg_480w.png
assets/images/transparent/NextGenCopyAI_horizontal_transparent_dark-fg_640w.png
assets/images/transparent/NextGenCopyAI_horizontal_transparent_light-fg_320w.png
assets/images/transparent/NextGenCopyAI_horizontal_transparent_light-fg_480w.png
assets/images/transparent/NextGenCopyAI_horizontal_transparent_light-fg_640w.png
codex_scope.txt
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V1-Blog_FAQ_and_Banners/featured_image_banner_text_V1.md
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V1-Blog_FAQ_and_Banners/post1_rytr_vs_koalawriter_faq_V1.jsonld
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V1-Blog_FAQ_and_Banners/post2_best_budget_writers_faq_V1.jsonld
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V2-Blog_FAQ_and_Banners/featured_image_banner_textV1.md
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V2-Blog_FAQ_and_Banners/featured_image_banner_textV2.md
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V2-Blog_FAQ_and_Banners/post1_rytr_vs_koala_faq.jsonld
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/V2-Blog_FAQ_and_Banners/post2_best_budget_faq.jsonld
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/featured_image_banner_text_V1-8.32.03PM.md
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/post_best_budget_ai_writers_2025.md
copywriting/product_pages/AI_Af_Launchpad-Prompts_to_Profit_Playbook/post_rytr_vs_koala_2025.md
copywriting/product_pages/≡ƒô¥ 20-Post Content Plan (AI Copywriting & Content) - Sheet1.csv
docs/affiliate_links/aff_link_mapping/affiliate_links_mapping_FINAL.json
docs/ai_outputs/_snippets/head-snippet-v7-production.html.out.md
docs/ai_outputs/_snippets/hero-sections-ai-affiliate-launchpad.html.out.md
docs/ai_outputs/_snippets/thank-you-ai-affiliate-launchpad-thank-you.html.out.md
docs/ai_outputs/affiliate_links/aff_link_mapping/affiliate_links_mapping_FINAL.json.out.md
docs/ai_outputs/ai_outputs/affiliate_links/aff_link_mapping/affiliate_links_mapping_FINAL.json.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/affiliate_links/aff_link_mapping/affiliate_links_mapping_FINAL.json.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/ai_outputs/systeme_asset_tracking/Sheet1.html.errors.txt.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists/git-quickstart.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists/vscode-setup.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/daily_execution/Optimized_Website_Code_Blocks.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/copy_pack.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/featured_image_banner_text.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post_best_budget_ai_writers_2025.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post_rytr_vs_koala_2025.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Koala_Slot_In_Kit.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_Profit-Playbook_reference .md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_and_Playbooks_Copy_InsightfulAffiliate_NextGenCopyAI.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_and_Playbooks_WITH_Koala_Locked.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Button_NextStep.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Button_NextStepp-aial.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_IA_NGCAI_fresh_pack.txt.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Master_Guide_io-starter_stack.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/master-guide-AI_Affiliate_Launchpad_Systeme_Starter_Stack-final.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/systeme_asset_tracking/Asset_URL's_Systeme.md.out.md.out.md.out.md
docs/ai_outputs/ai_outputs/ai_outputs/systeme_asset_tracking/Sheet1.html.errors.txt.out.md.out.md
docs/ai_outputs/ai_outputs/checklists/git-quickstart.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists/vscode-setup.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/daily_execution/Optimized_Website_Code_Blocks.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/copy_pack.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/featured_image_banner_text.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post_best_budget_ai_writers_2025.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post_rytr_vs_koala_2025.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Koala_Slot_In_Kit.md.out.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_Profit-Playbook_reference .md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_and_Playbooks_Copy_InsightfulAffiliate_NextGenCopyAI.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_and_Playbooks_WITH_Koala_Locked.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Button_NextStep.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Button_NextStepp-aial.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_IA_NGCAI_fresh_pack.txt.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Master_Guide_io-starter_stack.md.out.md
docs/ai_outputs/ai_outputs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/master-guide-AI_Affiliate_Launchpad_Systeme_Starter_Stack-final.md.out.md
docs/ai_outputs/systeme_asset_tracking/Sheet1.html.errors.txt
docs/checklists/funnel_map.md
docs/checklists/git-quickstart.md
docs/checklists/pre_publish.md
docs/checklists/vscode-setup
docs/checklists/vscode-setup.md
docs/checklists:/daily_execution/Optimized_Website_Code_Blocks.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/copy_pack.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/featured_image_banner_text.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post1_rytr_vs_koala_faq.jsonld
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post2_best_budget_faq.jsonld
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post_best_budget_ai_writers_2025.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/IA_NGCAI_fresh_pack/post_rytr_vs_koala_2025.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Koala_Slot_In_Kit.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_Profit-Playbook_reference .md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_and_Playbooks_Copy_InsightfulAffiliate_NextGenCopyAI.md
docs/checklists:/optin_setup/Launchpad_and_Playbooks_V1-V2/Launchpad_and_Playbooks_WITH_Koala_Locked.md
docs/checklists:/optin_setup/brand guides/BRAND SYSTEM(s)-InsightfulAffiliate NextGenCopyAI .pdf
docs/checklists:/optin_setup/brand guides/The brand system-InsightfulAffiliate NextGenCopyAI .pdf
docs/checklists:/optin_setup/brand guides/metadata input [[PLACEHOLDER]] tables - AI Affiliate Launchpad.csv
docs/checklists:/optin_setup/brand guides/metadata input [[PLACEHOLDER]] tables - Prompt-to-Profit Playbook.csv
docs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/IA+NGCAI_fresh-pack_z.rtf
docs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Button_NextStep.md
docs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Button_NextStepp-aial.md
docs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_IA_NGCAI_fresh_pack.txt
docs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/README_Master_Guide_io-starter_stack.md
docs/checklists:/optin_setup/readme_brand_build_guides-SS-LP/master-guide-AI_Affiliate_Launchpad_Systeme_Starter_Stack-final.md
docs/systeme_asset_tracking/Asset_URL's_Systeme.md
docs/systeme_asset_tracking/Asset_URL's_Systeme.odt
docs/systeme_asset_tracking/Asset_URL's_Systeme.pdf
docs/systeme_asset_tracking/Asset_URL_tracker-Systeme-icons/resources/sheet.css
docs/systeme_asset_tracking/asset_url_tracker.md
docs/systeme_asset_tracking/icon-tracker_URL's_Systeme.md
docs/systeme_asset_tracking/systemeio_hosted_icons.txt
eval "$(ssh-agent -s)".pub
init_git_url.sh
landing_pages/FAQs/FAQ_AI-LPad.md
landing_pages/FAQs/FAQ_block_PPP.html
landing_pages/component-library.html
landing_pages/headers/head-snippet-ngcai.html
landing_pages/headers/head-snippet-template.html
landing_pages/link-hub/go-link-hub.html
prompts/prompts/rewrite_to_house_style.txt/Role: rewriting agent. Goal: rewrite the provided content to my brand voice: concise, friendly, no hype. Output: VALID Markdown. Use H2/H3 headings, bullet lists, and short paragraphs. If input is HTML/CSS/JS, keep structure and add a brief top section "## Notes". Avoid marketing fluff. Keep technical details intact.
prompts/rewrite_to_house_style.txt
pytest.ini
scripts/agent_codex.py.bak
scripts/build_funnel_map.py
tests/test_hello.py
website_code_block_ORGANIZED/assets/ngcai.css
website_code_block_ORGANIZED/components/cta-slim-bar.html
website_code_block_ORGANIZED/components/faq-section.html
website_code_block_ORGANIZED/components/guarantee-badge.html
website_code_block_ORGANIZED/components/order-bump.html
website_code_block_ORGANIZED/headers/head-snippet-v7-production.html
website_code_block_ORGANIZED/hero-sections/ai-affiliate-launchpad.html
website_code_block_ORGANIZED/hero-sections/hero-template.html
website_code_block_ORGANIZED/site.webmanifest
website_code_block_ORGANIZED/templates/workflow-guide.md
website_code_block_ORGANIZED/thank-you/ai-affiliate-launchpad-thank-you.html
website_code_block_ORGANIZED/thank-you/thank-you-template.html
```

Notes:

- Many duplicates are binary assets (images, icons), documentation, and generated outputs. The presence of `pytest.ini`, `tests/test_hello.py`, and other code/config files in both locations is particularly relevant to tooling.

## 3. Environment Status

- Python version: `Python 3.13.7`
- pip freeze summary:
  - Total packages: 1
  - Sample/top entries:
    - `wheel==0.45.1`

`pytest.ini` (repo root):

```
[pytest]
testpaths = tests
markers =
    smoke: mark test as smoke test
    regression: mark test as regression test
```

## 4. Error Analysis: pytest "Import file mismatch"

Finding: The nested duplicate repository structure (root and `CURRENT/` each containing mirrored code, configs, and tests) is a likely cause of pytest's "Import file mismatch" errors.

Why this happens:

- Pytest collects tests from multiple roots. With identical files under `./tests/` and `./CURRENT/tests/`, modules can be imported from one path while the collector references the other path. This yields differing absolute file paths for the same module name, triggering the mismatch error when pytest compares "imported from" vs "collected at".
- Having multiple `pytest.ini` files with the same `testpaths` exacerbates ambiguous discovery roots.
- A local virtualenv inside `CURRENT/.venv/` can alter `sys.path` resolution when working dir changes between root and `CURRENT`, further increasing path ambiguity.

How to confirm:

- Run `pytest -q` from repo root and from `CURRENT/` separately, and compare any mismatch errors. If they reference the same module name but different physical paths (root vs `CURRENT`), this is the culprit.
- Temporarily move or rename one of the duplicate trees (e.g., `CURRENT/tests` → `CURRENT/tests.bak`) and re-run pytest; mismatch should disappear.

Recommended remediation for the Senior AI Architect:

- Choose a single project root. Remove or archive duplicated code/configs so there is only one canonical `tests/`, `scripts/`, and `pytest.ini`.
- If `CURRENT/` is to remain, treat it as a workspace scratch area that excludes code/config duplicates and contains only ephemeral artifacts (e.g., outputs). Add a `.gitignore` and adjust tools to not scan it.
- Alternatively, convert `CURRENT/` into a dedicated sandbox repository (separate checkout) instead of nesting it within this repo.
- Keep only one `pytest.ini` at the canonical root; ensure `testpaths = tests` refers to exactly one directory.
- Ensure developers run tooling (pytest, linters, scripts) from the same repo root and remove `.venv` from nested locations or standardize on a top-level `.venv`.

Conclusion: Yes — the "Import file mismatch" error is consistent with and very likely caused by the duplicated repository layout (`./` and `./CURRENT/`) containing identical modules and tests. Consolidating to a single source of truth will resolve the mismatch and simplify future refactoring.
