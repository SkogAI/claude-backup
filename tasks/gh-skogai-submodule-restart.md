---
state: active
created: 2025-08-25T10:11:42+02:00
priority: high
tags: [infrastructure, ai-agent, git-flow, restart]
depends: []
---

# Restart gh-skogai-submodule Project

Complete restart and restructure of the gh-skogai-submodule GitHub CLI extension based on proven concepts from v0.0.3.

## Current State Assessment

### What Works (v0.0.3 Achievements)
- ✅ AI agent compatibility flags: `--json`, `--no-interactive`, `--batch`
- ✅ Smart GitHub API endpoint fallback (org → user endpoints)
- ✅ Repository discovery increased from 60 to 144+ repos
- ✅ Git-flow branch detection: develop → main → master priority
- ✅ Fixed .gitmodules auto-staging pollution
- ✅ Dynamic submodule workflow without permanent tracking

### Current Architecture Issues
- Multiple separate executables (`gh-skogai-submodule`, `gh-skogai-submodule-add`, `gh-skogai-submodule-remove`)
- Inconsistent AI agent pattern implementation across tools
- Version management scattered across files
- Documentation fragmentation
- Unclear separation of concerns between add/remove functionality

### Repository Structure
```
/home/skogix/git-fuckery/claude/gh-skogai-submodule/
├── gh-skogai-submodule          # Main executable (enhanced)
├── gh-skogai-submodule-add      # Add functionality
├── gh-skogai-submodule-add.sh   # Add script
├── gh-skogai-submodule-remove   # Remove functionality  
├── gh-skogai-submodule-remove.sh # Remove script
├── readme.md                    # Documentation
└── tmp/                         # Temporary files
```

## Technical Specifications

### Core Function Signatures
```bash
# Smart API endpoint detection
try_api_endpoint(endpoint, jq_filter) -> repo_list | empty
detect_default_branch(org, repo) -> branch_name

# Enhanced submodule operations
submodule_add_with_branch_detection(org, repo, args) -> success | error
submodule_remove_with_cleanup(name) -> success | error
```

### Data Flow
```
User Request → Org/User API Fallback → Repository Discovery → 
Branch Detection → Submodule Operation → .gitmodules Cleanup
```

## Restart Architecture Decisions

### Consolidation Strategy
- **Single executable approach**: Merge functionality into one tool with subcommands
- **Unified AI agent patterns**: Same flags across all operations
- **Consistent error handling**: JSON output for both success/failure cases
- **Version management**: Single source of truth for version info

### Core Design Principles
1. **AI agent first**: Non-interactive mode as primary design consideration
2. **Git-flow native**: Automatic branch detection and workflow integration
3. **Dynamic workflow**: No permanent .gitmodules pollution
4. **Smart discovery**: Maximize repository visibility through endpoint optimization
5. **Idempotent operations**: Safe to retry and resume

## Implementation Plan

### Phase 1: Architecture Analysis
- [ ] Examine current `gh-skogai-submodule-remove` implementation
- [ ] Map data flow between add/remove operations
- [ ] Identify shared functionality and patterns
- [ ] Document current API surface and behavior

### Phase 2: Unified Design
- [ ] Design consolidated command structure
- [ ] Standardize AI agent integration patterns
- [ ] Create unified error handling and logging
- [ ] Design configuration management approach

### Phase 3: Implementation
- [ ] Implement consolidated executable
- [ ] Migrate proven functionality from v0.0.3
- [ ] Add comprehensive JSON output support
- [ ] Implement unified testing framework

### Phase 4: Documentation & Release
- [ ] Create comprehensive usage documentation
- [ ] Update AI agent integration guides
- [ ] Establish proper git-flow release process
- [ ] Version bump and release strategy

## Success Criteria

1. **Single executable** handling add/remove/list operations
2. **100% AI agent compatible** with consistent JSON output
3. **Git-flow integration** with automatic branch detection
4. **Repository discovery optimization** maintaining 144+ repo visibility
5. **Dynamic workflow support** without .gitmodules pollution
6. **Comprehensive documentation** for human and AI agent usage

## Technical Context

### GitHub API Endpoints
- `GET /orgs/{org}/repos` - Includes private repos (if authenticated)
- `GET /users/{user}/repos` - Public repos only (fallback)
- `GET /repos/{owner}/{repo}/branches/{branch}` - Branch detection

### Git Operations
- `git submodule add --branch <branch> <url> [path]`
- `git submodule deinit <path>`
- `git reset HEAD .gitmodules` - Prevent auto-staging

### Environment Integration
- GitHub CLI authentication and configuration
- Git-flow AVH edition compatibility  
- SkogAI ecosystem integration patterns

## Related Resources

- Previous conversation context: gh-skogai-submodule v0.0.3 development
- Documentation: `/tools/how-to-use-gh-skogai-submodule.md` (skogai-memory)
- Repository: `https://github.com/SkogAI/gh-skogai-submodule`
- Git-flow patterns: SkogAI ecosystem standards

## Notes

This restart is based on proven functionality from iterative development. The goal is architectural clarity and maintainability while preserving all working features from v0.0.3.

Key insight: "The core of SkogAI isn't code; it's relationships" - this tool manages relationships between repositories in the ecosystem.