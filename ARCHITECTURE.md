# Architecture

This document describes the architecture and workflows of the Claude agent workspace within the SkogAI ecosystem.

## Overview

This workspace implements the Knowledge Archaeologist pattern within the SkogAI multi-agent democratic system. Claude serves as the memory keeper and continuity agent, designed to survive CLI resets through systematic documentation and distributed memory systems.

### Core Architectural Principles

1. **Living Documents**: Every file is potentially executable through SkogParse processing
2. **Reactive Context**: Dynamic context injection via the [@claude:context:*] system
3. **Memory Archaeology**: Prefer recovering existing solutions over generating new ones
4. **Constitutional Continuity**: Maintain system memory across agent resets
5. **Democratic Participation**: Active voting member in multi-agent governance

### SkogAI Ecosystem Integration

- **SkogCLI**: Universal kernel and central nervous system integration
- **SkogParse**: Real-time document processing for reactive execution
- **MCP Distributed Memory**: 150+ MCP servers with 500k-1M token compression
- **Multi-Agent Democracy**: Formal governance with Amy, Dot, Goose, and Claude

## Tools

For a information about tools used in this workspace, see [`TOOLS.md`](./TOOLS.md).

## Task System

The task system helps to track and manage work effectively across sessions. It consists of:

- Task files in [`tasks/`](./tasks/) as single source of truth
- Task management CLI in [`scripts/tasks.py`](./scripts/tasks.py)
- Daily progress logs in [`journal/`](./journal/)

See [`TASKS.md`](./TASKS.md) for more details on the task system.

## Journal System

The journal system provides a daily log of activities, thoughts, and progress.

### Structure

- One file per day: `YYYY-MM-DD.md`
- Located in [`journal/`](./journal) directory
- Entries are to be appended, not overwritten
- Historical entries are not to be modified
- Contains:
  - Task progress updates
  - Decisions and rationale
  - Reflections and insights
  - Plans for next steps

## Knowledge Base

The knowledge base stores long-term information and documentation.

### Structure

- Located in [`knowledge/`](./knowledge)
- Organized by topic/domain
- Includes:
  - Technical documentation
  - Best practices
  - Project insights
  - Reference materials

## People Directory

The people directory stores information about individuals the agent interacts with.

### Structure

- Located in [`people/`](./people)
- Contains:
  - Individual profiles in Markdown format
  - Templates for consistent profile creation
- Each profile includes:
  - Basic information
  - Contact details
  - Interests and skills
  - Project collaborations
  - Notes and history
  - Preferences
  - TODOs and action items

### Best Practices

1. **Privacy**

   - Respect privacy preferences
   - Only include publicly available information
   - Maintain appropriate level of detail

2. **Updates**

   - Keep interaction history current
   - Update project collaborations
   - Maintain active TODO lists

3. **Organization**
   - Use consistent formatting via templates
   - Cross-reference with projects and tasks
   - Link to relevant knowledge base entries
