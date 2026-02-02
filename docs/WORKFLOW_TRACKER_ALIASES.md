# Workflow Tracker Shell Aliases

## Quick Setup for Easy Access

Make the workflow tracker even easier to use by creating shell aliases!

## For Zsh (macOS default)

Add to `~/.zshrc`:

```bash
# Workflow Tracker Aliases
alias wf='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py'
alias wfs='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py status'
alias wft='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py templates'
alias wfh='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py history'
```

Then reload your shell:
```bash
source ~/.zshrc
```

## For Bash (Linux, older macOS)

Add to `~/.bashrc` or `~/.bash_profile`:

```bash
# Workflow Tracker Aliases
alias wf='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py'
alias wfs='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py status'
alias wft='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py templates'
alias wfh='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py history'
```

Then reload your shell:
```bash
source ~/.bashrc  # or source ~/.bash_profile
```

## Usage After Setup

Now you can use short commands from anywhere:

```bash
# Check status (from any directory)
wfs

# Show templates
wft

# View history
wfh

# Any other command
wf start "New task"
wf add-step "Do something"
wf complete-step 0
wf finish
```

## Advanced Aliases

Want more shortcuts? Add these too:

```bash
# Load common templates quickly
alias wf-content='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py load-template content-generation'
alias wf-landing='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py load-template landing-page-creation'
alias wf-compliance='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py load-template affiliate-compliance-check'
alias wf-maintenance='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py load-template repository-maintenance'
```

Then use:
```bash
wf-content      # Start content generation workflow
wf-landing      # Start landing page workflow
wf-compliance   # Start compliance check workflow
wf-maintenance  # Start maintenance workflow
```

## Custom Path

If your repository is in a different location, update the path:

```bash
# Example: Repository in ~/Documents/projects/
alias wf='cd ~/Documents/projects/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py'
```

## Making it Permanent

The aliases will be available every time you open a new terminal window.

To test immediately without reloading:
```bash
source ~/.zshrc    # for Zsh
# or
source ~/.bashrc   # for Bash
```

## Integration with Your Workflow

### Morning Routine
```bash
# Open terminal and immediately check status
wfs
```

### Starting Work
```bash
# Quick template load
wf-content
```

### Throughout the Day
```bash
# Quick status checks
wfs

# Mark steps complete
wf complete-step 0
wfs
```

### End of Day
```bash
# Check what's done
wfs

# Finish if complete
wf finish

# Or just leave it for tomorrow
```

## Pro Tips

1. **Add to your shell startup script** so aliases are always available
2. **Keep commands short** - `wfs` is easier than typing the full path
3. **Make template shortcuts** for your most-used workflows
4. **Use tab completion** - most shells support it after you type `wf `

## Troubleshooting

### "Command not found" after adding aliases

Make sure you:
1. Added aliases to the correct file (`~/.zshrc` for Zsh, `~/.bashrc` for Bash)
2. Reloaded the file with `source ~/.zshrc` or `source ~/.bashrc`
3. Have the correct path to your repository

### Finding your shell

Not sure which shell you're using?
```bash
echo $SHELL
```

Output:
- `/bin/zsh` or `/usr/bin/zsh` → Use Zsh instructions
- `/bin/bash` or `/usr/bin/bash` → Use Bash instructions

### Testing without permanent changes

Try the alias without adding to config file:
```bash
alias wfs='cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI && ./scripts/workflow_tracker.py status'
wfs
```

If it works, add it to your config file permanently.

## Example Daily Usage

```bash
# Morning
$ wfs
📋 Current Task: Content Generation Workflow
📊 Progress: 5/8 steps completed
📝 Steps:
  ...

# Complete next step
$ wf complete-step 5
✅ Completed step: Review and validate AI-generated output

# Check progress
$ wfs
📊 Progress: 6/8 steps completed

# Continue working...
```

Much easier than typing the full command every time!
