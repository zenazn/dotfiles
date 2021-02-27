_has() {
  whence -p "$1" > /dev/null
}
_path_prepend() {
  if [ -d "$1" ]; then
    export PATH="$1:$PATH"
  fi
}

# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
elif [ -x /usr/local/bin/brew ]; then
  eval $(/usr/local/bin/brew shellenv)
fi

# Environment
if _has nvim; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export VISUAL="$EDITOR"
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

  PREPROMPT=()
  if [ -n "$VIRTUAL_ENV" ]; then
    PREPROMPT+="py"
  fi
  if [ "$SHLVL" -gt 1 ]; then
    PREPROMPT+="L$SHLVL"
  fi
  if [ "${#PREPROMPT}" -gt 0 ]; then
    PROMPT+="%F{blue}[$PREPROMPT]%f "
  fi

  # Git branch and modification status, if applicable
  if _has git; then
    PROMPT+=$(_prompt_git)
  fi
  # Path to file
  PROMPT+='%F{green}%~$%f '
}

precmd_functions+=( _set_prompt )

# Aliases
alias g=git
alias gg='git grep'
alias gs='git status'
alias v="$EDITOR -O"
alias vim="$(whence -p "$EDITOR") -O"

# gcloud
if [ -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
elif [ -d "$HOME/bin/google-cloud-sdk" ]; then
  source "$HOME/bin/google-cloud-sdk/path.zsh.inc"
  source "$HOME/bin/google-cloud-sdk/completion.zsh.inc"
fi

_has rg && export FZF_DEFAULT_COMMAND='rg --files'
_has fd && export FZF_ALT_C_COMMAND='fd -t d'

_has nodenv && eval "$(nodenv init -)"
_has pyenv && eval "$(pyenv init -)"
_path_prepend "/usr/local/opt/postgresql@11/bin"
_path_prepend "/opt/homebrew/opt/ruby/bin"
_path_prepend "/opt/homebrew/lib/ruby/gems/3.0.0/bin"
_path_prepend "$HOME/.poetry/bin"
_path_prepend "$HOME/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

autoload zmv
