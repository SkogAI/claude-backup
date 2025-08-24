---
state: new
created: 2025-08-24
priority: high
tags: [environment, configuration, patterns]
depends: [map-core-infrastructure]
---

# Document environment variable patterns

Map all environment variables and namespace patterns across modules.

## Details

Document all SKOGAI_* variables, namespace ordering, and configuration patterns.

## Subtasks

- [ ] List all SKOGAI_* variables
- [ ] Document namespace patterns
- [ ] Map configuration hierarchy
- [ ] Create usage examples
- [ ] Document direnv integration

## Test Strategy

Verify by checking if all documented variables are actually used in the system.