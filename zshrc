# Environment
export VISUAL=vim
export EDITOR=vim
export CLICOLOR="1"

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Completion
autoload -Uz compinit && compinit

# Prompt
RPROMPT='%F{black}%*%f'

function _prompt_git {
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
  if ! git diff-index --quiet --cached HEAD 2>/dev/null || ! git diff-files --quiet; then
    modified=" %F{red}*%F{yellow}"
  fi
  echo "%F{yellow}[$branch$modified] "
}

function _set_prompt {
  # Report exit status of last process if it was unsuccessful
  PROMPT=$'%(?..%F{red}%?%f\n)'
  # Git branch and modification status, if applicable
  PROMPT+=$(_prompt_git)
  # Path to file
  PROMPT+='%F{green}%~$%f '
}

precmd_functions+=( _set_prompt )

# Aliases
alias g=git
alias gg='git grep'
alias v=vim
