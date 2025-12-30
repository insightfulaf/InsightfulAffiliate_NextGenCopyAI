# GitHub Copilot Setup Guide

This guide explains how to use the GitHub Copilot custom agents and skills configured for this repository.

## Overview

This repository includes specialized GitHub Copilot agents and skills to streamline common workflows for InsightfulAffiliate and NextGenCopyAI content creation.

## Custom Agents

### 1. Content Generator
AI-powered copywriting for both brands. Best for creating marketing copy, product descriptions, and batch content generation.

### 2. Landing Page Builder
Create conversion-optimized web components for Systeme.io. Best for hero sections, CTAs, feature grids, and complete landing pages.

### 3. Affiliate Link Manager
Manage affiliate links and ensure FTC compliance. Best for auditing content, verifying links, and creating proper disclosures.

### 4. Documentation Expert
Create clear, comprehensive documentation. Best for README files, how-to guides, and API documentation.

### 5. Plan Mode
Strategic planning and architecture. Best for understanding codebase and planning implementations.

## Skills

### Content Generation Workflow
Complete workflow for automated AI content generation using `agent_codex.py`.

**Quick Start**:
```bash
./scripts/agent_codex.py \
  --prompt ./prompts/your_prompt.txt \
  --input ./copywriting/source \
  --output ./docs/ai_outputs/test \
  --provider echo --dry-run
```

### Affiliate Compliance Check
Automated FTC compliance verification for affiliate content.

**Quick Check**:
```bash
# Find files with affiliate links
grep -r -l "affiliate" copywriting/ landing_pages/

# Check for disclosures
for file in $(grep -r -l "affiliate" copywriting/); do
  if ! grep -q "disclosure" "$file"; then
    echo "Missing disclosure: $file"
  fi
done
```

## Using Copilot Agents

**In GitHub Issues**: Assign to @copilot and select custom agent

**In VS Code**: Use agent name in chat
```
@content-generator help me create...
@landing-page-builder design a hero section...
@affiliate-link-manager audit this content...
```

## Best Practices

1. **Be Specific**: Provide clear, detailed requirements
2. **Specify Brand**: Always clarify InsightfulAffiliate or NextGenCopyAI voice
3. **Provide Context**: Share relevant information and constraints
4. **Iterate**: Refine based on results

## Example Usage

### Generate Product Descriptions
```
@content-generator create descriptions for AI copywriting tools in 
InsightfulAffiliate voice with FTC disclosures
```

### Create Landing Page Hero
```
@landing-page-builder create hero section for NextGenCopyAI course 
with headline, subheadline, and CTA button
```

### Audit Compliance
```
@affiliate-link-manager audit all content for FTC compliance 
including disclosure placement and link functionality
```

## Resources

- Repository Instructions: `.github/copilot-instructions.md`
- Agent Definitions: `.github/agents/`
- Skills: `.github/skills/`
- Contributing: `CONTRIBUTING.md`

## Learn More

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Best Practices](https://gh.io/copilot-coding-agent-tips)
- [Awesome Copilot](https://github.com/github/awesome-copilot)
