# @describe SkogAI context generation
# @meta version 1.0.0
# @meta dotenv
# @env LLM_OUTPUT=/dev/stdout The output path

# @cmd tools
# @arg args~[?`_choice_tools_args`] the test command
tools() {
  bash ./tools.sh "$@"
}

_choice_tools_args() {
  if [[ "$ARGC_COMPGEN" -eq 1 ]]; then
    args=("${argc__positionals[@]}")
    args[-1]="$ARGC_LAST_ARG"
    argc --argc-compgen generic ./tools.sh tools "${args[@]}"
  else
    :
  fi
}

# @cmd testing
# @arg args~[?`_choice_test_args`] the test command
test() {
  bash $SKOGIX_TEST_ARGC "$@"
}

_choice_test_args() {
  if [[ "$ARGC_COMPGEN" -eq 1 ]]; then
    args=("${argc__positionals[@]}")
    args[-1]="$ARGC_LAST_ARG"
    argc --argc-compgen generic Argcfile.sh test "${args[@]}"
  else
    :
  fi
}

# @cmd
generate() { :; }

# @cmd Generate argc interface from description
# @arg description! What the script should do
# @option --name= Script name (auto-generated if not provided)
# @option --output= Output file (stdout if not provided)
generate::listen() {
  local description="$argc_description"
  local name="${argc_name:-$(echo "$description" | head -c 20 | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')}"
  local output="${argc_output:-/dev/stdout}"

  # Parse description to infer interface structure
  local needs_input=false
  local needs_output=false
  local needs_verbose=false

  # Simple heuristics
  [[ "$description" =~ (file|input|read|process|convert|transform) ]] && needs_input=true
  [[ "$description" =~ (output|write|save|export|generate) ]] && needs_output=true
  [[ "$description" =~ (verbose|debug|detailed|show) ]] && needs_verbose=true

  {
    echo "#!/usr/bin/env bash"
    echo ""
    echo "set -e"
    echo ""
    echo "# @describe $description"
    echo "# @meta version 1.0.0"
    echo ""
    echo "# @cmd $description"

    if [[ "$needs_input" == "true" ]]; then
      echo "# @arg input! Input file or data"
    fi

    if [[ "$needs_output" == "true" ]]; then
      echo "# @option --output= Output file path"
    fi

    if [[ "$needs_verbose" == "true" ]]; then
      echo "# @flag --verbose Show detailed output"
    fi

    echo "main() {"

    if [[ "$needs_input" == "true" ]]; then
      echo "    local input=\"\$argc_input\""
    fi

    if [[ "$needs_output" == "true" ]]; then
      echo "    local output=\"\${argc_output:-}\""
    fi

    if [[ "$needs_verbose" == "true" ]]; then
      echo "    local verbose=\"\${argc_verbose:-false}\""
    fi

    echo ""
    echo "    # Implementation goes here"
    echo "    echo \"$description - interface ready\""
    echo "}"
    echo ""
    echo "eval \"\$(argc --argc-eval \"\$0\" \"\$@\")\""
  } >"$output"

  if [[ "$output" != "/dev/stdout" ]]; then
    chmod +x "$output"
    echo "Generated: $output"
  fi
}

# @cmd Generate argc function signature for existing functionality
# @arg function-name! Name of the function to create interface for
# @arg description! Description of what the function does
# @option --args= Number of required arguments (default: 1)
# @option --options= Number of optional parameters (default: 0)
# @option --flags= Number of boolean flags (default: 0)
generate::signature() {
  local func_name="$argc_function_name"
  local description="$argc_description"
  local args="${argc_args:-1}"
  local options="${argc_options:-0}"
  local flags="${argc_flags:-0}"

  echo "# @cmd $description"

  # Generate argument declarations
  for ((i = 1; i <= args; i++)); do
    if [[ $i -eq 1 ]]; then
      echo "# @arg input! Primary input parameter"
    else
      echo "# @arg param$i! Parameter $i description"
    fi
  done

  # Generate option declarations
  for ((i = 1; i <= options; i++)); do
    echo "# @option --option$i= Optional parameter $i"
  done

  # Generate flag declarations
  for ((i = 1; i <= flags; i++)); do
    echo "# @flag --flag$i Enable feature $i"
  done

  echo "${func_name}() {"
  echo "    # Interface variables:"
  for ((i = 1; i <= args; i++)); do
    if [[ $i -eq 1 ]]; then
      echo "    local input=\"\$argc_input\""
    else
      echo "    local param$i=\"\$argc_param$i\""
    fi
  done

  for ((i = 1; i <= options; i++)); do
    echo "    local option$i=\"\${argc_option$i:-}\""
  done

  for ((i = 1; i <= flags; i++)); do
    echo "    local flag$i=\"\${argc_flag$i:-false}\""
  done

  echo ""
  echo "    # Implementation placeholder"
  echo "    echo \"$description interface ready\""
  echo "}"
}

# @cmd Add argc commentary to existing script structure
# @arg script-file! Path to existing script file
# @option --backup Create backup with .bak extension
generate::commentary() {
  local script_file="$argc_script_file"
  local backup="${argc_backup:-false}"

  if [[ ! -f "$script_file" ]]; then
    echo "Error: Script file '$script_file' not found"
    exit 1
  fi

  if [[ "$backup" == "true" ]]; then
    cp "$script_file" "$script_file.bak"
    echo "Backup created: $script_file.bak"
  fi

  echo "Argc commentary suggestions for: $script_file"
  echo ""
  echo "Add to top of file:"
  echo "# @describe [Script purpose description]"
  echo "# @meta version 1.0.0"
  echo "# @env LLM_OUTPUT=/dev/stdout The output path"
  echo ""
  echo "For each function, add above function definition:"
  echo "# @cmd [Function description]"
  echo "# @arg name! [Required argument description]"
  echo "# @option --option= [Optional parameter description]"
  echo "# @flag --verbose [Boolean flag description]"
  echo ""
  echo "Add to end of file:"
  echo "eval \"\$(argc --argc-eval \"\$0\" \"\$@\")\""
}

# @cmd
help() { :; }

# @cmd List argc annotation patterns and examples
help::patterns() {
  echo "Argc Annotation Patterns:"
  echo ""
  echo "Script metadata:"
  echo "  # @describe [Script description]"
  echo "  # @meta version 1.0.0"
  echo "  # @env VAR=default Description"
  echo ""
  echo "Command definitions:"
  echo "  # @cmd [Command description]"
  echo "  # @alias c Short alias"
  echo ""
  echo "Parameters:"
  echo "  # @arg name! Required argument"
  echo "  # @arg name Optional argument"
  echo "  # @arg name+ One or more arguments"
  echo "  # @arg name* Zero or more arguments"
  echo ""
  echo "Options:"
  echo "  # @option --name= Optional parameter"
  echo "  # @option --name=default With default value"
  echo ""
  echo "Flags:"
  echo "  # @flag --verbose Boolean flag"
  echo "  # @flag -v,--verbose Short and long forms"
  echo ""
  echo "Evaluation:"
  echo "  eval \"\$(argc --argc-eval \"\$0\" \"\$@\")\""
}

# @cmd
llm() { :; }

# @cmd Access aichat argc integration commands
# @arg commands* Pass-through arguments to aichat argc
llm::run() {
  argc --argc-run /home/skogix/.local/src/llm-functions/Argcfile.sh "$@"
}

# @cmd
skogai() { :; }

# @cmd Access SkogAI core system operations (git-flow, context, updates)
# @arg commands* Pass-through arguments to SkogAI core system
skogai::run() {
  argc --argc-run /home/skogix/skogix/Argcfile.sh "$@"
}

eval "$(argc --argc-eval "$0" "$@")"
