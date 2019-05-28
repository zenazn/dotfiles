#!/bin/bash

export EDITOR="vim"
export VISUAL="vim"
export CLICOLOR="1"
export HISTSIZE="9000"

PROMPT_COMMAND="_prompt_command"
if [ -z "$TERM_PROGRAM" ]; then
  BASE_PS1="\[\033[35m\]\u@\h:\w\$\[\033[0m\] \[\033]0;\u@\h: \w\007\]"
else
  BASE_PS1="\[\033[32m\]\w\$\[\033[0m\] \[\033]0;\W\007\]"
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

  # This is a tiny bit faster than other methods, but suffers from caching
  # problems when you e.g., `touch` a file. However, I don't use `touch` that
  # often, this is easily cleaned up by running `git status` (which I run fairly
  # often anyways), and performance is much more important to me than
  # correctness.
  if ! git diff-index --quiet --cached HEAD || ! git diff-files --quiet; then
    modified=" \[\033[31;1m\]*\[\033[0;33m\]"
  fi
  printf "\[\033[33m\][$branch$modified] "
}

for file in "$HOME"/.profile.d/*; do
  source "$file"
done
