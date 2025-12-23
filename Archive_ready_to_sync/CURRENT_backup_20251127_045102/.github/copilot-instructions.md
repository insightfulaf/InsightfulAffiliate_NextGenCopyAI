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
├── copywriting/               # Marketing copy and product pages
│   └── product_pages/         # AI affiliate launchpad content
├── docs/                      # Documentation and AI outputs
│   ├── ai_outputs/            # Generated content from AI agents
│   └── checklists/            # Process guides and workflows
├── landing_pages/             # HTML landing pages and components
├── prompts/                   # AI prompt templates for content generation
├── scripts/                   # Python automation tools
│   ├── agent_codex.py         # Main AI content generation agent
│   └── build_funnel_map.py    # Funnel mapping automation
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

### Configuration Example

Use this reference implementation when you need environment-driven AI configuration with preview gating and fallback support. Keep the code in your Python modules (for example, `scripts/agent_codex.py`) and import it where needed.

```python
from dataclasses import dataclass
from typing import Any, Dict, List
import logging
import os


@dataclass
class AIConfig:
    provider: str = "openai"
    model: str = "gpt-4o-mini"
    enable_preview: bool = False
    fallback_model: str = "gpt-4o-mini"


def build_ai_config(args) -> AIConfig:
    default_model = os.getenv("AI_DEFAULT_MODEL", AIConfig.model)
    enable_preview_env = os.getenv("AI_ENABLE_PREVIEW", "false").lower() == "true"
    fallback_model = os.getenv("AI_FALLBACK_MODEL", AIConfig.fallback_model)
    provider = getattr(args, "provider", os.getenv("AI_PROVIDER", AIConfig.provider))

    return AIConfig(
        provider=provider,
        model=getattr(args, "model", default_model),
        enable_preview=getattr(args, "enable_preview", enable_preview_env),
        fallback_model=getattr(args, "fallback_model", fallback_model),
    )


def resolve_model(config: AIConfig) -> str:
    requested = config.model
    is_preview = any(marker in requested.lower() for marker in ("gpt-5", "codex"))
    if is_preview and not config.enable_preview:
        logging.warning(
            "Preview model '%s' requested but preview access is disabled; using fallback '%s'.",
            requested,
            config.fallback_model,
        )
        return config.fallback_model
    return requested


def _call_legacy_openai(model: str, messages: List[Dict[str, str]]) -> Any:
    import openai as legacy_openai  # type: ignore

    legacy_openai.api_key = os.getenv("OPENAI_API_KEY", "")
    return legacy_openai.ChatCompletion.create(model=model, messages=messages)


def call_llm(messages: List[Dict[str, str]], config: AIConfig) -> Any:
    model = resolve_model(config)

    try:
        if config.provider == "openai":
            try:
                from openai import OpenAI
            except ModuleNotFoundError:
                return _call_legacy_openai(model, messages)

            client = OpenAI()
            return client.chat.completions.create(model=model, messages=messages)

        if config.provider == "echo":
            last = next((m["content"] for m in reversed(messages) if m["role"] == "user"), "")
            return {"choices": [{"message": {"content": f"[echo:{model}] {last}"}}]}

        raise ValueError(f"Unsupported provider: {config.provider}")

    except Exception as exc:
        logging.error("LLM call failed for model '%s': %s", model, exc)
        if model != config.fallback_model:
            logging.info("Retrying with fallback model '%s'...", config.fallback_model)
            fallback_config = AIConfig(
                provider=config.provider,
                model=config.fallback_model,
                enable_preview=config.enable_preview,
                fallback_model=config.fallback_model,
            )
            return call_llm(messages, fallback_config)
        raise


def build_arg_parser(parser):
    parser.add_argument("--provider", default=os.getenv("AI_PROVIDER", "openai"), choices=["openai", "echo"])
    parser.add_argument("--model", default=os.getenv("AI_DEFAULT_MODEL", "gpt-4o-mini"))
    parser.add_argument("--enable-preview", action="store_true",
                        default=os.getenv("AI_ENABLE_PREVIEW", "false").lower() == "true")
    parser.add_argument("--fallback-model", default=os.getenv("AI_FALLBACK_MODEL", "gpt-4o-mini"))
    return parser


def main():
    import argparse

    parser = argparse.ArgumentParser()
    parser = build_arg_parser(parser)
    args = parser.parse_args()
    config = build_ai_config(args)
    result = call_llm([{"role": "user", "content": "Example"}], config)
    print(result)
```

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
