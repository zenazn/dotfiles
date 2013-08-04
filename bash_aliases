#!/bin/bash

# ssh
alias fingerprint='ssh-keygen -lF'
alias murder="ssh -O exit"
alias avtok='ssh -At avtok.com screen -UxRR'
alias proxy='ssh -ND 8800 avtok.com'

# gpg
alias clearsign='gpg --clearsign -a'
alias encsign='gpg -sea -r'

# git
alias g='git'
alias gs='g s'
alias gg="git grep"
alias HEAD="git rev-parse HEAD"
complete -o default -o nospace -F _git g

# vim
alias v='vim -O'
function vimwhich { vim "$(which "$1")"; }
complete -F _command vimwhich

# Other aliases
alias cpr='rsync -v --progress'
alias ll='ls -alF'
alias tmux='tmux has &> /dev/null && tmux attach || tmux'
alias utc="date -u"

# Mac
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
