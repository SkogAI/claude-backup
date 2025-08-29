# SkogAI

## env

[@todo]

## repositories

### aichat

**ai chat interface** - not yet integrated into main repository
- referenced in multiple scripts via tools ecosystem
- appears to be external dependency for running agents

### amy

**specialized agent** - external agent in `/home/skogix/skogai/amy/`
- executable via `scripts/amy.sh` wrapper
- runs with `--no-stream --non-interactive` flags
- appears to be a standalone ai agent system

### argc-completions

### backup

### blacksmith

**code generation agent** - external agent in `/home/skogix/skogai/blacksmith/`
- accessible via symbolic link in `tools/agents/blacksmith`
- appears to be specialized for code generation tasks

### claude

**claude ai integration** - external integration in `/home/skogix/skogai/agents/claude/`
- executable via `scripts/claude.sh` wrapper
- integrates with local claude code cli at `~/.claude/local/node_modules/@anthropic-ai/claude-code/`
- includes context generation from `docs/lore/skogix-notation.md`

### cli

**skogcli** - command line interface for skogai

- `skogcli config` for configuration management
- `skogcli script` for script management
- use `eval "$(skogcli config export-env --namespace claude,skogai)"` in `.envrc` files to load all environment variables

### data

**data management** - not yet integrated into main repository
- no evidence found in current project structure

### demo-repository

**examples and demonstrations** - exists as `tools/agents/demo/`
- contains example agent structure with multi-language tools (js, py, sh)
- serves as template for agent development

### docs

**documentation storage** - submodule from SkogAI/docs
- currently contains minimal content (memory/ subdirectory)
- intended for consolidated project documentation

### gh-skogai-submodule

**github cli extension** - batch clone/submodule tool for repositories

- **purpose**: mass clone github repositories as submodules or regular clones
- **usage**: `gh skogai-submodule --help`

### goose

**ai agent with developer toolkit** - accessible via `scripts/goose.sh` 
- runs `goose run --with-builtin=developer --quiet --text`
- external goose CLI tool for ai-powered development tasks
- specialized for development workflow assistance

### gptme

**gpt integration** - not yet integrated into main repository
- no evidence found in current project structure

### harbor

### home

### mcp-database-server

### meta

### sassy-skogai-tales

### skogai-0.3

### skogai

### skogargc

### skogchat-pythno

### skogcontext

- context injection system - updates context during tool calls or when called
- `SKOGAI_CONTEXT_UPDATE`: script that updates context (runs on tool calls)
- `SKOGAI_CONTEXT_RUN`: script for structured session startup

### template

**project templates** - not yet integrated into main repository
- no evidence found in current project structure

### tools

**llm functions and agents system** - submodule from SkogAI/tools
- comprehensive system for building llm tools and agents using bash, javascript, python
- **core features**:
  - function calling integration for llms
  - multi-language tool support (bash, js, py)
  - agent system with yaml definitions
  - mcp (model context protocol) integration
- **agents**: coder, demo, git-flow, json-viewer, sql, todo
- **external agent links**: blacksmith, librarian (broken symlinks to external paths)
- **tools directory**: 50+ tools for various functions (file system, web search, code execution, etc)
- **architecture**: uses argc for command parsing and jq for json processing

### y-cli

### y-gui

### y-skogai
