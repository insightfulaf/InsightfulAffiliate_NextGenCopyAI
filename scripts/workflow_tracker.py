#!/usr/bin/env python3
"""
Workflow Tracker - Keep track of your repository workflow steps

This script helps solo developers track their current tasks, workflow steps,
and progress on content generation and repository maintenance activities.

Usage:
    # Show current status
    ./scripts/workflow_tracker.py status

    # Start a new task
    ./scripts/workflow_tracker.py start "Generate landing page copy"

    # Add a step to current task
    ./scripts/workflow_tracker.py add-step "Create prompt template"

    # Complete a step
    ./scripts/workflow_tracker.py complete-step 0

    # Show all available workflow templates
    ./scripts/workflow_tracker.py templates

    # Load a workflow template
    ./scripts/workflow_tracker.py load-template content-generation

    # Finish current task
    ./scripts/workflow_tracker.py finish

    # Show history
    ./scripts/workflow_tracker.py history
"""

import argparse
import json
import os
import sys
import tempfile
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

# Workflow templates for common repository tasks
WORKFLOW_TEMPLATES = {
    "content-generation": {
        "name": "Content Generation Workflow",
        "description": "Generate AI-powered content using agent_codex.py",
        "steps": [
            "Create or update prompt template in prompts/",
            "Prepare input content in appropriate directory",
            "Test with --provider echo --dry-run",
            "Review test output for quality",
            "Run production with --provider openai",
            "Review and validate AI-generated output",
            "Move validated content to final location",
            "Commit changes with descriptive message"
        ]
    },
    "landing-page-creation": {
        "name": "Landing Page Creation",
        "description": "Create new landing page or component for Systeme.io",
        "steps": [
            "Define landing page purpose and target audience",
            "Create HTML structure in landing_pages/",
            "Style with CSS in website_code_block_ORGANIZED/assets/",
            "Add brand-specific assets (logos, colors)",
            "Ensure mobile-responsive design",
            "Test relative links and asset references",
            "Add to funnel map with build_funnel_map.py",
            "Test paste-ready snippet in Systeme.io",
            "Commit and document usage"
        ]
    },
    "affiliate-compliance-check": {
        "name": "Affiliate Compliance Check",
        "description": "Verify FTC compliance for affiliate marketing content",
        "steps": [
            "Review content for affiliate links",
            "Verify disclosure statements are present and clear",
            "Check affiliate link tracking is properly configured",
            "Validate links in docs/affiliate_links/",
            "Test affiliate link functionality",
            "Document affiliate relationships",
            "Update affiliate_links_mapping_FINAL.json if needed",
            "Run compliance check skill if available"
        ]
    },
    "repository-maintenance": {
        "name": "Repository Maintenance",
        "description": "Regular repository cleanup and organization",
        "steps": [
            "Check git status for uncommitted changes",
            "Review and clean up old branches",
            "Run security scans (scripts/security-check.sh)",
            "Update documentation if needed",
            "Check for outdated dependencies",
            "Clean up temporary files and outputs",
            "Archive completed work to Archive_ready_to_sync/",
            "Push changes and update remote"
        ]
    },
    "new-feature-development": {
        "name": "New Feature Development",
        "description": "Develop and integrate a new feature",
        "steps": [
            "Define feature requirements and scope",
            "Create feature branch",
            "Implement core functionality",
            "Add tests if applicable",
            "Update documentation",
            "Test locally",
            "Run security checks",
            "Create pull request",
            "Review and merge"
        ]
    },
    "content-review-and-publish": {
        "name": "Content Review and Publish",
        "description": "Review and publish content to production",
        "steps": [
            "Review draft content for quality and accuracy",
            "Check brand voice consistency",
            "Verify all links work correctly",
            "Run pre-publish checklist (docs/checklists/pre_publish.md)",
            "Check SEO metadata is complete",
            "Validate HTML structure and accessibility",
            "Copy to Systeme.io following paste guide",
            "Test live version",
            "Update tracking documents"
        ]
    }
}


class WorkflowTracker:
    """Manages workflow tracking state and operations."""

    def __init__(self, workflow_dir: Path):
        self.workflow_dir = workflow_dir
        self.workflow_dir.mkdir(parents=True, exist_ok=True)
        self.status_file = workflow_dir / "current_status.json"
        self.history_file = workflow_dir / "history.json"

    def load_status(self) -> Dict:
        """Load current workflow status."""
        if not self.status_file.exists():
            return {
                "current_task": None,
                "steps": [],
                "started_at": None,
                "context": {}
            }
        
        try:
            with open(self.status_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        except (json.JSONDecodeError, UnicodeDecodeError) as e:
            # If the status file is corrupted or has invalid encoding,
            # reset it to a clean default state instead of raising.
            print(
                f"⚠️  Warning: Could not read status from {self.status_file} "
                "- the file appears to be invalid JSON or improperly encoded. "
                "Resetting workflow status."
            )
            default_status = {
                "current_task": None,
                "steps": [],
                "started_at": None,
                "context": {}
            }
            self.save_status(default_status)
            return default_status

    def save_status(self, status: Dict) -> None:
        """Save current workflow status atomically."""
        self.status_file.parent.mkdir(parents=True, exist_ok=True)
        # Use atomic write to prevent corruption if interrupted
        with tempfile.NamedTemporaryFile(
            mode='w',
            encoding='utf-8',
            delete=False,
            dir=str(self.status_file.parent),
            suffix='.tmp'
        ) as tmp:
            json.dump(status, tmp, indent=2)
            tmp.flush()
            os.fsync(tmp.fileno())
            tmp_path = Path(tmp.name)
        tmp_path.replace(self.status_file)

    def load_history(self) -> List[Dict]:
        """Load workflow history."""
        if not self.history_file.exists():
            return []
        
        try:
            with open(self.history_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        except (json.JSONDecodeError, UnicodeDecodeError) as e:
            # If the history file is corrupted or has invalid encoding,
            # reset it to an empty history instead of raising.
            print(
                f"⚠️  Warning: Could not read history from {self.history_file} "
                "- the file appears to be invalid JSON or improperly encoded. "
                "Resetting workflow history."
            )
            empty_history: List[Dict] = []
            self.save_history(empty_history)
            return empty_history

    def save_history(self, history: List[Dict]) -> None:
        """Save workflow history atomically."""
        self.history_file.parent.mkdir(parents=True, exist_ok=True)
        # Use atomic write to prevent corruption if interrupted
        with tempfile.NamedTemporaryFile(
            mode='w',
            encoding='utf-8',
            delete=False,
            dir=str(self.history_file.parent),
            suffix='.tmp'
        ) as tmp:
            json.dump(history, tmp, indent=2)
            tmp.flush()
            os.fsync(tmp.fileno())
            tmp_path = Path(tmp.name)
        tmp_path.replace(self.history_file)

    def start_task(self, task_name: str, context: Optional[Dict] = None) -> None:
        """Start a new task."""
        status = self.load_status()
        
        # If there's a current task, warn the user
        if status["current_task"]:
            print(f"⚠️  Warning: You have an active task: {status['current_task']}")
            response = input("Do you want to finish it first? (y/n): ")
            if response.lower() == 'y':
                self.finish_task()
                status = self.load_status()
            else:
                print("Continuing with current task. Use 'finish' to complete it first.")
                return

        status["current_task"] = task_name
        status["steps"] = []
        status["started_at"] = datetime.now().isoformat()
        status["context"] = context or {}
        
        self.save_status(status)
        print(f"✅ Started task: {task_name}")
        print(f"📅 Started at: {status['started_at']}")

    def add_step(self, step_description: str, completed: bool = False) -> None:
        """Add a step to the current task."""
        status = self.load_status()
        
        if not status["current_task"]:
            script_name = os.path.basename(sys.argv[0])
            print(f"❌ No active task. Start a task first with: {script_name} start \"Task name\"")
            return

        step = {
            "description": step_description,
            "completed": completed,
            "added_at": datetime.now().isoformat(),
            "completed_at": None
        }
        
        status["steps"].append(step)
        self.save_status(status)
        
        print(f"✅ Added step: {step_description}")

    def complete_step(self, step_index: int) -> None:
        """Mark a step as completed."""
        status = self.load_status()
        
        if not status["current_task"]:
            print("❌ No active task.")
            return

        if step_index < 0 or step_index >= len(status["steps"]):
            print(f"❌ Invalid step index. Must be between 0 and {len(status['steps']) - 1}")
            return

        status["steps"][step_index]["completed"] = True
        status["steps"][step_index]["completed_at"] = datetime.now().isoformat()
        
        self.save_status(status)
        print(f"✅ Completed step: {status['steps'][step_index]['description']}")

    def finish_task(self) -> None:
        """Finish the current task and move it to history."""
        status = self.load_status()
        
        if not status["current_task"]:
            print("❌ No active task to finish.")
            return

        # Check if all steps are completed
        incomplete_steps = [s for s in status["steps"] if not s["completed"]]
        if incomplete_steps:
            print(f"⚠️  Warning: {len(incomplete_steps)} steps are not completed:")
            for i, step in enumerate(status["steps"]):
                if not step["completed"]:
                    print(f"  - {step['description']}")
            
            response = input("Do you want to finish anyway? (y/n): ")
            if response.lower() != 'y':
                print("Task not finished. Complete remaining steps first.")
                return

        # Move to history
        history = self.load_history()
        history_entry = {
            "task": status["current_task"],
            "steps": status["steps"],
            "started_at": status["started_at"],
            "finished_at": datetime.now().isoformat(),
            "context": status["context"]
        }
        history.append(history_entry)
        self.save_history(history)

        # Clear current status
        status["current_task"] = None
        status["steps"] = []
        status["started_at"] = None
        status["context"] = {}
        self.save_status(status)

        print(f"✅ Task completed: {history_entry['task']}")
        print(f"📅 Finished at: {history_entry['finished_at']}")

    def show_status(self) -> None:
        """Display current workflow status."""
        status = self.load_status()
        
        script_name = os.path.basename(sys.argv[0])
        
        if not status["current_task"]:
            print("📋 No active task")
            print(f"\nStart a new task with: {script_name} start \"Task name\"")
            print(f"Or load a template with: {script_name} load-template <template-name>")
            return

        print(f"📋 Current Task: {status['current_task']}")
        print(f"📅 Started: {status['started_at']}")
        
        if status["context"]:
            print("\n📝 Context:")
            for key, value in status["context"].items():
                print(f"  {key}: {value}")

        if status["steps"]:
            print(f"\n📊 Progress: {sum(1 for s in status['steps'] if s['completed'])}/{len(status['steps'])} steps completed")
            print("\n📝 Steps:")
            for i, step in enumerate(status["steps"]):
                status_icon = "✅" if step["completed"] else "⬜"
                print(f"  {i}. {status_icon} {step['description']}")
                if step["completed"] and step["completed_at"]:
                    print(f"     Completed: {step['completed_at']}")
        else:
            print(f"\n📝 No steps yet. Add steps with: {script_name} add-step \"Step description\"")

    def show_history(self, limit: int = 10) -> None:
        """Display workflow history."""
        history = self.load_history()
        
        if not history:
            print("📜 No workflow history yet.")
            return

        print(f"📜 Workflow History (last {limit} tasks):\n")
        
        for entry in history[-limit:]:
            completed_steps = sum(1 for s in entry["steps"] if s["completed"])
            total_steps = len(entry["steps"])
            
            print(f"Task: {entry['task']}")
            print(f"  Started: {entry['started_at']}")
            print(f"  Finished: {entry['finished_at']}")
            print(f"  Completion: {completed_steps}/{total_steps} steps")
            print()

    def show_templates(self) -> None:
        """Display available workflow templates."""
        print("📚 Available Workflow Templates:\n")
        
        for template_id, template in WORKFLOW_TEMPLATES.items():
            print(f"🔹 {template_id}")
            print(f"  Name: {template['name']}")
            print(f"  Description: {template['description']}")
            print(f"  Steps: {len(template['steps'])}")
            print()

    def load_template(self, template_id: str) -> None:
        """Load a workflow template."""
        if template_id not in WORKFLOW_TEMPLATES:
            print(f"❌ Template '{template_id}' not found.")
            print("\nAvailable templates:")
            self.show_templates()
            return

        template = WORKFLOW_TEMPLATES[template_id]
        
        # Start the task
        self.start_task(
            template["name"],
            context={"template": template_id, "description": template["description"]}
        )

        # Add all steps from template
        status = self.load_status()
        for step_description in template["steps"]:
            step = {
                "description": step_description,
                "completed": False,
                "added_at": datetime.now().isoformat(),
                "completed_at": None
            }
            status["steps"].append(step)
        
        self.save_status(status)
        
        print(f"✅ Loaded template: {template['name']}")
        print(f"📝 Added {len(template['steps'])} steps")
        print("\nUse 'status' to see all steps")


def main():
    """Main CLI interface."""
    parser = argparse.ArgumentParser(
        description="Workflow Tracker - Keep track of your repository workflow steps",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Show current status
  %(prog)s status

  # Start a new task
  %(prog)s start "Generate landing page copy"

  # Load a workflow template
  %(prog)s load-template content-generation

  # Add a step
  %(prog)s add-step "Create prompt template"

  # Complete a step
  %(prog)s complete-step 0

  # Finish current task
  %(prog)s finish
        """
    )

    subparsers = parser.add_subparsers(dest="command", help="Command to execute")

    # Status command
    subparsers.add_parser("status", help="Show current workflow status")

    # Start command
    start_parser = subparsers.add_parser("start", help="Start a new task")
    start_parser.add_argument("task_name", help="Name of the task")

    # Add step command
    add_step_parser = subparsers.add_parser("add-step", help="Add a step to current task")
    add_step_parser.add_argument("step_description", help="Description of the step")

    # Complete step command
    complete_parser = subparsers.add_parser("complete-step", help="Mark a step as completed")
    complete_parser.add_argument("step_index", type=int, help="Index of the step to complete")

    # Finish command
    subparsers.add_parser("finish", help="Finish current task")

    # History command
    history_parser = subparsers.add_parser("history", help="Show workflow history")
    history_parser.add_argument("--limit", type=int, default=10, help="Number of tasks to show")

    # Templates command
    subparsers.add_parser("templates", help="Show available workflow templates")

    # Load template command
    load_parser = subparsers.add_parser("load-template", help="Load a workflow template")
    load_parser.add_argument("template_id", help="ID of the template to load")

    args = parser.parse_args()

    # Find repository root
    repo_root = Path.cwd()
    while repo_root != repo_root.parent:
        if (repo_root / ".git").exists():
            break
        repo_root = repo_root.parent
    else:
        print("❌ Not in a git repository")
        sys.exit(1)

    workflow_dir = repo_root / ".workflow"
    tracker = WorkflowTracker(workflow_dir)

    # Execute command
    if args.command == "status" or args.command is None:
        tracker.show_status()
    elif args.command == "start":
        tracker.start_task(args.task_name)
    elif args.command == "add-step":
        tracker.add_step(args.step_description)
    elif args.command == "complete-step":
        tracker.complete_step(args.step_index)
    elif args.command == "finish":
        tracker.finish_task()
    elif args.command == "history":
        tracker.show_history(args.limit)
    elif args.command == "templates":
        tracker.show_templates()
    elif args.command == "load-template":
        tracker.load_template(args.template_id)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
