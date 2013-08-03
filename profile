#!/bin/bash

export EDITOR="vim"
export VISUAL="vim"
export CLICOLOR="1"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

TITLE="\[\033]0;\u@\h: \w\007\]"
PROMPT_COMMAND="_prompt_command"
#PS1="\033[32m\h:\W \u\$\033[0m $TITLE"
PS1="\033[32m\W\$\033[0m $TITLE"

function _prompt_command {
  local ret="$?" git_branch
  if [ "$ret" -ne 0 ]; then
    printf "\033[31m$ret\n"
  fi
  git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ "$?" = "0" ]; then
    printf "\033[33m[$git_branch"
    if ! git diff --quiet HEAD; then
      printf " \033[31;1m*\033[0;33m] "
    else
      printf "] "
    fi
  fi
}

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
[ -d "$HOME/.profile.d/" ] && source "$HOME"/.profile.d/*
