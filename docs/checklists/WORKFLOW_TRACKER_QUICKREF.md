# Workflow Tracker Quick Reference

## Basic Commands

```bash
# Check what you're working on
./scripts/workflow_tracker.py status

# Start a new task
./scripts/workflow_tracker.py start "Task description"

# Add a step to current task
./scripts/workflow_tracker.py add-step "Step description"

# Mark a step complete (use index from status)
./scripts/workflow_tracker.py complete-step 0

# Finish current task
./scripts/workflow_tracker.py finish

# View past tasks
./scripts/workflow_tracker.py history
```

## Using Templates

```bash
# List all available templates
./scripts/workflow_tracker.py templates

# Load a template to start a workflow
./scripts/workflow_tracker.py load-template content-generation
./scripts/workflow_tracker.py load-template landing-page-creation
./scripts/workflow_tracker.py load-template affiliate-compliance-check
./scripts/workflow_tracker.py load-template repository-maintenance
```

## Common Workflows

### Daily Content Generation

```bash
# Morning: Check status or start fresh
./scripts/workflow_tracker.py status
# OR
./scripts/workflow_tracker.py load-template content-generation

# As you work: Complete steps
./scripts/workflow_tracker.py complete-step 0
./scripts/workflow_tracker.py status

# End of day: Finish if done
./scripts/workflow_tracker.py finish
```

### Weekly Maintenance

```bash
# Start maintenance workflow
./scripts/workflow_tracker.py load-template repository-maintenance

# Work through steps throughout the week
./scripts/workflow_tracker.py status
./scripts/workflow_tracker.py complete-step 0
# ... continue with other steps

# Finish when complete
./scripts/workflow_tracker.py finish
```

### Custom Task

```bash
# Start your own task
./scripts/workflow_tracker.py start "Build email funnel"

# Add your specific steps
./scripts/workflow_tracker.py add-step "Design opt-in form"
./scripts/workflow_tracker.py add-step "Write confirmation email"
./scripts/workflow_tracker.py add-step "Create thank-you page"

# Complete as you go
./scripts/workflow_tracker.py complete-step 0
./scripts/workflow_tracker.py status
```

## Tips

- **Morning routine**: `./scripts/workflow_tracker.py status` to see where you left off
- **Use templates**: Load a template for structured workflows
- **Check progress**: Run `status` anytime to see what's next
- **Finish tasks**: Move completed work to history with `finish`
- **Review history**: See what you've accomplished with `history`

## Help

```bash
# General help
./scripts/workflow_tracker.py --help

# Command-specific help
./scripts/workflow_tracker.py start --help
./scripts/workflow_tracker.py complete-step --help
```

## Full Documentation

See [Workflow Tracker Guide](WORKFLOW_TRACKER_GUIDE.md) for complete documentation.
