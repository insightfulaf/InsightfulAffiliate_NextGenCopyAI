# Workflow Tracker Example Usage

## Scenario: Daily Content Generation

This example shows how the Workflow Tracker helps you stay organized during a typical content generation task.

### Morning - Starting Your Day

**Problem**: You sit down to work but can't remember what you were doing yesterday.

**Solution**: Check your workflow tracker status

```bash
$ ./scripts/workflow_tracker.py status
📋 No active task

Start a new task with: workflow_tracker.py start "Task name"
Or load a template with: workflow_tracker.py load-template <template-name>
```

Since there's no active task, you decide to start a new content generation workflow.

### Loading a Workflow Template

**Action**: Load the pre-built content generation template

```bash
$ ./scripts/workflow_tracker.py load-template content-generation
✅ Started task: Content Generation Workflow
📅 Started at: 2026-02-02T10:30:00
✅ Loaded template: Content Generation Workflow
📝 Added 8 steps

Use 'status' to see all steps
```

**Result**: You now have a structured checklist to follow!

```bash
$ ./scripts/workflow_tracker.py status
📋 Current Task: Content Generation Workflow
📅 Started: 2026-02-02T10:30:00

📝 Context:
  template: content-generation
  description: Generate AI-powered content using agent_codex.py

📊 Progress: 0/8 steps completed

📝 Steps:
  0. ⬜ Create or update prompt template in prompts/
  1. ⬜ Prepare input content in appropriate directory
  2. ⬜ Test with --provider echo --dry-run
  3. ⬜ Review test output for quality
  4. ⬜ Run production with --provider openai
  5. ⬜ Review and validate AI-generated output
  6. ⬜ Move validated content to final location
  7. ⬜ Commit changes with descriptive message
```

### Working Through Steps

**Step 0: Create Prompt Template**

You create a new prompt template file:

```bash
# Create prompt file
vim prompts/generate_product_descriptions.txt

# Mark step complete
$ ./scripts/workflow_tracker.py complete-step 0
✅ Completed step: Create or update prompt template in prompts/
```

**Step 1: Prepare Input Content**

You organize your input files:

```bash
# Organize input files
mkdir -p copywriting/product_specs
cp ~/Desktop/new_products/*.txt copywriting/product_specs/

# Mark complete
$ ./scripts/workflow_tracker.py complete-step 1
✅ Completed step: Prepare input content in appropriate directory
```

**Check Progress Mid-Morning**

```bash
$ ./scripts/workflow_tracker.py status
📋 Current Task: Content Generation Workflow
📅 Started: 2026-02-02T10:30:00

📝 Context:
  template: content-generation
  description: Generate AI-powered content using agent_codex.py

📊 Progress: 2/8 steps completed

📝 Steps:
  0. ✅ Create or update prompt template in prompts/
     Completed: 2026-02-02T10:35:00
  1. ✅ Prepare input content in appropriate directory
     Completed: 2026-02-02T10:42:00
  2. ⬜ Test with --provider echo --dry-run
  3. ⬜ Run production with --provider openai
  4. ⬜ Review and validate AI-generated output
  5. ⬜ Move validated content to final location
  6. ⬜ Commit changes with descriptive message
```

### Interruption - You Have to Step Away

**Problem**: You get a phone call and have to step away from your computer.

**Solution**: Your workflow state is saved! When you return:

```bash
$ ./scripts/workflow_tracker.py status
```

You immediately see what you were working on and what's next: "Test with --provider echo --dry-run"

### Continuing After Lunch

**Step 2: Test with Echo Provider**

```bash
# Run test
./scripts/agent_codex.py \
  --prompt ./prompts/generate_product_descriptions.txt \
  --input ./copywriting/product_specs \
  --output ./docs/ai_outputs/test \
  --provider echo \
  --dry-run

# Mark complete
$ ./scripts/workflow_tracker.py complete-step 2
✅ Completed step: Test with --provider echo --dry-run
```

**Step 3: Review Test Output**

```bash
# Review output files
ls -la docs/ai_outputs/test/
cat docs/ai_outputs/test/product1.txt.out.md

# Looks good! Mark complete
$ ./scripts/workflow_tracker.py complete-step 3
✅ Completed step: Review test output for quality
```

**Step 4: Run Production with OpenAI**

```bash
# Run production generation
./scripts/agent_codex.py \
  --prompt ./prompts/generate_product_descriptions.txt \
  --input ./copywriting/product_specs \
  --output ./docs/ai_outputs/products \
  --provider openai \
  --model gpt-4o-mini

# Mark complete
$ ./scripts/workflow_tracker.py complete-step 4
✅ Completed step: Run production with --provider openai
```

### End of Day - Not Quite Finished

It's 5 PM and you haven't finished all the steps. Check your status:

```bash
$ ./scripts/workflow_tracker.py status
📋 Current Task: Content Generation Workflow
📅 Started: 2026-02-02T10:30:00

📊 Progress: 5/8 steps completed

📝 Steps:
  0. ✅ Create or update prompt template in prompts/
  1. ✅ Prepare input content in appropriate directory
  2. ✅ Test with --provider echo --dry-run
  3. ✅ Review test output for quality
  4. ✅ Run production with --provider openai
  5. ⬜ Review and validate AI-generated output
  6. ⬜ Move validated content to final location
  7. ⬜ Commit changes with descriptive message
```

**Perfect!** You can see exactly where to pick up tomorrow. Just leave it as-is - don't finish the task yet.

### Next Morning - Picking Up Where You Left Off

```bash
$ ./scripts/workflow_tracker.py status
📋 Current Task: Content Generation Workflow
📅 Started: 2026-02-02T10:30:00

📊 Progress: 5/8 steps completed

📝 Steps:
  0. ✅ Create or update prompt template in prompts/
  1. ✅ Prepare input content in appropriate directory
  2. ✅ Test with --provider echo --dry-run
  3. ✅ Review test output for quality
  4. ✅ Run production with --provider openai
  5. ⬜ Review and validate AI-generated output        ← START HERE
  6. ⬜ Move validated content to final location
  7. ⬜ Commit changes with descriptive message
```

**You know exactly what to do next!** No time wasted trying to remember where you were.

### Completing the Task

**Step 5: Review and Validate Output**

```bash
# Review AI-generated content
for file in docs/ai_outputs/products/*.out.md; do
  echo "=== $file ==="
  cat "$file"
done

# Looks great! Mark complete
$ ./scripts/workflow_tracker.py complete-step 5
✅ Completed step: Review and validate AI-generated output
```

**Step 6: Move to Final Location**

```bash
# Move validated content to production location
mv docs/ai_outputs/products/*.out.md copywriting/product_pages/

# Mark complete
$ ./scripts/workflow_tracker.py complete-step 6
✅ Completed step: Move validated content to final location
```

**Step 7: Commit Changes**

```bash
# Commit to git
git add copywriting/product_pages/
git commit -m "Add new product descriptions generated with AI"
git push

# Mark complete
$ ./scripts/workflow_tracker.py complete-step 7
✅ Completed step: Commit changes with descriptive message
```

### Finishing the Task

All steps are complete! Finish the task:

```bash
$ ./scripts/workflow_tracker.py finish
✅ Task completed: Content Generation Workflow
📅 Finished at: 2026-02-03T09:45:00
```

The task is now moved to your history.

### Reviewing Your Work

Check what you've accomplished:

```bash
$ ./scripts/workflow_tracker.py history
📜 Workflow History (last 10 tasks):

Task: Content Generation Workflow
  Started: 2026-02-02T10:30:00
  Finished: 2026-02-03T09:45:00
  Completion: 8/8 steps
```

## Benefits Demonstrated

1. **Never Lose Your Place**: Status is saved between sessions
2. **Structured Approach**: Templates ensure you don't skip important steps
3. **Clear Progress Tracking**: Always know what's done and what's next
4. **Easy Resume**: Pick up exactly where you left off after interruptions
5. **Work History**: See what you've accomplished over time

## Real-World Tips

### Multiple Interruptions

If you get interrupted multiple times throughout the day:
- **Don't worry!** Just run `status` when you return
- Your exact progress is always saved
- No need to remember what step you were on

### Long-Running Tasks

For tasks that span multiple days:
- Leave the task active (don't finish it)
- Check `status` each morning
- Complete steps incrementally
- Finish only when fully done

### Ad-Hoc Steps

If you think of additional steps while working:
```bash
./scripts/workflow_tracker.py add-step "Send preview to client"
./scripts/workflow_tracker.py add-step "Make requested edits"
```

### Parallel Work

If you need to switch between tasks:
- Finish current task first, or
- Accept the warning and track side work elsewhere
- Return to main task later

## Comparison: Before and After

### Before Workflow Tracker

**Problems:**
- "What was I working on yesterday?"
- "Did I test with echo before running production?"
- "What's left to do on this task?"
- "I think I'm done... did I commit the changes?"

**Result:** Wasted time, skipped steps, incomplete work

### After Workflow Tracker

**Benefits:**
- Clear task context at all times
- Structured checklist ensures nothing is missed
- Progress tracking shows what's done and what's next
- Complete work history for reference

**Result:** Efficient, consistent, complete work

## Try It Yourself!

Start tracking your next task:

```bash
# See available templates
./scripts/workflow_tracker.py templates

# Pick one and try it
./scripts/workflow_tracker.py load-template landing-page-creation

# Work through the steps
./scripts/workflow_tracker.py status
./scripts/workflow_tracker.py complete-step 0
# ... continue ...
```

You'll wonder how you ever worked without it!
