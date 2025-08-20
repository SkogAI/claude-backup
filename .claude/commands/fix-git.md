---
allowed-tools: Bash(git:*)
description: Fix common git issues like branch switching, merging, and cleanup
argument-hint: [issue-type]
---

# Fix Git Command

Handles common git operations and fixes. Available issue types:

- **merge-conflicts** - Interactive conflict resolution
- **branch-sync** - Sync current branch with master/develop  
- **cleanup** - Remove merged branches and cleanup
- **switch-branch** - Smart branch switching with stash if needed
- **force-push-safe** - Safe force push with lease
- **reset-hard** - Hard reset with confirmation

## Usage Examples

```
/fix-git merge-conflicts
/fix-git branch-sync
/fix-git cleanup
/fix-git switch-branch feature/new-stuff
```

## Implementation

Arguments: $ARGUMENTS

Based on the issue type, I'll handle common git scenarios:

**merge-conflicts**: Check for conflicts, show status, and guide through resolution
**branch-sync**: Fetch latest, rebase/merge with develop or master  
**cleanup**: Remove merged local branches, prune remotes
**switch-branch**: Stash changes if dirty, switch branch, pop stash
**force-push-safe**: Use `git push --force-with-lease` for safer force pushing
**reset-hard**: Confirm then hard reset to specified commit/branch

For the current state:
- On branch: feature/tmp
- Status: clean working tree
- Recent commits show merge patterns with develop/master

Let me handle the requested git operation safely.