# Workflow Tracker Guide

## Overview

The Workflow Tracker is a simple command-line tool designed to help solo developers keep track of their current tasks, workflow steps, and progress on repository activities. It's especially useful when you:

- Work alone and need to remember where you left off
- Switch between multiple tasks and lose context
- Want a structured approach to complex workflows
- Need to track your progress on content generation, landing pages, or maintenance tasks

## Quick Start

### Basic Commands

```bash
# Show what you're currently working on
./scripts/workflow_tracker.py status

# Start a new task
./scripts/workflow_tracker.py start "Create product landing page"

# Add steps as you go
./scripts/workflow_tracker.py add-step "Write headline copy"
./scripts/workflow_tracker.py add-step "Design hero section"

# Mark steps complete as you finish them
./scripts/workflow_tracker.py complete-step 0

# When done, finish the task
./scripts/workflow_tracker.py finish

# Review your work history
./scripts/workflow_tracker.py history
```

### Using Workflow Templates

The tracker comes with pre-built workflow templates for common repository tasks:

```bash
# See all available templates
./scripts/workflow_tracker.py templates

# Load a template to start a structured workflow
./scripts/workflow_tracker.py load-template content-generation
```

## Available Workflow Templates

### 1. Content Generation Workflow (`content-generation`)

Use this when generating AI-powered content with `agent_codex.py`:

```bash
./scripts/workflow_tracker.py load-template content-generation
```

**Steps included:**
- Create or update prompt template
- Prepare input content
- Test with echo provider
- Review test output
- Run production with OpenAI
- Review and validate output
- Move content to final location
- Commit changes

**When to use:**
- Generating blog posts or product descriptions
- Rewriting content to match brand voice
- Creating landing page copy
- Batch processing marketing materials

### 2. Landing Page Creation (`landing-page-creation`)

Use this when creating new landing pages or components for Systeme.io:

```bash
./scripts/workflow_tracker.py load-template landing-page-creation
```

**Steps included:**
- Define purpose and target audience
- Create HTML structure
- Style with CSS
- Add brand assets
- Ensure mobile responsiveness
- Test links and assets
- Add to funnel map
- Test in Systeme.io
- Commit and document

**When to use:**
- Building opt-in pages
- Creating product sales pages
- Designing thank-you pages
- Developing reusable components

### 3. Affiliate Compliance Check (`affiliate-compliance-check`)

Use this to verify FTC compliance for affiliate marketing content:

```bash
./scripts/workflow_tracker.py load-template affiliate-compliance-check
```

**Steps included:**
- Review content for affiliate links
- Verify disclosure statements
- Check link tracking configuration
- Validate affiliate links
- Test link functionality
- Document relationships
- Update affiliate mapping
- Run compliance check

**When to use:**
- Publishing new affiliate content
- Updating product reviews
- Adding new affiliate partnerships
- Compliance audits

### 4. Repository Maintenance (`repository-maintenance`)

Use this for regular cleanup and organization:

```bash
./scripts/workflow_tracker.py load-template repository-maintenance
```

**Steps included:**
- Check git status
- Clean up old branches
- Run security scans
- Update documentation
- Check dependencies
- Clean temporary files
- Archive completed work
- Push changes

**When to use:**
- Weekly/monthly maintenance
- Before major releases
- After completing big features
- Repository housekeeping

### 5. New Feature Development (`new-feature-development`)

Use this when building new functionality:

```bash
./scripts/workflow_tracker.py load-template new-feature-development
```

**Steps included:**
- Define requirements and scope
- Create feature branch
- Implement functionality
- Add tests
- Update documentation
- Test locally
- Run security checks
- Create pull request
- Review and merge

**When to use:**
- Adding new scripts or tools
- Implementing automation features
- Building new integrations
- Enhancing existing functionality

### 6. Content Review and Publish (`content-review-and-publish`)

Use this when publishing content to production:

```bash
./scripts/workflow_tracker.py load-template content-review-and-publish
```

**Steps included:**
- Review content quality
- Check brand voice consistency
- Verify links work
- Run pre-publish checklist
- Check SEO metadata
- Validate HTML and accessibility
- Copy to Systeme.io
- Test live version
- Update tracking documents

**When to use:**
- Publishing new landing pages
- Releasing blog posts
- Going live with product pages
- Final content review before launch

## Detailed Command Reference

### `status` - Check Current Status

Shows what you're currently working on and your progress:

```bash
./scripts/workflow_tracker.py status
```

**Output includes:**
- Current task name
- When you started
- Context information
- List of steps with completion status
- Progress indicator

**Example output:**
```
📋 Current Task: Generate landing page copy
📅 Started: 2026-02-02T10:30:00

📊 Progress: 2/5 steps completed

📝 Steps:
  0. ✅ Create prompt template
     Completed: 2026-02-02T10:35:00
  1. ✅ Prepare input content
     Completed: 2026-02-02T10:40:00
  2. ⬜ Test with echo provider
  3. ⬜ Run production with OpenAI
  4. ⬜ Review output
```

### `start` - Start a New Task

Begin tracking a new task:

```bash
./scripts/workflow_tracker.py start "Your task description"
```

**Examples:**
```bash
# Content creation
./scripts/workflow_tracker.py start "Create affiliate product review page"

# Development
./scripts/workflow_tracker.py start "Fix broken links in landing pages"

# Maintenance
./scripts/workflow_tracker.py start "Weekly repository cleanup"
```

**Notes:**
- If you already have an active task, you'll be warned
- You can choose to finish the current task first
- Task starts with no steps - add them as you go

### `add-step` - Add a Step

Add a new step to your current task:

```bash
./scripts/workflow_tracker.py add-step "Step description"
```

**Examples:**
```bash
./scripts/workflow_tracker.py add-step "Write headline and subheadline"
./scripts/workflow_tracker.py add-step "Design hero section HTML"
./scripts/workflow_tracker.py add-step "Add call-to-action buttons"
./scripts/workflow_tracker.py add-step "Test mobile responsiveness"
```

**Tips:**
- Break work into small, actionable steps
- Be specific about what needs to be done
- Add steps as you think of them
- You can always add more steps later

### `complete-step` - Mark Step Complete

Mark a step as completed using its index number:

```bash
./scripts/workflow_tracker.py complete-step 0
```

**How to find the step index:**
- Run `status` to see numbered list of steps
- Use the number shown before each step
- First step is 0, second is 1, etc.

**Examples:**
```bash
# Complete first step
./scripts/workflow_tracker.py complete-step 0

# Complete third step
./scripts/workflow_tracker.py complete-step 2
```

### `finish` - Complete Current Task

Finish your current task and move it to history:

```bash
./scripts/workflow_tracker.py finish
```

**What happens:**
- If steps are incomplete, you'll be warned
- You can choose to finish anyway
- Task is moved to history
- Current status is cleared
- Ready to start a new task

### `history` - View Past Tasks

See your completed tasks:

```bash
# Show last 10 tasks
./scripts/workflow_tracker.py history

# Show last 20 tasks
./scripts/workflow_tracker.py history --limit 20
```

**Output shows:**
- Task name
- Start and finish times
- Step completion rate
- Chronological order (most recent last)

### `templates` - List Templates

View all available workflow templates:

```bash
./scripts/workflow_tracker.py templates
```

**Output includes:**
- Template ID (for loading)
- Template name
- Description
- Number of steps

### `load-template` - Load a Template

Start a new task using a pre-defined template:

```bash
./scripts/workflow_tracker.py load-template template-id
```

**Examples:**
```bash
./scripts/workflow_tracker.py load-template content-generation
./scripts/workflow_tracker.py load-template landing-page-creation
./scripts/workflow_tracker.py load-template affiliate-compliance-check
```

**What happens:**
- Starts a new task with template name
- Adds all template steps automatically
- All steps start as incomplete
- You can add more custom steps if needed

## Practical Workflows

### Daily Workflow: Content Generation

**Morning:**
```bash
# See what you were working on
./scripts/workflow_tracker.py status

# Or start fresh
./scripts/workflow_tracker.py load-template content-generation
```

**As you work:**
```bash
# Complete steps as you go
./scripts/workflow_tracker.py complete-step 0
./scripts/workflow_tracker.py complete-step 1

# Check progress anytime
./scripts/workflow_tracker.py status
```

**End of day:**
```bash
# If done, finish
./scripts/workflow_tracker.py finish

# If not done, just leave it - you'll see it tomorrow
```

### Weekly Workflow: Repository Maintenance

**Start of week:**
```bash
./scripts/workflow_tracker.py load-template repository-maintenance
```

**Throughout the week:**
```bash
# Complete maintenance tasks as you have time
./scripts/workflow_tracker.py status
./scripts/workflow_tracker.py complete-step 0
# ... continue with other steps
```

### Custom Workflow: Your Specific Task

**Create your own workflow:**
```bash
# Start a custom task
./scripts/workflow_tracker.py start "Build email capture funnel"

# Add your specific steps
./scripts/workflow_tracker.py add-step "Design opt-in form"
./scripts/workflow_tracker.py add-step "Write confirmation email"
./scripts/workflow_tracker.py add-step "Create thank-you page"
./scripts/workflow_tracker.py add-step "Set up Systeme.io automation"
./scripts/workflow_tracker.py add-step "Test complete flow"

# Work through them
./scripts/workflow_tracker.py complete-step 0
./scripts/workflow_tracker.py status
```

## Integration with Repository Workflows

### With Content Generation (`agent_codex.py`)

```bash
# Load the template
./scripts/workflow_tracker.py load-template content-generation

# Follow the steps
./scripts/workflow_tracker.py status

# When you reach "Test with echo provider"
./scripts/agent_codex.py --prompt ./prompts/your_prompt.txt \
  --input ./copywriting/source --output ./docs/ai_outputs/test \
  --provider echo --dry-run

# Mark it complete
./scripts/workflow_tracker.py complete-step 2

# Continue...
```

### With Security Checks

```bash
# Load maintenance template
./scripts/workflow_tracker.py load-template repository-maintenance

# When you reach security scan step
./scripts/security-check.sh

# Mark complete
./scripts/workflow_tracker.py complete-step 2
```

### With Git Workflow

```bash
# Start feature work
./scripts/workflow_tracker.py load-template new-feature-development

# Create branch (step 1)
git checkout -b feature/my-feature
./scripts/workflow_tracker.py complete-step 1

# Implement (step 2)
# ... do your work ...
./scripts/workflow_tracker.py complete-step 2

# Continue through remaining steps
```

## Tips for Solo Developers

### 1. Use Templates for Consistency

Templates ensure you don't skip important steps:
- Content generation: Always test before running with OpenAI
- Landing pages: Always check mobile responsiveness
- Affiliate content: Always verify compliance

### 2. Check Status Regularly

Make it a habit:
```bash
# Morning: What am I working on?
./scripts/workflow_tracker.py status

# Before leaving: What's left?
./scripts/workflow_tracker.py status
```

### 3. Finish Tasks When Complete

Moving finished tasks to history keeps your focus clear:
```bash
./scripts/workflow_tracker.py finish
```

### 4. Review History Periodically

Learn from your patterns:
```bash
# What have I accomplished this week?
./scripts/workflow_tracker.py history --limit 20
```

### 5. Customize Steps as Needed

Templates are starting points:
```bash
# Load template
./scripts/workflow_tracker.py load-template content-generation

# Add your custom steps
./scripts/workflow_tracker.py add-step "Send to client for review"
./scripts/workflow_tracker.py add-step "Incorporate feedback"
```

## Storage and Files

The tracker stores data in `.workflow/` directory at repository root:

```
.workflow/
├── current_status.json    # Your current task and progress
└── history.json          # Completed tasks
```

These files:
- Are excluded from git (in `.gitignore`)
- Are human-readable JSON
- Can be backed up separately if desired
- Are local to your machine

## Troubleshooting

### "No active task" error

You need to start a task first:
```bash
./scripts/workflow_tracker.py start "My task"
# or
./scripts/workflow_tracker.py load-template content-generation
```

### "Not in a git repository" error

Run the script from within your repository:
```bash
cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI
./scripts/workflow_tracker.py status
```

### Lost track of step numbers

Use `status` to see numbered list:
```bash
./scripts/workflow_tracker.py status
```

### Want to start over

Finish current task and start fresh:
```bash
./scripts/workflow_tracker.py finish
./scripts/workflow_tracker.py start "New task"
```

## Advanced Usage

### Creating Your Own Templates

You can edit `scripts/workflow_tracker.py` to add custom templates. Look for the `WORKFLOW_TEMPLATES` dictionary and add your own following the existing pattern.

### Integrating with Other Tools

The tracker uses simple JSON files, so you can:
- Parse them with other scripts
- Display them in dashboards
- Integrate with notification systems
- Export to other formats

### Alias for Quick Access

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
alias wf='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py'
```

Then use:
```bash
wf status
wf start "New task"
wf complete-step 0
```

## Getting Help

Show help anytime:
```bash
./scripts/workflow_tracker.py --help
./scripts/workflow_tracker.py start --help
./scripts/workflow_tracker.py complete-step --help
```

## Next Steps

1. **Try it now**: Load a template and start tracking
   ```bash
   ./scripts/workflow_tracker.py templates
   ./scripts/workflow_tracker.py load-template content-generation
   ```

2. **Make it a habit**: Check status at start/end of work sessions

3. **Customize**: Add your own steps to fit your workflow

4. **Review**: Look at history to understand your productivity patterns

Remember: This tool is here to help you, not to constrain you. Use it in whatever way makes your work easier!
