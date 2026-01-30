# VS Code Workspace Optimization Guide

## Overview

This guide helps you optimize your VS Code workspace setup for the InsightfulAffiliate_NextGenCopyAI repository to minimize RAM/memory usage while maintaining productivity.

## Understanding VS Code Workspaces vs Folders

### Single Folder Mode
- **What it is**: Opening a single folder in VS Code
- **Best for**: Simple projects, quick edits, minimal overhead
- **Memory impact**: Lowest - only indexes one folder
- **How to use**: `File → Open Folder` or `code /path/to/folder`

### Multi-Root Workspace Mode
- **What it is**: Opening multiple folders in one VS Code window using a `.code-workspace` file
- **Best for**: Monorepos, related projects, complex setups
- **Memory impact**: Higher - indexes all folders simultaneously
- **How to use**: `File → Open Workspace from File` or `code workspace.code-workspace`

## Current Repository Analysis

### Size Breakdown
```
Total Repository: 49MB
├── Archive_ready_to_sync/  28MB  (archived backups)
├── docs/                   5MB   (documentation)
├── assets/                 4.3MB (images, logos, icons)
├── Prompt_to_Profit.../    120KB (playbook)
├── website_code.../        104KB (web components)
├── Other directories       <100KB each
```

### Memory Impact Assessment
- **Low impact**: scripts/, copywriting/, landing_pages/ (mostly text files)
- **Medium impact**: assets/ (images, but needed for work)
- **High impact**: Archive_ready_to_sync/ (28MB of archived content)
- **Variable impact**: docs/ (5MB, mostly markdown with some PDFs)

## Recommended Workspace Configuration

### Option 1: Single Folder (Recommended for Most Users)

**Best for**: Daily work, content editing, script development

Simply open the repository root folder:
```bash
code ~/Dropbox/InsightfulAffiliate_NextGenCopyAI
```

**Memory optimization**: Use `.vscode/settings.json` to exclude heavy directories:

```json
{
  "files.exclude": {
    "archive": true,
    "Archive_ready_to_sync": true,
    "**/.venv": true,
    "**/__pycache__": true,
    "**/.git": true,
    "**/node_modules": true,
    "**/.DS_Store": true
  },
  "search.exclude": {
    "Archive_ready_to_sync/**": true,
    "archive/**": true,
    "**/node_modules": true,
    "**/.venv": true,
    "**/__pycache__": true,
    "**/dist": true,
    "**/build": true
  },
  "files.watcherExclude": {
    "**/.git/objects/**": true,
    "**/.git/subtree-cache/**": true,
    "**/node_modules/**": true,
    "**/.venv/**": true,
    "**/Archive_ready_to_sync/**": true,
    "**/archive/**": true
  }
}
```

### Option 2: Optimized Multi-Root Workspace

**Best for**: When you need to work across multiple related repositories

Create a workspace file that excludes heavy directories:

```json
{
  "folders": [
    {
      "path": ".",
      "name": "IA/NGCAI - Main"
    }
  ],
  "settings": {
    "files.exclude": {
      "archive": true,
      "Archive_ready_to_sync": true,
      "**/.venv": true,
      "**/__pycache__": true,
      "**/.git": true
    },
    "search.exclude": {
      "Archive_ready_to_sync/**": true,
      "archive/**": true,
      "**/node_modules": true,
      "**/.venv": true,
      "**/__pycache__": true
    },
    "files.watcherExclude": {
      "**/.git/objects/**": true,
      "**/node_modules/**": true,
      "**/.venv/**": true,
      "**/Archive_ready_to_sync/**": true,
      "**/archive/**": true
    },
    "python.defaultInterpreterPath": ".venv-1/bin/python",
    "editor.formatOnSave": false
  }
}
```

## Memory Optimization Strategies

### 1. File Watcher Optimization
File watchers consume significant memory. Exclude unnecessary directories:

```json
{
  "files.watcherExclude": {
    "**/.git/objects/**": true,
    "**/.git/subtree-cache/**": true,
    "**/node_modules/**": true,
    "**/.venv/**": true,
    "**/Archive_ready_to_sync/**": true,
    "**/archive/**": true,
    "**/__pycache__/**": true,
    "**/dist/**": true,
    "**/build/**": true
  }
}
```

### 2. Search Indexing Optimization
Prevent VS Code from indexing archived and generated content:

```json
{
  "search.exclude": {
    "Archive_ready_to_sync/**": true,
    "archive/**": true,
    "**/node_modules": true,
    "**/.venv": true,
    "**/__pycache__": true,
    "**/.git": true,
    "**/dist": true,
    "**/build": true,
    "docs/ai_outputs/ai_outputs/**": true
  }
}
```

### 3. Extension Management
Disable or uninstall extensions you're not actively using:

**Essential extensions for this repo**:
- Prettier (esbenp.prettier-vscode) - Code formatting
- Python (ms-python.python) - Python development
- Live Server (ritwickdey.LiveServer) - HTML preview
- GitHub Copilot (github.copilot) - AI assistance

**Optional but recommended**:
- GitLens - Git visualization
- Markdown All in One - Enhanced markdown editing

**Consider disabling**:
- Heavy extensions you don't use daily
- Language extensions for languages not in this repo

### 4. TypeScript/JavaScript Optimization
If you're not working with TS/JS files, reduce their memory overhead:

```json
{
  "typescript.tsc.autoDetect": "off",
  "javascript.suggest.enabled": false,
  "typescript.suggest.enabled": false
}
```

### 5. Git Operations Optimization
For this large repository with archives:

```json
{
  "git.enabled": true,
  "git.autofetch": false,
  "git.autorefresh": true,
  "git.decorations.enabled": true
}
```

## Best Practices

### DO's ✅
1. **Use Single Folder mode** unless you specifically need multi-root workspaces
2. **Exclude archived directories** from file watchers and search
3. **Close unused editor tabs** regularly (they consume memory)
4. **Restart VS Code** periodically (weekly) to clear memory leaks
5. **Use Git from terminal** for complex operations to avoid VS Code's Git overhead
6. **Keep extensions minimal** - only install what you actively use
7. **Use workspace settings** for project-specific configuration

### DON'Ts ❌
1. **Don't open multiple workspace windows** of the same repository
2. **Don't enable auto-fetch** on large repositories (use manual fetch)
3. **Don't leave unused extensions enabled** globally
4. **Don't index the Archive_ready_to_sync folder** (it's 28MB of old backups)
5. **Don't use "Open Recent"** to open archived project states
6. **Don't enable unnecessary file watchers** on generated content
7. **Don't use multi-root workspaces** unless you have multiple related repos

## Monitoring Memory Usage

### Check VS Code Memory Usage

**macOS**:
```bash
# View VS Code processes
ps aux | grep "Visual Studio Code"

# View memory usage
top -pid $(pgrep -f "Visual Studio Code Helper")
```

**Linux**:
```bash
# View VS Code processes
ps aux | grep code

# View memory usage
top -p $(pgrep -f code)
```

### VS Code Built-in Tools
1. Open Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`)
2. Run: `Developer: Startup Performance`
3. Check extension activation times and memory usage

## Recommended Workflow

### Daily Development Workflow
1. **Open the repository folder** (not workspace file)
2. **Work in specific directories** based on your task:
   - `scripts/` for Python automation
   - `copywriting/` for marketing content
   - `landing_pages/` for HTML work
   - `docs/` for documentation
3. **Use VS Code's integrated terminal** for Git operations
4. **Close tabs you're done with** to free memory
5. **Use Go to File** (`Cmd+P` / `Ctrl+P`) instead of browsing Explorer

### When to Use Workspace Files
Only use `.code-workspace` files when:
- Working across multiple related repositories simultaneously
- Need different settings for different folder roots
- Collaborating with team members who need the same structure

## Troubleshooting

### VS Code is Using Too Much Memory

**Solution 1: Restart with Clean State**
```bash
# Close VS Code completely
# Then open with:
code --disable-extensions ~/Dropbox/InsightfulAffiliate_NextGenCopyAI
# Re-enable extensions one by one to find the culprit
```

**Solution 2: Clear Extension Cache**
```bash
rm -rf ~/.vscode/extensions/*/.cache
rm -rf ~/Library/Application\ Support/Code/Cache/*  # macOS
rm -rf ~/.config/Code/Cache/*  # Linux
```

**Solution 3: Check for Runaway Processes**
- Open Command Palette → `Developer: Open Process Explorer`
- Identify high-memory extensions or language servers
- Disable problematic extensions

### File Explorer is Slow

**Cause**: Too many files being watched or indexed

**Solution**: Add more exclusions to `files.watcherExclude` and `search.exclude`

### Git Operations are Slow

**Cause**: Large repository with many files

**Solutions**:
1. Disable auto-refresh: `"git.autorefresh": false`
2. Disable decorations temporarily: `"git.decorations.enabled": false`
3. Use terminal Git for complex operations

## Migration Plan: Current Setup → Optimized Setup

### Step 1: Backup Current Configuration
```bash
cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI
cp .vscode/settings.json .vscode/settings.json.backup
cp ia-ngcai-main.code-workspace ia-ngcai-main.code-workspace.backup
```

### Step 2: Update VS Code Settings
1. Open `.vscode/settings.json`
2. Add the memory optimization settings from this guide
3. Save and reload VS Code window

### Step 3: Update or Replace Workspace File
1. Update `ia-ngcai-main.code-workspace` with optimized configuration
2. Or switch to single-folder mode (recommended)

### Step 4: Test and Verify
1. Open the repository in VS Code
2. Check memory usage (Activity Monitor / Task Manager)
3. Verify excluded folders don't appear in search results
4. Test that Git operations work normally

### Step 5: Monitor and Adjust
- Watch memory usage over a few days
- Adjust exclusions if needed
- Document what works best for your workflow

## Recommended Final Configuration

### For This Repository: Single Folder + Optimized Settings

**Do this**:
1. Close any open workspace files
2. Open just the repository folder: `code ~/Dropbox/InsightfulAffiliate_NextGenCopyAI`
3. Ensure `.vscode/settings.json` has the exclusions shown above
4. Keep the workspace file as a backup, but don't use it daily

**Expected results**:
- **Memory usage**: 200-400MB (vs 600-800MB with full indexing)
- **Startup time**: 2-3 seconds (vs 5-10 seconds)
- **Search speed**: Fast (only indexes active directories)
- **Git operations**: Responsive

## Summary

**Key Takeaways**:
1. **Use Single Folder mode** for this repository (not multi-root workspace)
2. **Exclude Archive_ready_to_sync** from all watchers and searches (saves 28MB)
3. **Exclude generated content** (ai_outputs nested directories)
4. **Disable auto-fetch** on Git
5. **Keep extensions minimal** and disable unused ones
6. **Restart VS Code weekly** to clear memory
7. **Use terminal for Git** when doing complex operations

This setup will keep your VS Code responsive and your computer's memory available for other tasks!
