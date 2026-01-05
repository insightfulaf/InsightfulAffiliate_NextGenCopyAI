# Workflow Operations Guide

**Quick Reference for Repository Operations, Python Environment, and AI Agents**

This guide provides practical reference material for working with the InsightfulAffiliate_NextGenCopyAI repository, including Python environment setup, environment variables, agent configurations, and common workflows.

---

## Table of Contents

1. [Python Environment Setup](#python-environment-setup)
2. [Environment Variables Reference](#environment-variables-reference)
3. [Available Agents Quick Reference](#available-agents-quick-reference)
4. [Available Skills Quick Reference](#available-skills-quick-reference)
5. [Common Workflows](#common-workflows)
6. [Troubleshooting](#troubleshooting)

---

## Python Environment Setup

### Current Python Configuration

**System Python**: The repository uses the system-installed Python 3.

**Check your Python version:**
```bash
python3 --version
# Expected: Python 3.10 or higher
```

**Check Python path:**
```bash
which python3
# Example output: /usr/bin/python3 (system)
# Or: /opt/homebrew/bin/python3 (Homebrew on macOS)
```

### Virtual Environment vs Regular Environment

#### Regular (System) Python Environment

**What it is:**
- Uses the system's global Python installation
- Packages installed with `pip install` go to system-wide location
- Shared across all projects on your machine

**Pros:**
- Simple to use (no activation needed)
- Works immediately after Python installation

**Cons:**
- Package version conflicts between projects
- System-wide pollution with project-specific dependencies
- Requires admin permissions on some systems
- Difficult to maintain consistent environments

**When to use:**
- Quick scripts that don't need specific package versions
- System-level tools installed via `pipx`

#### Python Virtual Environment (Recommended)

**What it is:**
- Isolated Python environment specific to this project
- Has its own `pip` and package installations
- Located in a directory (typically `.venv/` or `venv/`)

**Pros:**
- Project-specific dependencies (no conflicts)
- Clean, reproducible environments
- No system pollution
- Can use different Python versions per project

**Cons:**
- Must activate before use
- Takes disk space (per project)

**When to use:**
- Running Python scripts in this repository
- Installing project dependencies
- **Always recommended for repository work**

### Creating and Using a Virtual Environment

#### 1. Create Virtual Environment (One-Time Setup)

**At repository root:**
```bash
cd /path/to/InsightfulAffiliate_NextGenCopyAI

# Create virtual environment in .venv directory
python3 -m venv .venv
```

**What this does:**
- Creates `.venv/` directory with isolated Python
- Copies Python binary and creates pip/setuptools
- `.venv/` is already in `.gitignore` (won't be committed)

#### 2. Activate Virtual Environment (Before Each Work Session)

**macOS/Linux:**
```bash
source .venv/bin/activate
```

**Windows:**
```cmd
.venv\Scripts\activate
```

**How to tell it's active:**
Your shell prompt will show `(.venv)` prefix:
```bash
(.venv) user@machine:~/repo$
```

#### 3. Install Dependencies

**With virtual environment activated:**
```bash
pip install -r requirements.txt
```

**Current dependencies (from `requirements.txt`):**
- `openai>=1.57.0` - OpenAI API client for AI content generation
- `pytest>=8.0.0` - Testing framework
- `detect-secrets>=1.4.0` - Security scanning
- `pre-commit>=3.5.0` - Git pre-commit hooks
- `gitlint>=0.19.1` - Git commit message linting

#### 4. Deactivate When Done

```bash
deactivate
```

### Python Path and Environment Concerns

#### Where is PYTHONPATH Set?

**Answer:** `PYTHONPATH` is NOT explicitly set in this repository by default.

**Why this matters:**
- Python finds modules using `sys.path`, which includes:
  1. Current directory
  2. Standard library locations
  3. Site-packages (where pip installs packages)
  4. Any directories in `PYTHONPATH` environment variable

**In a virtual environment:**
- `sys.path` automatically includes `.venv/lib/python3.x/site-packages/`
- No need to manually set `PYTHONPATH`

#### Can I Set PYTHONPATH Elsewhere?

**Yes, but generally NOT recommended for this repository.**

**Options to set PYTHONPATH:**

1. **Shell environment (temporary):**
   ```bash
   export PYTHONPATH=/custom/path:$PYTHONPATH
   python3 script.py
   ```

2. **Shell configuration (persistent):**
   ```bash
   # Add to ~/.bashrc or ~/.zshrc
   export PYTHONPATH="/custom/path:$PYTHONPATH"
   ```

3. **In script (programmatic):**
   ```python
   import sys
   sys.path.insert(0, '/custom/path')
   ```

**Potential issues with custom PYTHONPATH:**
- ❌ Can cause module conflicts
- ❌ Makes environment non-reproducible
- ❌ Other contributors may not have same paths
- ❌ Can mask missing dependencies in virtual environment
- ❌ Hard to debug "works on my machine" issues

**Best practice for this repository:**
- Use virtual environment at repository root
- Don't set custom `PYTHONPATH`
- Keep all dependencies in `requirements.txt`
- Install packages via `pip` in virtual environment

### Repository-Specific Python Script Locations

**Main automation scripts:**
```
scripts/
├── agent_codex.py         # AI content generation agent
├── build_funnel_map.py    # Funnel mapping automation
├── fix_manifest_urls.py   # Asset manifest URL fixer
├── setup.sh               # Initial repository setup (bash)
└── security-check.sh      # Security scanning (bash)
```

**Run scripts with virtual environment:**
```bash
# Activate venv first
source .venv/bin/activate

# Run script
./scripts/agent_codex.py --help
python3 scripts/agent_codex.py --help
```

---

## Environment Variables Reference

### Required for AI Features

#### `OPENAI_API_KEY`

**Purpose:** Authentication for OpenAI API when using `agent_codex.py` with `--provider openai`

**Required by:**
- `scripts/agent_codex.py` (when using OpenAI provider)
- Content generation workflows
- Any AI-powered automation

**How to set:**

**Temporary (current session only):**
```bash
export OPENAI_API_KEY="sk-..."
```

**Persistent (recommended for macOS/Linux):**
```bash
# Add to ~/.bashrc or ~/.zshrc
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
source ~/.zshrc
```

**Verify it's set:**
```bash
echo $OPENAI_API_KEY
# Should output: sk-...

# Or check if it's set without revealing value
[ -n "$OPENAI_API_KEY" ] && echo "Set" || echo "Not set"
```

**Security notes:**
- ⚠️ Never commit API keys to git
- ⚠️ Don't include in scripts (use environment variables)
- ⚠️ Use `.env` files locally (not committed) or shell config
- ⚠️ Rotate keys if accidentally exposed

**What happens without it:**
```bash
# Using OpenAI provider without key
./scripts/agent_codex.py --provider openai --prompt test.txt --input . --output /tmp/out

# Error message:
# "OPENAI_API_KEY is not set in the environment."
```

**Testing without OpenAI (no API key needed):**
```bash
# Use echo provider for testing
./scripts/agent_codex.py --provider echo --prompt test.txt --input . --output /tmp/out
```

### Optional Configuration Variables

These environment variables are referenced in the repository documentation but are **NOT currently implemented** in the main scripts. They are provided as examples for future extensions or custom configurations.

#### `AI_PROVIDER`

**Purpose:** Default AI provider for content generation (example from copilot-instructions.md)

**Possible values:** `openai`, `echo`

**Default if not set:** `openai` (in example code)

**Usage example:**
```bash
export AI_PROVIDER="echo"  # Use echo provider by default
```

#### `AI_DEFAULT_MODEL`

**Purpose:** Default OpenAI model to use

**Possible values:** `gpt-4o-mini`, `gpt-4o`, `gpt-4`

**Default if not set:** `gpt-4o-mini`

**Usage example:**
```bash
export AI_DEFAULT_MODEL="gpt-4o"
```

#### `AI_ENABLE_PREVIEW`

**Purpose:** Enable preview/beta models (e.g., GPT-5, Codex)

**Possible values:** `true`, `false`

**Default if not set:** `false`

**Usage example:**
```bash
export AI_ENABLE_PREVIEW="true"
```

#### `AI_FALLBACK_MODEL`

**Purpose:** Fallback model if primary model fails or preview not enabled

**Possible values:** Any OpenAI model name

**Default if not set:** `gpt-4o-mini`

**Usage example:**
```bash
export AI_FALLBACK_MODEL="gpt-4o-mini"
```

### Git and GitHub Authentication

#### `GITHUB_TOKEN` or `GH_TOKEN`

**Purpose:** GitHub Personal Access Token for API access

**Used by:**
- GitHub Actions workflows
- CLI tools that interact with GitHub API

**Not directly used by repository scripts** (but may be needed for GitHub CLI)

**How to set:**
```bash
export GITHUB_TOKEN="ghp_..."
```

### Checking All Environment Variables

**List all environment variables:**
```bash
env | sort
```

**Check specific variables:**
```bash
env | grep -i "python\|openai\|github"
```

**Check in Python:**
```python
import os

# Check specific variable
print(f"OPENAI_API_KEY set: {bool(os.environ.get('OPENAI_API_KEY'))}")

# List all environment variables
for key, value in sorted(os.environ.items()):
    if 'PYTHON' in key or 'OPENAI' in key:
        print(f"{key}={value}")
```

---

## Available Agents Quick Reference

GitHub Copilot agents are specialized AI assistants configured for specific tasks in this repository. They are located in `.github/agents/` and can be invoked in compatible editors.

### Agent Inventory

#### 1. Content Generator (`content-generator.yml`)

**Purpose:** AI-powered content generation specialist for InsightfulAffiliate and NextGenCopyAI brands

**Best for:**
- Creating marketing copy and product descriptions
- Generating landing page content
- Batch content generation with `agent_codex.py`
- Brand voice consistency (InsightfulAffiliate vs NextGenCopyAI)

**Key capabilities:**
- Understands both brand voices
- Manages `agent_codex.py` workflow
- Creates paste-ready Systeme.io components
- Handles prompt engineering

**Example use:**
```
@content-generator Create 5 product descriptions for AI writing tools
@content-generator Generate a landing page hero section for NextGenCopyAI
```

#### 2. Affiliate Link Manager (`affiliate-link-manager.yml`)

**Purpose:** Manages affiliate links, tracking, and FTC compliance

**Best for:**
- Adding/updating affiliate links
- Ensuring FTC disclosure compliance
- Auditing content for affiliate link issues
- Managing `docs/affiliate_links/affiliate_links_mapping_FINAL.json`

**Key capabilities:**
- Link compliance checking
- FTC disclosure templates
- Link mapping management
- Ethical affiliate marketing guidance

**Example use:**
```
@affiliate-link-manager Check this content for FTC compliance
@affiliate-link-manager Add Jasper AI affiliate link to mapping
```

#### 3. Documentation Expert (`documentation-expert.yml`)

**Purpose:** Creates and maintains technical documentation

**Best for:**
- Writing guides and tutorials
- Updating README and docs
- Creating API documentation
- Maintaining consistent documentation style

**Key capabilities:**
- Markdown expertise
- Technical writing
- Documentation structure
- Code examples

**Example use:**
```
@documentation-expert Create a guide for the agent_codex.py script
@documentation-expert Update the README with new setup instructions
```

#### 4. Landing Page Builder (`landing-page-builder.yml`)

**Purpose:** Builds HTML/CSS/JS landing page components

**Best for:**
- Creating Systeme.io-compatible components
- Responsive design implementation
- HTML/CSS component development
- Asset integration

**Key capabilities:**
- Mobile-first responsive design
- Accessibility (ARIA labels, semantic HTML)
- Self-contained components
- Relative path management

**Example use:**
```
@landing-page-builder Create a pricing table component
@landing-page-builder Build a testimonial section with CSS animations
```

#### 5. SSH Key Manager (`ssh-key-manager.yml`)

**Purpose:** SSH key security and credential management specialist

**Best for:**
- Setting up SSH keys securely
- Responding to accidentally exposed keys
- Auditing SSH security setup
- Troubleshooting SSH authentication

**Key capabilities:**
- Security scanning for exposed keys
- Emergency response guidance
- Secure key storage practices
- Key rotation procedures

**Example use:**
```
@ssh-key-manager Help me set up SSH keys for GitHub
@ssh-key-manager I accidentally committed a private key, what should I do?
```

**Related documentation:**
- [docs/SSH_KEY_SECURITY.md](SSH_KEY_SECURITY.md)
- [docs/SSH_KEY_SECURITY_QUICKREF.md](SSH_KEY_SECURITY_QUICKREF.md)

#### 6. Plan Mode (`plan-mode.yml`)

**Purpose:** Project planning and task breakdown

**Best for:**
- Breaking down large tasks
- Creating implementation plans
- Estimating effort
- Structuring workflows

**Key capabilities:**
- Task decomposition
- Dependency identification
- Timeline estimation
- Risk assessment

**Example use:**
```
@plan-mode Break down the task of migrating all content to a new CMS
@plan-mode Create a plan for improving repository security
```

### How to Use Agents

**In GitHub Copilot Chat:**
```
@agent-name Your question or request
```

**In VS Code with GitHub Copilot:**
1. Open Copilot Chat panel
2. Type `@` to see available agents
3. Select agent from list
4. Enter your request

**Not seeing agents?**
- Agents are stored in `.github/agents/`
- Requires GitHub Copilot with agent support
- May need organization/enterprise Copilot plan

### Agent Configuration Files

All agents are configured as YAML files in `.github/agents/`:

```
.github/agents/
├── README.md                        # Agent documentation
├── affiliate-link-manager.yml       # Affiliate compliance
├── content-generator.yml            # Content creation
├── documentation-expert.yml         # Technical docs
├── landing-page-builder.yml         # HTML/CSS components
├── plan-mode.yml                    # Project planning
└── ssh-key-manager.yml              # SSH security
```

**Agent file structure:**
```yaml
---
description: "Brief description"
name: "Display Name"
tools:
  - codebase
  - search
  - githubRepo
---

# Detailed instructions in markdown
```

---

## Available Skills Quick Reference

Skills are executable workflows that automate common tasks. They are located in `.github/skills/` and can be invoked by agents or directly.

### Skill Inventory

#### 1. Content Generation Workflow (`content-generation-workflow`)

**Purpose:** Automated AI content generation using `agent_codex.py`

**Location:** `.github/skills/content-generation-workflow/`

**What it does:**
- Manages complete content generation pipeline
- Handles prompt templates
- Executes batch processing
- Validates outputs
- Manages AI provider configuration

**Quick start:**
```bash
# Test workflow
./scripts/agent_codex.py \
  --prompt ./prompts/your_prompt.txt \
  --input ./copywriting/source \
  --output ./docs/ai_outputs/test \
  --provider echo \
  --dry-run

# Production run
./scripts/agent_codex.py \
  --prompt ./prompts/your_prompt.txt \
  --input ./copywriting/source \
  --output ./docs/ai_outputs/prod \
  --provider openai \
  --model gpt-4o-mini
```

**Common use cases:**
- Generate product descriptions
- Rewrite content to brand voice
- Create landing page components
- Batch process marketing copy

**Prerequisites:**
- Python 3.10+
- OpenAI API key (for production)
- Input content prepared
- Prompt template created

**Documentation:** `.github/skills/content-generation-workflow/SKILL.md`

#### 2. Affiliate Compliance Check (`affiliate-compliance-check`)

**Purpose:** Verify FTC compliance and affiliate link integrity

**Location:** `.github/skills/affiliate-compliance-check/`

**What it does:**
- Scans content for affiliate links
- Checks for FTC disclosures
- Validates link tracking
- Ensures ethical practices

**Quick compliance check:**
```bash
# Find files with affiliate links
grep -r -l -E "(affiliate|aff\.|&id=|\?ref=)" \
  copywriting/ landing_pages/ --include="*.md" --include="*.html"

# Check for disclosures
for file in $(grep -r -l -E "(affiliate|aff\.)" copywriting/ --include="*.md"); do
  if ! grep -q -i "disclosure" "$file"; then
    echo "❌ Missing disclosure: $file"
  fi
done
```

**Compliance checklist:**
- [ ] Disclosure exists
- [ ] Disclosure is above the fold
- [ ] Language is clear and plain
- [ ] Visible on mobile devices
- [ ] All affiliate links work
- [ ] Links in mapping file
- [ ] Content provides genuine value
- [ ] Honest assessment (pros/cons)

**Resources:**
- Link mapping: `docs/affiliate_links/affiliate_links_mapping_FINAL.json`
- FTC Guidelines: [FTC Disclosures 101](https://www.ftc.gov/business-guidance/resources/disclosures-101-social-media-influencers)

**Documentation:** `.github/skills/affiliate-compliance-check/SKILL.md`

### How to Use Skills

**Direct execution (command line):**
```bash
# Content generation
./scripts/agent_codex.py [options]

# Affiliate compliance
grep -r -E "(affiliate|aff\.)" copywriting/
```

**Via agents:**
```
@content-generator Generate content using the workflow skill
@affiliate-link-manager Run compliance check on my content
```

### Creating New Skills

Skills are reusable workflows stored in `.github/skills/`:

```
.github/skills/
├── affiliate-compliance-check/
│   └── SKILL.md
└── content-generation-workflow/
    └── SKILL.md
```

**Skill documentation structure:**
```markdown
---
name: skill-name
description: Brief description
---

# Skill Name

## When to Use
## Prerequisites
## Quick Start
## Examples
## Troubleshooting
```

---

## Common Workflows

### Initial Repository Setup

**First-time setup after cloning:**

```bash
# 1. Run setup script (configures git credentials)
./scripts/setup.sh

# 2. Create Python virtual environment
python3 -m venv .venv

# 3. Activate virtual environment
source .venv/bin/activate

# 4. Install dependencies
pip install -r requirements.txt

# 5. Set OpenAI API key (if using AI features)
export OPENAI_API_KEY="sk-..."

# 6. Install pre-commit hooks (optional but recommended)
pre-commit install

# 7. Verify setup
python3 --version
pip list
git remote -v
```

### AI Content Generation

**Basic workflow:**

```bash
# 1. Activate virtual environment
source .venv/bin/activate

# 2. Ensure API key is set
echo $OPENAI_API_KEY  # Should show sk-...

# 3. Test with echo provider first
./scripts/agent_codex.py \
  --prompt ./prompts/example_prompt.txt \
  --input ./copywriting/drafts \
  --output ./docs/ai_outputs/test \
  --provider echo \
  --dry-run \
  --verbose

# 4. Review test output
ls -la ./docs/ai_outputs/test/

# 5. Run with OpenAI if test looks good
./scripts/agent_codex.py \
  --prompt ./prompts/example_prompt.txt \
  --input ./copywriting/drafts \
  --output ./docs/ai_outputs/final \
  --provider openai \
  --model gpt-4o-mini

# 6. Review output
ls -la ./docs/ai_outputs/final/

# 7. Move approved content to final location
mv ./docs/ai_outputs/final/*.md ./copywriting/final/

# 8. Commit changes
git add copywriting/final/
git commit -m "feat(content): add AI-generated product descriptions"
git push
```

### Affiliate Link Management

**Add new affiliate link:**

```bash
# 1. Update mapping file
vim docs/affiliate_links/affiliate_links_mapping_FINAL.json

# Add entry:
{
  "product-slug": {
    "name": "Product Name",
    "url": "https://affiliate-link.com/?id=tracking",
    "network": "ClickBank",
    "category": "ai-tools",
    "added_date": "2025-01-05",
    "notes": "High-converting offer"
  }
}

# 2. Use link in content with disclosure
vim copywriting/product_pages/product-slug.md

# Add FTC disclosure:
## Disclosure

This post contains affiliate links. If you click through and make a 
purchase, I may receive a commission at no additional cost to you.

# 3. Test the link
curl -I "https://affiliate-link.com/?id=tracking"

# 4. Run compliance check
grep -l "product-slug" copywriting/product_pages/product-slug.md
grep -i "disclosure" copywriting/product_pages/product-slug.md

# 5. Commit
git add docs/affiliate_links/ copywriting/product_pages/
git commit -m "feat(affiliate): add Product Name affiliate link"
git push
```

### Security Scanning

**Run security checks:**

```bash
# 1. Run security check script
./scripts/security-check.sh

# 2. Check for secrets in staged files
detect-secrets scan

# 3. Run pre-commit hooks manually
pre-commit run --all-files

# 4. Check for SSH keys (manual)
find . -type f \( -name "*.pem" -o -name "*.key" -o -name "id_rsa*" \) \
  ! -path "./.git/*" ! -path "./Archive_ready_to_sync/*"

# 5. Review .gitignore
cat .gitignore | grep -E "key|pem|secret"
```

### Testing

**Run tests:**

```bash
# 1. Activate virtual environment
source .venv/bin/activate

# 2. Run all tests
pytest

# 3. Run specific test file
pytest tests/test_hello.py

# 4. Run with verbose output
pytest -v

# 5. Run with coverage
pytest --cov=scripts
```

### Documentation Updates

**Update documentation:**

```bash
# 1. Edit documentation files
vim docs/WORKFLOW_OPERATIONS_GUIDE.md

# 2. Check markdown syntax (if markdownlint installed)
markdownlint docs/*.md

# 3. Preview in VS Code
# Open file, press Cmd+Shift+V (macOS) or Ctrl+Shift+V (Windows/Linux)

# 4. Commit
git add docs/
git commit -m "docs: update workflow operations guide"
git push
```

### Git Workflows

**Common git operations:**

```bash
# Check status
git status

# View changes
git diff

# Stage specific files
git add scripts/agent_codex.py

# Stage all changes
git add .

# Commit with message
git commit -m "type(scope): description"

# Push to remote
git push origin main

# Create and switch to new branch
git checkout -b feature/new-feature

# Pull latest changes
git pull origin main

# View commit history
git log --oneline --graph --decorate --all

# Undo uncommitted changes to file
git checkout -- filename

# Undo last commit (keep changes)
git reset --soft HEAD~1

# View remote repositories
git remote -v
```

---

## Troubleshooting

### Python Environment Issues

#### Problem: `command not found: python` or `command not found: python3`

**Solution:**
```bash
# Check if Python is installed
which python3
python3 --version

# Install Python (macOS with Homebrew)
brew install python3

# Install Python (Ubuntu/Debian)
sudo apt update && sudo apt install python3 python3-pip python3-venv
```

#### Problem: `No module named 'openai'`

**Solution:**
```bash
# Activate virtual environment
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Verify installation
pip list | grep openai
```

#### Problem: `ModuleNotFoundError` when running scripts

**Solution:**
```bash
# 1. Check if virtual environment is activated
# Shell prompt should show (.venv)

# 2. If not activated:
source .venv/bin/activate

# 3. Verify Python is using virtual environment
which python3
# Should show: /path/to/repo/.venv/bin/python3

# 4. Check sys.path in Python
python3 -c "import sys; print('\n'.join(sys.path))"

# 5. Reinstall dependencies if needed
pip install -r requirements.txt
```

#### Problem: Virtual environment not activating

**Solution:**
```bash
# Recreate virtual environment
rm -rf .venv
python3 -m venv .venv

# Try activating again
source .venv/bin/activate

# Check permissions
ls -la .venv/bin/activate
# Should be readable/executable

# If still failing, check shell
echo $SHELL
# Make sure you're using bash or zsh
```

### Environment Variables Issues

#### Problem: `OPENAI_API_KEY is not set in the environment`

**Solution:**
```bash
# Check if set
echo $OPENAI_API_KEY

# Set for current session
export OPENAI_API_KEY="sk-..."

# Verify
echo $OPENAI_API_KEY

# Make persistent (add to ~/.zshrc or ~/.bashrc)
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
source ~/.zshrc

# Alternative: Use .env file (not in repository)
echo 'OPENAI_API_KEY=sk-...' > .env
# Load with: source .env
```

#### Problem: Environment variable set but script doesn't see it

**Solution:**
```bash
# Check if variable is exported
export -p | grep OPENAI_API_KEY

# Must use 'export', not just assignment
# Wrong:
OPENAI_API_KEY="sk-..."

# Correct:
export OPENAI_API_KEY="sk-..."

# Verify in Python
python3 -c "import os; print(os.environ.get('OPENAI_API_KEY', 'NOT SET'))"
```

### Agent and Skill Issues

#### Problem: Agents not appearing in Copilot

**Solution:**
1. Check GitHub Copilot subscription and plan
2. Verify `.github/agents/` directory exists
3. Check agent YAML files are properly formatted
4. Restart VS Code or IDE
5. May require enterprise/organization Copilot plan

#### Problem: `agent_codex.py` fails with validation errors

**Solution:**
```bash
# Run with verbose and dry-run to debug
./scripts/agent_codex.py \
  --prompt ./prompts/test.txt \
  --input ./test \
  --output /tmp/out \
  --provider echo \
  --dry-run \
  --verbose

# Check prompt file exists and is readable
cat ./prompts/test.txt

# Check input directory exists and has files
ls -la ./test/

# Check file extensions match include-ext
./scripts/agent_codex.py --help | grep include-ext
```

### Git and GitHub Issues

#### Problem: `Permission denied (publickey)` with SSH

**Solution:**
```bash
# Check SSH key exists
ls -la ~/.ssh/id_ed25519*

# If not, create SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add public key to GitHub
cat ~/.ssh/id_ed25519.pub
# Copy output and add at: https://github.com/settings/keys

# Test connection
ssh -T git@github.com
```

#### Problem: `Authentication failed` with HTTPS

**Solution:**
```bash
# Use Personal Access Token (PAT), not password
# Create PAT at: https://github.com/settings/tokens

# Configure macOS keychain helper
git config --global credential.helper osxkeychain

# Or switch to SSH
git remote set-url origin git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

### Script Execution Issues

#### Problem: `Permission denied` when running scripts

**Solution:**
```bash
# Make script executable
chmod +x ./scripts/agent_codex.py
chmod +x ./scripts/setup.sh

# Or run with python directly
python3 ./scripts/agent_codex.py --help
```

#### Problem: `Bad interpreter: /usr/bin/env: 'python3\r': No such file or directory`

**Solution (Windows line endings issue):**
```bash
# Convert line endings (requires dos2unix)
dos2unix ./scripts/agent_codex.py

# Or manually in vim
vim ./scripts/agent_codex.py
:set ff=unix
:wq

# Or use sed
sed -i 's/\r$//' ./scripts/agent_codex.py
```

### Dependency Issues

#### Problem: `pip install` fails

**Solution:**
```bash
# Update pip
python3 -m pip install --upgrade pip

# Try installing with verbose output
pip install -v -r requirements.txt

# Install specific package to see error
pip install openai

# Check for conflicting packages
pip list --outdated

# Clear pip cache if corrupted
pip cache purge
rm -rf ~/.cache/pip
```

### Performance Issues

#### Problem: AI generation is slow or timing out

**Solution:**
1. Check OpenAI API status: https://status.openai.com/
2. Reduce batch size (process fewer files at once)
3. Use faster model (gpt-4o-mini instead of gpt-4)
4. Check network connection
5. Consider rate limiting (if hitting API limits)

#### Problem: Scripts running out of memory

**Solution:**
```bash
# Process files in smaller batches
# Split input directory into chunks

# Monitor memory usage
htop  # or 'top' on macOS/Linux

# Close other applications
# Restart terminal session
```

### Getting Help

#### Documentation Resources

- **Repository README:** [README.md](../README.md)
- **Contributing Guide:** [CONTRIBUTING.md](../CONTRIBUTING.md)
- **Security Policy:** [SECURITY.md](../SECURITY.md)
- **SSH Security:** [SSH_KEY_SECURITY.md](SSH_KEY_SECURITY.md)
- **Agent Documentation:** [.github/agents/README.md](../.github/agents/README.md)

#### Command Help

```bash
# Script help
./scripts/agent_codex.py --help
./scripts/setup.sh --help

# Tool help
git --help
python3 --help
pip --help

# Agent/skill help
cat .github/agents/README.md
cat .github/skills/content-generation-workflow/SKILL.md
```

#### Checking System Information

```bash
# Python version and location
python3 --version
which python3
python3 -c "import sys; print(sys.executable)"

# Installed packages
pip list
pip show openai

# Environment variables
env | grep -i "python\|openai"

# Git configuration
git config --list
git remote -v

# System information
uname -a  # OS info
df -h     # Disk space
free -h   # Memory (Linux)
```

---

## Quick Reference Card

### Essential Commands

```bash
# Python Environment
source .venv/bin/activate              # Activate venv
deactivate                             # Deactivate venv
pip install -r requirements.txt        # Install deps

# Environment Variables
export OPENAI_API_KEY="sk-..."         # Set API key
echo $OPENAI_API_KEY                   # Check API key

# Content Generation
./scripts/agent_codex.py --provider echo --dry-run ...  # Test
./scripts/agent_codex.py --provider openai ...          # Production

# Affiliate Compliance
grep -r -E "(affiliate|aff\.)" copywriting/             # Find links
grep -i "disclosure" file.md                           # Check disclosure

# Security
./scripts/security-check.sh            # Run security scan
pre-commit run --all-files             # Run pre-commit hooks

# Git
git status                             # Check status
git add . && git commit -m "msg"       # Stage and commit
git push origin main                   # Push changes
```

### File Locations

```
scripts/agent_codex.py                 # AI content generation
requirements.txt                       # Python dependencies
.github/agents/                        # Agent configurations
.github/skills/                        # Executable workflows
docs/                                  # Documentation
docs/affiliate_links/                  # Affiliate link mappings
copywriting/                           # Marketing content
landing_pages/                         # Landing page components
prompts/                               # AI prompt templates
```

### Support

For questions or issues:
1. Check this guide
2. Review relevant documentation
3. Check agent/skill README files
4. Run commands with `--help` flag
5. Review error messages carefully
6. Check environment variable settings

---

**Last Updated:** 2025-01-05  
**Maintained by:** Repository Contributors  
**Repository:** [insightfulaf/InsightfulAffiliate_NextGenCopyAI](https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI)
