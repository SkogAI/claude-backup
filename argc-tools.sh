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

eval "$(argc --argc-eval "$0" "$@")"
