---
state: new
created: 2025-08-24T00:00:00
priority: medium
tags: [cli, argc, parsing]
depends: [map-core-infrastructure]
---

# Explore argc ecosystem modules

Investigate argc-completions, skogargc, and their role in the CLI interface.

## Details

Understand how argc integrates with the system, shell completions, and command parsing patterns.

## Subtasks

- [ ] Document argc-completions functionality
- [ ] Map skogargc integration patterns
- [ ] Understand command parsing flow
- [ ] Document shell completion generation
- [ ] Identify argc usage patterns

## Test Strategy

Verify by testing if argc patterns are consistently used across modules.

## Notes

### argc discovery (2025-08-24)

argc is the foundation for all cli operations in skogai:

1. **argcfile.sh pattern**: bash scripts with argc decorators
   - `@describe` for documentation  
   - `@cmd` for subcommands
   - `@arg` and `@option` for parameters
   - `@env` for environment variables

2. **skogcontext integration**: /home/skogix/git-fuckery/skogcontext/Argcfile.sh:594
   - complete git-flow wrapper (feature, release, hotfix, bugfix, support)
   - automatic task file generation when starting features
   - context generation for agent awareness
   - environment variable management through SKOGAI_* namespace

3. **execution pattern**:
   ```bash
   argc --argc-run $SKOGAI_ARGC_GIT  # runs the argcfile
   ```

4. **key features discovered**:
   - auto-generates cli from bash comments
   - handles complex nested subcommands
   - integrates with git-flow seamlessly
   - creates task coordination files automatically
   - manages feature/release/hotfix workflows
   - auto-updates context files during operations

### argc security model (2025-08-24)

**production requirements**: internet-exposed repl for 200mb models handling legal docs & keys

**execution levels**:
1. `chmod +x script.sh` - no safety
2. `argc --argc-run script.sh` - 80% safe (basic validation)
3. `argc Argcfile.sh` - 98% safe (trusted entry point, ARGC_PWD set)
4. `argc --argc-eval script.sh` - 100% safe (full sandboxing)

**security principles**:
1. **only defined input** - structured, typed, validated
2. **no side effects** - pure transformations only
3. **output to $LLM_OUTPUT** - controlled output location
4. **100% execution certainty** - fail loud on ambiguity
5. **ARGC_PWD as trust signal** - only set for Argcfile.sh

**path resolution**:
- `ARGC_PWD` populated = trusted Argcfile.sh execution
- `ARGC_PWD` empty = arbitrary script, no location guarantee
- all paths must be absolute or fail
- environment variables provide service discovery

this architecture ensures mcp-level security for ai agents that cannot debug failures.