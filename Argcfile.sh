#!/usr/bin/env bash

set -e

# @describe A comprehensive argc demo showing best practices
# @env SKOGAI_PWD=/home/skogix/claude/
# @env LLM_OUTPUT=/dev/stdout The output path
# @env SKOGAI_AGENT_NAME![claude|dot|amy|goose]
# @meta version 1.0.0
# @meta dotenv .env
# @meta require-tools git,curl
# @cmd Git flow operations
flow() { :; }

# @cmd Git flow operations
update() { :; }

# @cmd $SKOGAI_PWD/tools.sh wrapper
tools() {
  argc --argc-run $SKOGAI_PWD/tools.sh "$@"
}

# @cmd
flow::feature() { :; }

# @cmd Start new feature branch
# @flag -F --fetch Fetch from origin before operation
# @arg name! Feature branch name
# @arg base Base branch (defaults to develop)
flow::feature::start() {
  git flow feature start $argc_fetch $argc_name $argc_base
}

# @cmd Finish feature branch
# @flag -F --fetch Fetch from origin before finish
# @flag -r --rebase Rebase before merging
# @flag -p --push Push to origin after finish
# @flag -k --keep Keep branch after finish
# @flag -S --squash Squash feature during merge
# @flag --no-ff Never fast-forward during merge
flow::feature::finish() {
  git flow feature finish $argc_fetch $argc_rebase $argc_push $argc_keep $argc_squash $argc_no_ff
}

# @cmd Publish feature to origin
# @arg name[`_choice_features`] Feature branch name
flow::feature::publish() {
  git flow feature publish $argc_name
}

# @cmd List feature branches
flow::feature::list() {
  git flow feature list
}

# @cmd Delete feature branch
# @flag -f --force Force delete
# @flag -r --remote Delete remote branch
# @arg name! Feature branch name
flow::feature::delete() {
  git flow feature delete $argc_force $argc_remote $argc_name
}

# @cmd
flow::release() { :; }

# @cmd Start new release branch
# @flag -F --fetch Fetch from origin before operation
# @arg version! Release version
# @arg base Base branch (defaults to develop)
flow::release::start() {
  git flow release start $argc_fetch $argc_version $argc_base
}

# @cmd Finish release branch
# @flag -F --fetch Fetch from origin before finish
# @flag -s --sign Sign the release tag
# @flag -p --push Push to origin after finish
# @flag -k --keep Keep branch after finish
# @flag -n --notag Don't tag this release
# @flag -b --nobackmerge Don't back-merge master in develop
# @flag -S --squash Squash release during merge
# @arg version! Release version
flow::release::finish() {
  git flow release finish $argc_fetch $argc_sign $argc_push $argc_keep $argc_notag $argc_nobackmerge $argc_squash $argc_version
}

# @cmd Publish release to origin
# @arg version! Release version
flow::release::publish() {
  git flow release publish $argc_version
}

# @cmd List release branches
flow::release::list() {
  git flow release list
}

# @cmd Delete release branch
# @flag -f --force Force delete
# @flag -r --remote Delete remote branch
# @arg version! Release version
flow::release::delete() {
  git flow release delete $argc_force $argc_remote $argc_version
}

# @cmd
flow::hotfix() { :; }

# @cmd Start new hotfix branch
# @flag -F --fetch Fetch from origin before operation
# @arg version! Hotfix version
# @arg base Base branch (defaults to master)
flow::hotfix::start() {
  git flow hotfix start $argc_fetch $argc_version $argc_base
}

# @cmd Finish hotfix branch
# @flag -F --fetch Fetch from origin before finish
# @flag -s --sign Sign the release tag
# @flag -p --push Push to origin after finish
# @flag -k --keep Keep branch after finish
# @flag -n --notag Don't tag this hotfix
# @flag -b --nobackmerge Don't back-merge master in develop
# @arg version! Hotfix version
flow::hotfix::finish() {
  git flow hotfix finish $argc_fetch $argc_sign $argc_push $argc_keep $argc_notag $argc_nobackmerge $argc_version
}

# @cmd Publish hotfix to origin
# @arg version! Hotfix version
flow::hotfix::publish() {
  git flow hotfix publish $argc_version
}

# @cmd List hotfix branches
flow::hotfix::list() {
  git flow hotfix list
}

# @cmd Delete hotfix branch
# @flag -f --force Force delete
# @flag -r --remote Delete remote branch
# @arg version! Hotfix version
flow::hotfix::delete() {
  git flow hotfix delete $argc_force $argc_remote $argc_version
}

# @cmd Track remote feature branch
# @arg name! Feature branch name
flow::feature::track() {
  git flow feature track $argc_name
}

# @cmd Switch to feature branch
# @arg name! Feature branch name
flow::feature::checkout() {
  git flow feature checkout $argc_name
}

# @cmd Pull feature branch from remote
# @arg name! Feature branch name
flow::feature::pull() {
  git flow feature pull $argc_name
}

# @cmd Show feature diff
# @arg name Feature branch name (defaults to current)
flow::feature::diff() {
  git flow feature diff $argc_name
}

# @cmd Rebase feature branch
# @flag -i --interactive Interactive rebase
# @arg name Feature branch name (defaults to current)
flow::feature::rebase() {
  git flow feature rebase $argc_interactive $argc_name
}

# @cmd Track remote release branch
# @arg version! Release version
flow::release::track() {
  git flow release track $argc_version
}

# @cmd Show git-flow version
flow::version() {
  git flow version
}

# @cmd Show git-flow config
# @flag --local Use repository config file
# @flag --global Use global config file
# @flag --system Use system config file
flow::config() {
  git flow config $argc_local $argc_global $argc_system
}

# @cmd Show log deviating from base branch
flow::log() {
  git flow log
}

# Helper function for completion
_choice_skogix_args() {
  if [[ "$ARGC_COMPGEN" -eq 1 ]]; then
    args=("${argc__positionals[@]}")
    args[-1]="$ARGC_LAST_ARG"
    argc --argc-compgen generic ../Argcfile.sh demo demo "${args[@]}"
  else
    :
  fi
}

# Helper function for git-flow completion
_choice_flow_args() {
  if [[ "$ARGC_COMPGEN" -eq 1 ]]; then
    args=("${argc__positionals[@]}")
    args[-1]="$ARGC_LAST_ARG"
    argc --argc-compgen generic ./git-flow.sh flow "${args[@]}"
  else
    :
  fi
}

# Helper function for feature completion
_choice_features() {
  if [[ "$ARGC_COMPGEN" -eq 1 ]]; then
    git flow feature list 2>/dev/null | sed 's/^[* ] *//' | grep -v '^$'
  fi
}

eval "$(argc --argc-eval "$0" "$@")"
