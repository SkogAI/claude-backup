---
allowed-tools: Read, Bash(echo:*)
description: Quick context verification - check current feature, tasks, and memory status
argument-hint: 
---

# Context Check Command

Quickly verify current context including feature branch, task status, and memory state.

## What it shows

- Current git feature branch and status
- Active/pending tasks from task system  
- Recent memory activity and key entities
- Environment and workspace status

## Implementation

I'll check the current context by reading:

@tmp/context-feature - Current feature branch info
@tmp/context - SkogAI context including tasks and memory
@CLAUDE.md - Local workspace context

Then provide a concise summary of:
- Where we are (branch, workspace)
- What we're working on (active tasks)
- Key context from memory system
- Any uncertainties or blockers

This helps with knowledge archaeology by quickly surfacing current state and active work streams.