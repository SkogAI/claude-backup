# Argc Annotation Patterns

## Script Metadata
```bash
# @describe [Script description]
# @meta version 1.0.0
# @env VAR=default Description
```

## Command Definitions
```bash
# @cmd [Command description]
# @alias c Short alias
```

## Parameters
```bash
# @arg name! Required argument
# @arg name Optional argument
# @arg name+ One or more arguments
# @arg name* Zero or more arguments
```

## Options
```bash
# @option --name= Optional parameter
# @option --name=default With default value
```

## Flags
```bash
# @flag --verbose Boolean flag
# @flag -v,--verbose Short and long forms
```

## Evaluation
```bash
eval "$(argc --argc-eval "$0" "$@")"
```

## Interface Generation Concepts

### Auto-generation from Description
- Parse description text for keywords (file, input, read, output, verbose)
- Infer required parameters based on function intent
- Generate complete argc-annotated script structure

### Signature Generation
- Create argc interfaces for existing functions
- Parameterized argument/option/flag count
- Template-based interface generation

### Commentary Addition
- Add argc annotations to existing scripts
- Backup original files
- Provide suggestion templates for manual annotation