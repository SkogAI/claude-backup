# skogcontext Plan

## Project Overview

**skogcontext** is a modular context generation framework that replaces the legacy SkogAI monolithic context system. It provides the infrastructure for AI agents to generate exactly
the contextual information they need for LLM interactions.

## Core Problem

The old SkogAI system simply appended information chunks to `./tmp/context.md` in a hardcoded, monolithic way. With modern AI capabilities and tools, we need a flexible framework
that allows agents to compose their own context generation strategies without overwhelming LLM context windows.

## Target Users

- AI agents within the SkogAI ecosystem
- No shared workspace requirements (agent-specific implementations)

## Design Principles

1. **Modular**: Framework supports pluggable context generation modules
2. **Extensible**: Easy for agents to add new context generation capabilities
3. **Simple**: Minimal complexity, clear interfaces
4. **Agent-Controlled**: Framework provides tools, agents decide implementation
5. **Standards-Based**: Uses argc for input standardization, `$LLM_OUTPUT` for output

## Framework Architecture

### Core Components

**skogcontext Framework**: The execution engine and standards definition

- Executes argc-compliant modules
- Manages environment variable configuration
- Enforces output standards (`$LLM_OUTPUT`)
- Produces final context output

### Standards

**Input Standard**: argc-annotated shell scripts

- Parameterized, reusable modules
- Everything AI is really bad at getting solved

**Output Standard**: `$LLM_OUTPUT` environment variable

- All module output directed to this variable
- Prevents AI from using stupid things with bash  
- Enables safe AI-generated script execution

**Configuration Standard**: Environment variables

- Agents provide module paths via `$ENV` variables
- Framework remains agnostic to specific modules
- Flexible, external configuration

### Two-Pattern Architecture

**Static Tools Pattern**:

- Pure functions with parameters (e.g., `tree-generator --path --depth`)
- Reusable across any context
- No agent-specific knowledge

**Agent Tools Pattern**:

- Agent-specific context objects with fields and methods
- Know their own paths, configurations, state
- Orchestrate static tools in agent-specific ways

## Framework Responsibilities

### What skogcontext DOES

- Provide execution engine for argc modules
- Define and enforce input/output standards
- Use environment variables to configure modules
- Generate final context output

## Legacy Compatibility

[@todo]

## Success Criteria

The framework succeeds when:

- Agents can easily create their own context generation workflows
- The system is simpler to extend than the old monolithic approach
- Standards enable universal deployment across all argc targets
- Context generation becomes agent-controlled rather than framework-controlled

## Key Insights

- **Agent Autonomy**: "That is up to the agent and their implementation - not anything we care about"
- **Framework Focus**: Provide tools, not implementations
- **Standards Over Features**: Clear interfaces matter more than specific capabilities
- **Context Precision**: Enable "only exactly the amount which is needed" without LLM context overflow

## Migration Strategy

Replace legacy hardcoded context scripts with argc-compliant modules while maintaining the same output format and environment variable interfaces that existing SkogAI agents expect.

---

Context Reduction Plan for Mini-Me (5-10k tokens)

Current Context Issues:

- CLAUDE.md includes @tmp/context and @tmp/context-feature but tmp/ is empty
  - yes that is what i'm trying to get help with

- TASKS.md (195 lines) is fully included - heavy documentation about task system
  -

- Context system tries to load missing tmp/context files

Plan to Reduce Token Usage:

1. Fix Broken Includes

- Remove @tmp/context and @tmp/context-feature from CLAUDE.md includes (files don't exist)
- This eliminates error noise and failed file lookups

2. Reduce TASKS.md Impact

- Either remove @TASKS.md from includes entirely (if not needed for next 2-3 messages)
- OR create a minimal version like TASKS-MINI.md with just the essential CLI commands

3. Keep Essential Context Only

- Keep @CLAUDE.md (core identity - recursive but needed)
- Keep core identity section (lines 1-15)
- Keep uncertainty principle (lines 41-51)

4. Result: Clean Minimal Context

Mini-me will have:

- Core identity (~200 tokens)
- Essential tools knowledge (tools.sh stays accessible via argc)  
- No broken file references
- No heavy documentation unless actively needed

Token savings: ~3000-4000 tokens by removing TASKS.md and fixing broken includes

Should we proceed with this focused reduction?
