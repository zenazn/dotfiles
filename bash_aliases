#!/bin/bash

# ssh aliases
alias adama='ssh -At adama.fas.harvard.edu screen -UxRR'
alias avtok='ssh -At avtok.com screen -UxRR'
alias fas='ssh cjackson@nice.fas.harvard.edu'
alias hcs='ssh -A carl@hcs.harvard.edu'
alias proxy='ssh -ND 8800 avtok.com'

# gpg
alias clearsign='gpg --clearsign -a'
alias encsign='gpg -sea -r'

# Other aliases
alias cpr='rsync -v --progress'
alias fingerprint='ssh-keygen -lF'
alias H="cd $HOME/Dropbox/Harvard"
alias ll='ls -alF'
alias v='vim -O'
alias g='git'
alias gs='g s'
alias tmux='tmux has &> /dev/null && tmux attach || tmux'
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
