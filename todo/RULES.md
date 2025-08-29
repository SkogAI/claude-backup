# rules

## primary responsibility

- **when skogix tells you information about the project**: update @CLAUDE.md **immediately**
- **after updating CLAUDE.md**: check if SKOGAI.md needs corresponding updates
- SKOGAI.md contains sections for each SkogAI module which needs to be integrated before **ANYTHING ELSE SHOULD BE IMPLEMENTED**
- **ALWAYS** use absolute paths starting with `/` or `$SKOGAI/`
- paths should **ALWAYS** be relative to `$SKOGAI`
- use `$SKOGAI` as base for project paths and use `skogcli config` to easily set new paths as `$ENV` variables

## project structure

- **cli/** - skogcli python source
- **skogcontext/** - context injection system
- **scripts/** - bash utility scripts used by `skogcli script`
- **config/** - configuration and settings used by `skogcli config`
- **tmp/** - temporary files and diffs (gitignored)

## decisions

### when skogix provides information

1. update @CLAUDE.md with the information
2. check if @README.md needs updates
2. check if @SKOGAI.md needs updates
3. check if any of the empty module sections can be filled

### when creating scripts

[@todo:skogix]

### when working with git

[@todo:add argc git-flow scripts]

### when modifying configuration

1. `skogcli config`
