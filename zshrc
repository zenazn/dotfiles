_has() {
  whence -p "$1" > /dev/null
}
_path_prepend() {
  [ -d "$1" ] && export PATH="$1:$PATH"
}
_source() {
  [ -f "$1" ] && source "$1"
}
_mac() {
  [[ $OSTYPE == darwin* ]]
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

# Misc
setopt interactivecomments
unalias run-help
autoload run-help

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
  if ! _mac; then
    PREPROMPT+="${HOST:-remote}"
  fi
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
alias ls="ls --color=auto"
rbrew() {
  arch -x86_64 /usr/local/bin/brew "$@"
}

_has rg && export FZF_DEFAULT_COMMAND='rg --files'
_has fd && export FZF_ALT_C_COMMAND='fd -t d'

_has pyenv && eval "$(pyenv init --path)"
_has nodenv && eval "$(nodenv init -)"
_path_prepend "/opt/homebrew/opt/postgresql@11/bin"
_path_prepend "/opt/homebrew/opt/ruby/bin"
_path_prepend "/opt/homebrew/lib/ruby/gems/3.0.0/bin"
_path_prepend "$HOME/.poetry/bin"
_path_prepend "$HOME/bin"
_path_prepend "$HOME/go/bin"
_source "$HOME/.fzf.zsh"
_source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
_source "$HOME/.config/tabtab/zsh/__tabtab.zsh"
export BUN_INSTALL="/Users/carl/.bun"
_path_prepend "$BUN_INSTALL/bin"
_source "$BUN_INSTALL/_bun"

# Add ssh keys to agent asynchronously
_mac && (ssh-add -q --apple-load-keychain &) >/dev/null 2>&1

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

autoload zmv
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
