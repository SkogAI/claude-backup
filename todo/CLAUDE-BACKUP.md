# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Important Files

@README.md
@SKOGAI.md
@RULES.md

## Important Context Injections

@tmp/context
@tmp/context-feature
@tmp/release-diff
.skogai/CLAUDE.md

## Common Development Commands

### Configuration Management
```bash
# Export environment variables for all namespaces
eval "$(skogcli config export-env --namespace skogai,claude,argc)"

# Manage SkogCLI configuration
skogcli config --help

# Manage scripts
skogcli script --help
```

### Tools & Agents System
```bash
# Navigate to tools directory for tool/agent development
cd tools/

# Build tools and agents
argc build

# Test tools and agents
argc test

# Generate function declarations
argc build-declarations

# Check environment and dependencies
argc check

# Run specific tool
argc tool:run <tool-name> <args>

# Run specific agent
argc agent:run <agent-name> <args>
```

### Context System
```bash
# Update context files (run from skogcontext/ or use skogcontext/update)
./update

# Generate context for current session
./run
```

### Task Management
```bash
# Initialize Task Master for project management
task-master init

# Parse PRD to generate tasks
task-master parse-prd
```

## Architecture Overview

### Multi-Repository Structure
SkogAI uses a modular architecture with key submodules:
- **tools/**: LLM functions and agents system (50+ tools, MCP integration)
- **skogcontext/**: Context injection system with git-flow integration
- **data/**: Knowledge management and chat history
- **docs/**: Documentation and agent memory system

### Agent-Tool Duality
- Every agent can be invoked as a tool via `[@agent:"query"]` notation
- Tools run in sandboxed environments with `$LLM_OUTPUT` for safe execution
- Universal compatibility across CLI, AI agents, web, and notation systems

### SkogAI Notation System
Core notation patterns:
- `[@agent:"query"]` - agent invocation
- `[@todo]` / `[@todo:owner]` - knowledge archaeology markers
- `$SKOGAI/path` - project-relative paths
- `[@set:"key":"value"]` - living computations that re-evaluate

### Configuration System
- **skogcli**: Python-based CLI for configuration, scripts, and agent management
- **config/config.json**: Environment variables and settings
- **scripts/**: Bash utilities managed by `skogcli script`

## Development Workflow

### Branch Management
Uses git-flow with context integration:
```bash
# Feature development with documentation
./run-feature-start.sh <name>    # Creates feature branch + .llm directories
# ... work on feature ...
./run-feature-finish.sh          # Merges to develop + cleanup

# Release workflow
./run-release-start.sh <version>  # Create release branch
./run-release-finish.sh          # Tag and merge to master
```

### Context System Integration
- `./run` opens Claude Code with updated context
- `tmp/context*` files provide dynamic git status and feature info
- Exit and re-run `./run` after external changes

## Testing
```bash
# Tools system tests
cd tools && argc test

# Test specific tool
argc tool:test <tool-name>

# Test specific agent  
argc agent:test <agent-name>
```

## Uncertainty Principle

The uncertainty principle requires claude to quantify and declare epistemic uncertainty:
- End each message with lowest confidence statement
- Format: `[@certainty:"<percentage>":"<specific claim>"]`
- Percentage: integer 0-99 representing confidence
- Aligns with core principle: "explicit uncertainty over false confidence"

## Placeholder Pattern

SkogAI uses `[@todo]` notation for knowledge archaeology markers:
- `[@todo]` - general placeholder for future work
- `[@todo:owner]` - assigned placeholder (e.g., `[@todo:skogix]`)
- Purpose: mark integration points before implementation
- Philosophy: recover existing solutions before generating new
- Represents living computation - re-evaluates on access

## Infrastructure

### Supabase Agent Database
- **Project**: SkogAI (wwjzyyszcjzgygdwbfls)
- **Region**: eu-north-1
- **URL**: https://wwjzyyszcjzgygdwbfls.supabase.co
- **Tables**: agent_logs, knowledge_base, agent_tasks, events, conversation_context, artifacts, agent_configs, metrics
- **Status**: initialized and tested
- **MCP-database**: configured in `/home/skogix/git-fuckery/mcp-database/`
