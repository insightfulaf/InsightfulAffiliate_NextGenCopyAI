# Copilot Instructions for InsightfulAffiliate_NextGenCopyAI

## Repository Overview

This repository contains AI-powered copywriting tools and affiliate marketing content for **InsightfulAffiliate** and **NextGenCopyAI** brands. It includes automated content generation scripts, landing pages, copywriting assets, and marketing materials focused on AI writing tools and affiliate marketing education.

## Key Technologies & Tools

- **Python 3**: Automation scripts using OpenAI API for content generation
- **HTML/CSS/JS**: Landing pages and web components for Systeme.io integration
- **Markdown**: Documentation, copywriting content, and AI-generated outputs
- **Git**: Version control with automated commits via Python scripts

## Repository Structure

```
├── assets/                    # Brand assets (logos, images, icons)
├── copywriting/              # Marketing copy and product pages
│   └── product_pages/        # AI affiliate launchpad content
├── docs/                     # Documentation and AI outputs
│   ├── ai_outputs/           # Generated content from AI agents
│   └── checklists/           # Process guides and workflows
├── landing_pages/            # HTML landing pages and components
├── prompts/                  # AI prompt templates for content generation
├── scripts/                  # Python automation tools
│   ├── agent_codex.py        # Main AI content generation agent
│   └── build_funnel_map.py   # Funnel mapping automation
└── website_code_block_ORGANIZED/ # Web components for Systeme.io
```

## Coding Standards & Best Practices

### Python Scripts

- **Follow existing patterns** in `scripts/agent_codex.py` for AI automation
- Use **type hints** and **dataclasses** for configuration objects
- Implement **proper error handling** with descriptive error messages
- Use **argparse** for CLI interfaces with helpful descriptions
- Support both **dry-run** and **live execution** modes
- **Log actions clearly** with verbose/quiet options
- Always use **atomic file operations** for safety

### Content Generation

- **Preserve existing file structure** and naming conventions
- Generate outputs to `docs/ai_outputs/` following established patterns
- Use **relative paths** for intra-repository references
- Keep **brand voice consistency** between InsightfulAffiliate (practical, transparent) and NextGenCopyAI (modern, tool-savvy)
- Include **paste-ready snippets** for Systeme.io integration

### HTML/CSS/JS

- **Maintain canonical CSS files** in `website_code_block_ORGANIZED/assets/`
- Use **relative paths** for all asset references
- Keep components **self-contained** for easy Systeme.io pasting
- Follow **mobile-first responsive design** principles
- Include **accessibility attributes** (alt text, ARIA labels)

### Git & Version Control

- Use **descriptive commit messages** following format: `type(scope): description`
- **Stage only relevant files** - avoid staging build artifacts or temporary files
- Follow the **automated commit patterns** used by existing scripts
- Preserve the **codex_scope.txt** file listing for asset tracking

## AI Integration Guidelines

### Prompt Engineering

- **Study existing prompts** in `prompts/` directory before creating new ones
- Maintain **consistent instruction format** with clear scope definitions
- Include **safety guardrails** and **editing constraints** in prompts
- Specify **output formats** explicitly (Markdown, HTML, etc.)
- **Test prompts** with the echo provider before using OpenAI

### Content Automation

- **Respect file exclusions** defined in scripts (skip .git, node_modules, etc.)
- **Preserve manual edits** - don't overwrite user modifications
- Generate **structured outputs** with clear section headers
- Include **usage notes** for generated code snippets
- **Validate HTML structure** and **check relative links** in generated content

## Brand & Content Guidelines

### Voice & Tone

- **InsightfulAffiliate**: Practical, transparent, beginner-friendly, low-hype educational content
- **NextGenCopyAI**: Modern, tool-savvy, prompt-driven with outcome-first examples

### Affiliate Links & Marketing

- **Always use proper affiliate tracking** with mapped URLs from `docs/affiliate_links/`
- Include **disclosure statements** for affiliate relationships
- **Test affiliate links** before publishing content
- Follow **FTC guidelines** for affiliate marketing disclosure

### Asset Management

- **Use consistent naming** for brand assets (dark/light variants)
- **Optimize images** for web delivery (appropriate file sizes)
- **Maintain favicon sets** for both brands
- **Update manifest files** when changing assets

## Development Workflow

1. **Understand the scope** - check `codex_scope.txt` for asset inventory
2. **Run existing scripts** with `--dry-run` first to preview changes
3. **Test locally** before committing automation changes
4. **Use incremental commits** for better tracking
5. **Validate outputs** in `docs/ai_outputs/` match expected formats
6. **Check links and paths** after any structural changes

## Special Considerations

- **Systeme.io Integration**: All HTML components should be paste-ready with minimal external dependencies
- **AI Model Costs**: Use `--provider echo` for testing, `openai` for production
- **Path Management**: Always use relative paths within the repository
- **Brand Consistency**: Maintain separate brand identities while sharing technical infrastructure
- **Content Updates**: Use the established AI agent workflow rather than manual editing

## Common Tasks

- **Generate new copywriting**: Use `scripts/agent_codex.py` with appropriate prompts
- **Update landing pages**: Modify templates in `website_code_block_ORGANIZED/`
- **Add new assets**: Follow naming conventions in `assets/` directory structure  
- **Create documentation**: Use Markdown with clear section headers in `docs/`
- **Maintain links**: Update mappings in `docs/affiliate_links/affiliate_links_mapping_FINAL.json`

When working in this repository, prioritize **brand consistency**, **automation-friendly patterns**, and **content that converts** for affiliate marketing success.