#!/bin/bash

# ssh aliases
alias adama='ssh -At adama.fas.harvard.edu screen -UxRR'
alias avtok='ssh -At avtok.com screen -UxRR'
alias fas='ssh cjackson@nice.fas.harvard.edu'
alias hcs='ssh -A carl@hcs.harvard.edu'
alias kinitmit='kinit -l1d -r7d ctj@ATHENA.MIT.EDU'
alias mit='ssh -t ctj@linerva.mit.edu screen -UxRR'
alias proxy='ssh -ND 8800 avtok.com'

# gpg
alias clearsign='gpg --clearsign -a'
alias encsign='gpg -sea -r'

# Other aliases
alias cpr='rsync -v --progress'
alias fingerprint='ssh-keygen -lF'
alias H="cd $HOME/Dropbox/Harvard"
alias ll='ls -alF'
alias texclean='rm *.aux *.log'
alias v='vim -O'
alias g='git'
alias gs='g s'
alias ack='ack --ignore-dir=node_modules --type-set COFFEE=.coffee --type-set ECO=.eco --type-set SCSS=.scss'
alias tmux='tmux has &> /dev/null && tmux attach || tmux'
