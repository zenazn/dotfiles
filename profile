#!/bin/bash

export EDITOR="vim"
export VISUAL="vim"
export CLICOLOR="1"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

TITLE="\[\033]0;\u@\h: \w\007\]"
PROMPT_COMMAND="_prompt_command"
#PS1="\033[32m\h:\W \u\$\033[0m $TITLE"
if [ -z "$TERM_PROGRAM" ]; then
  PS1="\033[35m\u@\h:\w\$\033[0m $TITLE"
else
  PS1="\033[32m\w\$\033[0m $TITLE"
fi

function _prompt_command {
  local ret="$?" git_branch
  if [ "$ret" -ne 0 ]; then
    printf "\033[31m$ret\n"
  fi
  git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ "$?" = "0" ]; then
    local git_extra
    if ! git diff --quiet HEAD; then
      git_extra=" \033[31;1m*\033[0;33m"
    fi
    printf "\033[33m[$git_branch$git_extra] "
  fi
}

for file in $(ls "$HOME/.profile.d/"); do
  source "$HOME/.profile.d/$file"
done
