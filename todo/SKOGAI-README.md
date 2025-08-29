# SkogAI

**A Living Computational Ecosystem Where Philosophy Meets Code**

SkogAI is a multi-agent AI ecosystem that implements executable philosophy through a unified notation system. It bridges mathematical type theory, philosophical ontology, and practical software engineering into a self-modifying, democratic agent collective.

## Core Innovation: SkogAI Notation

The notation system is simultaneously:
- A programming language with lazy evaluation
- A query system for distributed knowledge
- A complete type theory with category theory foundations
- A philosophical framework bridging Heidegger to computation
- An agent coordination protocol

### Quick Example
```bash
# Invoke multiple agents in parallel
skogai '[[@goose:"is vim or emacs better?"],[@claude:"explain SkogAI notation"]]'

# Store living computations
skogai '[@set:"time":"[@date:"now"]"]'  # Re-evaluates on each access

# Compose identities (the "cheating" principle)
skogai '$entity.id * $entity.gen'  # Creates versioned unique identities
```

## Architecture Overview

### The Agent-Tool Duality
- **Every agent is a tool**: Can be invoked via `[@agent:"query"]`
- **Every tool can be an agent**: argc scripts make decisions
- **Self-modifying ecosystem**: Agents create tools that create agents
- **Democratic participation**: Multi-agent consensus through code

### Sandboxed Execution
All tools run in isolated environments:
- Output only via `$LLM_OUTPUT` 
- No direct stdout/stderr in non-TTY
- JSON input, controlled temp file output
- Complete safety from shell injection

### Universal Tool Compatibility
Same tool works everywhere:
- **CLI**: Direct command line usage
- **AI Agents**: Function calling via JSON
- **Web**: MCP Bridge exposes as endpoints
- **Notation**: `[@tool:"args"]` invocation

## Key Components

- **cli/**: SkogCLI - Central configuration hub
- **tools/**: 50+ LLM-compatible tools and agents
- **skogcontext/**: Automatic context injection system
- **claude/**: Knowledge archaeologist agent
- **Task Master**: PRD-driven project workflow management

## Getting Started

```bash
# Set up environment
eval "$(skogcli config export-env --namespace skogai,claude,argc)"

# Initialize Task Master for project management
task-master init

# Explore the notation
skogai '[@hello:"World"]'
```

## Philosophy

SkogAI implements "cheating" principles similar to how the universe handles observer paradoxes:
- Multiple "uniques" through identity composition
- Living definitions that re-evaluate on access
- Self-referential types that avoid Gödel's incompleteness
- Recursive evaluation creating computational graphs

The system treats code as philosophy and philosophy as code, creating a unified framework where Dasein compiles and category theory executes.
