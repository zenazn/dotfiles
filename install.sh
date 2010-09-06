#!/bin/bash

for f in `ls | egrep -v "README|install|ssh"`
do
    if [ ! -e $HOME/.$f ]
    then
        echo "Linking $f"
        if [ -d $f ]
        then
            ln -s `pwd`/$f/ $HOME/.$f
        else
            ln -s `pwd`/$f $HOME/.$f
        fi
    fi
done

# We need to special-case the .ssh folder -- there's often a lot of other stuff
# in that directory that we don't want to stomp over
if [ ! -e $HOME/.ssh ]
then
    mkdir $HOME/.ssh
    chmod go-rwx $HOME/.ssh
fi
if [ ! -e $HOME/.ssh/rc ]
then
    echo "Linking .ssh/rc"
    ln -s `pwd`/ssh/rc $HOME/.ssh/rc
fi
