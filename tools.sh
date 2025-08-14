#!/usr/bin/env bash

# @describe SkogAI context generation
# @meta version 1.0.0
# @meta dotenv
# @env LLM_OUTPUT=/dev/stdout The output path
# @env LLM_AGENT_VAR_DSN! The database connection url. e.g. pgsql://user:pass@host:port

ROOT_DIR="${LLM_ROOT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

# @cmd Create a new file at the specified path with contents.
# @option --path! The path where the file should be created
# @option --contents! The contents of the file
fs_create() {
  "$ROOT_DIR/utils/guard_path.sh" "$argc_path" "Create '$argc_path'?"
  mkdir -p "$(dirname "$argc_path")"
  printf "%s" "$argc_contents" >"$argc_path"
  echo "File created: $argc_path" >>"$LLM_OUTPUT"
}

# @cmd Append content to a file.
# @option --path! The path to the file.
# @option --contents! The contents to append.
fs_append() {
  "$ROOT_DIR/utils/guard_path.sh" "$argc_path" "Append to '$argc_path'?"
  printf "%s" "$argc_contents" >>"$argc_path"
  echo "Appended to: $argc_path" >>"$LLM_OUTPUT"
}

# @cmd Search for text patterns in files recursively
# @option --pattern! The search pattern (supports regex)
# @option --path=. The directory to search in
# @option --type File type filter (e.g., "*.sh", "*.js", "*.md")
# @flag --ignore-case Perform case-insensitive search
grep_files() {
  local grep_opts="-r --line-number --color=never"
  [[ "$argc_ignore_case" == "true" ]] && grep_opts="$grep_opts -i"
  [[ -n "$argc_type" ]] && grep_opts="$grep_opts --include=$argc_type"
  
  echo "Searching for '$argc_pattern' in $argc_path" >>"$LLM_OUTPUT"
  echo "===========================================" >>"$LLM_OUTPUT"
  grep $grep_opts "$argc_pattern" "$argc_path" >>"$LLM_OUTPUT" 2>/dev/null || echo "No matches found" >>"$LLM_OUTPUT"
}

# @cmd List directory contents with detailed information
# @option --path=. The directory to list
# @flag --recursive List recursively using tree
# @flag --hidden Include hidden files
fs_list() {
  if [[ "$argc_recursive" == "true" ]]; then
    local tree_opts="--noreport -C"
    [[ "$argc_hidden" == "true" ]] && tree_opts="$tree_opts -a"
    tree $tree_opts "$argc_path" >>"$LLM_OUTPUT" 2>/dev/null || ls -la "$argc_path" >>"$LLM_OUTPUT"
  else
    local ls_opts="-l --color=never"
    [[ "$argc_hidden" == "true" ]] && ls_opts="$ls_opts -a"
    ls $ls_opts "$argc_path" >>"$LLM_OUTPUT"
  fi
}

# @cmd Read and display file contents with line numbers
# @option --path! The file to read
# @option --lines Maximum number of lines to display
# @option --start=1 Starting line number
fs_read() {
  if [[ -n "$argc_lines" ]]; then
    local end_line=$((argc_start + argc_lines - 1))
    sed -n "${argc_start},${end_line}p" "$argc_path" | cat -n >>"$LLM_OUTPUT"
  else
    cat -n "$argc_path" >>"$LLM_OUTPUT" 2>/dev/null || echo "Error: Cannot read file $argc_path" >>"$LLM_OUTPUT"
  fi
}

# @cmd Execute shell commands safely with output capture
# @option --command! The shell command to execute
# @flag --show-command Show the command being executed
execute_shell() {
  [[ "$argc_show_command" == "true" ]] && echo "Executing: $argc_command" >>"$LLM_OUTPUT"
  echo "Command output:" >>"$LLM_OUTPUT"
  echo "===============" >>"$LLM_OUTPUT"
  bash -c "$argc_command" >>"$LLM_OUTPUT" 2>&1
}

# @cmd Git operations and status information
# @option --operation! The git operation [possible values: status, log, diff, branch, remote]
# @option --args Additional arguments for git command
git_info() {
  echo "Git $argc_operation:" >>"$LLM_OUTPUT"
  echo "==================" >>"$LLM_OUTPUT"
  case "$argc_operation" in
    "status")
      git status --porcelain >>"$LLM_OUTPUT"
      ;;
    "log")
      git log --oneline -10 ${argc_args} >>"$LLM_OUTPUT"
      ;;
    "diff")
      git diff ${argc_args} >>"$LLM_OUTPUT"
      ;;
    "branch")
      git branch -v >>"$LLM_OUTPUT"
      ;;
    "remote")
      git remote -v >>"$LLM_OUTPUT"
      ;;
    *)
      echo "Unknown git operation: $argc_operation" >>"$LLM_OUTPUT"
      ;;
  esac
}

# @cmd Generate project context and structure overview
# @option --path=. The project directory to analyze
project_context() {
  echo "Project Structure Analysis: $argc_path" >>"$LLM_OUTPUT"
  echo "=======================================" >>"$LLM_OUTPUT"
  
  # Find key files
  echo "Key Files:" >>"$LLM_OUTPUT"
  find "$argc_path" -maxdepth 2 -name "*.md" -o -name "package.json" -o -name "Cargo.toml" -o -name "pyproject.toml" -o -name "requirements.txt" -o -name "Makefile" -o -name "Dockerfile" 2>/dev/null | head -10 >>"$LLM_OUTPUT"
  
  echo "" >>"$LLM_OUTPUT"
  echo "Directory Structure (top 2 levels):" >>"$LLM_OUTPUT"
  tree -L 2 -d "$argc_path" --noreport >>"$LLM_OUTPUT" 2>/dev/null || find "$argc_path" -maxdepth 2 -type d >>"$LLM_OUTPUT"
}

# @cmd Execute a SELECT query
# @option --query! SELECT SQL query to execute
read_query() {
  if ! grep -qi '^select' <<<"$argc_query"; then
    echo "error: only SELECT query is allowed" >&2
    exit 1
  fi
  _run_sql "$argc_query"
}

# @cmd Execute an SQL query
# @option --query! SQL query to execute
write_query() {
  "$ROOT_DIR/utils/guard_operation.sh" "Execute SQL?"
  _run_sql "$argc_query"
}

# @cmd List all tables
list_tables() {
  _run_sql "\dt+"
}

# @cmd Get the schema information for a specific table
# @option --table-name! Name of the table to describe
describe_table() {
  _run_sql "\d $argc_table_name"
}

_run_sql() {
  usql "$LLM_AGENT_VAR_DSN" -c "$1" >>"$LLM_OUTPUT"
}

# @cmd Add a new todo item
# @option --desc! The todo description
add_todo() {
  todos_file="$(_get_todos_file)"
  if [[ -f "$todos_file" ]]; then
    data="$(cat "$todos_file")"
    num="$(echo "$data" | jq '[.[].id] | max + 1')"
  else
    num=1
    data="[]"
  fi
  echo "$data" |
    jq --arg new_id $num --arg new_desc "$argc_desc" \
      '. += [{"id": $new_id | tonumber, "desc": $new_desc, "done": false}]' \
      >"$todos_file"
  echo "Successfully added todo id=$num" >>"$LLM_OUTPUT"
}

# @cmd Delete an todo item
# @option --id! <INT> The todo id
del_todo() {
  todos_file="$(_get_todos_file)"
  if [[ -f "$todos_file" ]]; then
    data="$(cat "$todos_file")"
    echo "$data" |
      jq '[.[] | select(.id != '$argc_id')]' \
        >"$todos_file"
    echo "Successfully deleted todo id=$argc_id" >>"$LLM_OUTPUT"
  else
    echo "The operation failed because the todo list is currently empty." >>"$LLM_OUTPUT"
  fi
}

# @cmd Set a todo item status as done
# @option --id! <INT> The todo id
done_todo() {
  todos_file="$(_get_todos_file)"
  if [[ -f "$todos_file" ]]; then
    data="$(cat "$todos_file")"
    echo "$data" |
      jq '. |= map(if .id == '$argc_id' then .done = true else . end)' \
        >"$todos_file"
    echo "Successfully mark todo id=$argc_id as done" >>"$LLM_OUTPUT"
  else
    echo "The operation failed because the todo list is currently empty." >>"$LLM_OUTPUT"
  fi
}

# @cmd Display the current todo list in json format
list_todos() {
  todos_file="$(_get_todos_file)"
  if [[ -f "$todos_file" ]]; then
    cat "$todos_file" >>"$LLM_OUTPUT"
  else
    echo '[]' >>"$LLM_OUTPUT"
  fi
}

# @cmd Clean the entire todo list
clear_todos() {
  todos_file="$(_get_todos_file)"
  if [[ -f "$todos_file" ]]; then
    "$ROOT_DIR/utils/guard_operation.sh" "Clean the entire todo list?"
    rm -rf "$todos_file"
    echo "Successfully cleaned the entire todo list" >>"$LLM_OUTPUT"
  else
    echo "The operation failed because the todo list is currently empty." >>"$LLM_OUTPUT"
  fi
}

_get_todos_file() {
  todos_dir="${LLM_AGENT_CACHE_DIR:-.}"
  mkdir -p "$todos_dir"
  echo "$todos_dir/todos.json"
}

# @cmd Show the library
show_library() {
  local library="/home/skogix/skogai/librarian"
  tree -C "$library/archives" "$library/official" --noreport >>"$LLM_OUTPUT"
}

# @cmd Read official SkogAI documents from the official documentation directory
# @option --document! The name or path of the official document to read (use "list" to see all)
read_official_documents() {
  local official_dir="/home/skogix/skogai/docs/official"

  if [[ "$argc_document" == "list" ]]; then
    ls -la "$official_dir" >>"$LLM_OUTPUT"
  else
    cat "$official_dir/$argc_document" >>"$LLM_OUTPUT" 2>/dev/null ||
      cat "$official_dir/$argc_document.md" >>"$LLM_OUTPUT"
  fi
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"