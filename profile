#!/bin/bash

export EDITOR="vim"
export VISUAL="vim"
export CLICOLOR="1"
export HISTSIZE="9000"

TITLE="\[\033]0;\u@\h: \w\007\]"
PROMPT_COMMAND="_prompt_command"
if [ -z "$TERM_PROGRAM" ]; then
  BASE_PS1="\[\033[35m\]\u@\h:\w\$\[\033[0m\] $TITLE"
else
  BASE_PS1="\[\033[32m\]\w\$\[\033[0m\] $TITLE"
fi
PS1="$BASE_PS1"

function _prompt_command {
  local ret="$?"
  if [ "$ret" -ne 0 ]; then
    printf "\033[31m$ret\033[0m\n"
  fi
  PS1="$(_prompt_git)$BASE_PS1"
}

function _prompt_git {
  [ -n "$NO_DYNAMIC_PROMPT" ] && return
  [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true' ] || return

  local branch modified
  branch=$(git symbolic-ref --quiet --short HEAD)
  if [ "$?" != 0 ]; then
    branch="HEAD"
  fi

  if ! git diff --quiet HEAD 2>/dev/null; then
    modified=" \[\033[31;1m\]*\[\033[0;33m\]"
  fi
  printf "\[\033[33m\][$branch$modified] "
}

for file in "$HOME"/.profile.d/*; do
  source "$file"
done
