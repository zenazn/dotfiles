#!/bin/bash

# ssh aliases
alias proxy='ssh -ND 8800 avtok.com'

# gpg
alias clearsign='gpg --clearsign -a'
alias encsign='gpg -sea -r'

# Other aliases
alias cpr='rsync -v --progress'
alias fingerprint='ssh-keygen -lF'
alias ll='ls -alF'
alias v='vim -O'
alias g='git'
alias gs='g s'
alias tmux='tmux has &> /dev/null && tmux attach || tmux'
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
