---
allowed-tools: Bash(./scripts/tasks.py:*)
description: Quick access to task management system operations
argument-hint: [action] [args]
---

# Run Tasks Command

Quick access to the SkogAI task management system. Available actions:

- **status** - Show task status (supports --compact, --type)
- **list** - List all tasks (supports --sort state|date)  
- **show** - Show specific task details
- **edit** - Edit task metadata

## Usage Examples

```
/run-tasks status
/run-tasks status --compact
/run-tasks list --sort state
/run-tasks show my-task-id
/run-tasks edit my-task --set state active
```

## Implementation

Arguments: $ARGUMENTS

I'll execute the tasks.py script with your arguments:

!./scripts/tasks.py $ARGUMENTS

This provides direct access to:
- Task status monitoring 
- Task listing and filtering
- Individual task inspection
- Metadata updates

The task system tracks constitutional continuity across CLI resets and supports knowledge archaeology workflows.