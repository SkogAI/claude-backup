---
allowed-tools: Bash(git:*)
description: Smart commit with automatic message generation based on changes
argument-hint: [message]
---

# Quick Commit Command

Intelligently commits changes with auto-generated messages or custom message.

## How it works

Without arguments: Analyzes git diff and generates semantic commit message
With message: Uses provided message with SkogAI attribution

## Usage Examples

```
/quick-commit
/quick-commit "implement new feature"
/quick-commit "fix: resolve merge conflicts"
```

## Implementation

Arguments: $ARGUMENTS

I'll handle the commit process:

1. **Status Check**: Verify there are changes to commit
2. **Analysis**: Review git diff to understand changes  
3. **Message Generation**: 
   - If no message provided: Generate semantic message from diff
   - If message provided: Use it with SkogAI attribution
4. **Commit**: Add all changes and commit with generated/provided message

Standard SkogAI commit format:
```
[type]: [description]

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

This streamlines the commit workflow while maintaining consistency with SkogAI conventions.