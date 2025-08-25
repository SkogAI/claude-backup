# Argc Tool Architecture Guide

## Overview

SkogAI uses argc as the foundation for a unified tool ecosystem that provides consistent interfaces across CLI, agent systems, MCP, and HTTP APIs. All tools follow the same architectural pattern with built-in security and sandboxing.

## Core Architecture Pattern

### Single Source of Truth
Every tool is an argc-annotated script that automatically generates:
- CLI interface with `--help` and proper argument parsing
- JSON schema for agent/API consumption
- Multi-interface accessibility

### Standard Tool Structure
```bash
#!/usr/bin/env bash
# @describe Tool description
# @meta version 1.0.0
# @env LLM_OUTPUT=/dev/stdout The output path

# @cmd Main command description
# @option --path! Required file path
# @option --contents! Required content
# @flag --verbose Show detailed output
main() {
    local path="$argc_path"
    local contents="$argc_contents"
    
    # Security validation
    "$ROOT_DIR/utils/guard_path.sh" "$path" "Operation on '$path'?"
    
    # Implementation
    echo "Operation result" >> "$LLM_OUTPUT"
}

eval "$(argc --argc-eval "$0" "$@")"
```

## Multi-Interface Access

### 1. Direct CLI
```bash
/path/to/tool.sh --path=/some/file --contents="data"
```

### 2. Agent Tools (Universal)
```bash
s llm run@tool tool_name '{"path": "/some/file", "contents": "data"}'
```

### 3. MCP Tools (Agent-Specific)
```bash
s llm mcp run@tool claude_tool_name '{"path": "/some/file", "contents": "data"}'
```

### 4. HTTP API
```bash
curl -X POST tools.skogai.se/tools \
  -H "Content-Type: application/json" \
  -d '{"tool": "tool_name", "params": {"path": "/some/file", "contents": "data"}}'
```

## Security Framework

### Path Validation
```bash
"$ROOT_DIR/utils/guard_path.sh" "$path" "Create '$path'?"
```
- Prevents operations in sensitive directories
- Blocks access to system files
- Validates write permissions

### Operation Confirmation
```bash
"$ROOT_DIR/utils/guard_operation.sh" "Delete all files?"
```
- Requires confirmation for destructive operations
- Prevents accidental data loss
- Audit trail for sensitive actions

### Sandboxed Execution
- Tools run in isolated environment
- No direct stdout/stderr access
- Output only via `$LLM_OUTPUT`
- Device access blocked (`/dev/stdout` fails)

### Output Control
```bash
# Default: stdout
LLM_OUTPUT=/dev/stdout tool.sh --args

# Sandboxed: file
LLM_OUTPUT=./safe-output.txt tool.sh --args

# Agent execution: controlled channel
# (automatically managed by agent system)
```

## Schema Generation

### Automatic JSON Schema
argc annotations → `functions.json`:
```json
{
  "name": "fs_create",
  "description": "Create a new file at the specified path with contents.",
  "parameters": {
    "type": "object",
    "properties": {
      "path": {"type": "string", "description": "The path where the file should be created"},
      "contents": {"type": "string", "description": "The contents of the file"}
    },
    "required": ["path", "contents"]
  },
  "agent": true
}
```

### MCP Integration
- argc annotations automatically generate MCP tool definitions
- JSON parameter validation
- Consistent error handling
- Security sandbox integration

## Tool Categories

### Universal Tools (`s llm run@tool`)
Available to all agents:
- File operations: `fs_write.sh`, `fs_read.sh`, `fs_patch.sh`
- Execution: `execute_command.sh`, `execute_sql_code.sh`
- Web/API: `fetch_url_via_curl.sh`, search tools
- Multi-language: `.sh`, `.js`, `.py` implementations

### Agent-Specific Tools (`s llm mcp run@tool claude_*`)
Tailored for specific agents:
- `claude_fs_create`, `claude_git_info`, `claude_project_context`
- Todo management, library access
- Agent-specific workflows

## Development Guidelines

### Creating New Tools

1. **Start with argc annotations**:
```bash
# @describe What this tool does
# @meta version 1.0.0
# @env LLM_OUTPUT=/dev/stdout The output path
```

2. **Add security checks**:
```bash
"$ROOT_DIR/utils/guard_path.sh" "$path" "Operation description"
```

3. **Use controlled output**:
```bash
echo "Result" >> "$LLM_OUTPUT"
```

4. **Test all interfaces**:
```bash
# CLI test
./tool.sh --help
./tool.sh --param=value

# Agent test
s llm run@tool tool_name '{"param": "value"}'
```

### Security Best Practices

1. **Always validate paths** with `guard_path.sh`
2. **Confirm destructive operations** with `guard_operation.sh`
3. **Use `$LLM_OUTPUT`** instead of direct stdout
4. **Test in sandboxed environment** before deployment
5. **Follow principle of least privilege**

### Migration Strategy

1. **Audit existing tools** for security compliance
2. **Add argc annotations** to current scripts
3. **Implement security guards** where missing
4. **Generate schemas** and test multi-interface access
5. **Document tool categories** and access patterns

## Benefits

### For Developers
- **Single codebase** for multiple interfaces
- **Automatic documentation** from argc annotations
- **Built-in security** through guard utilities
- **Consistent patterns** across all tools

### For Agents
- **Safe execution** environment
- **Standardized JSON** interfaces
- **Predictable behavior** across tools
- **Audit trail** for all operations

### For Users
- **CLI access** for direct use
- **HTTP API** for integrations
- **Multi-language** tool support
- **Security by default**

## Future Considerations

### Tool Discovery
- Automatic tool registry generation
- Dynamic schema updates
- Version management
- Deprecation handling

### Enhanced Security
- Role-based access control
- Resource quotas
- Operation logging
- Compliance reporting

### Ecosystem Growth
- Community tool contributions
- Tool composition patterns
- Cross-agent tool sharing
- Performance optimization