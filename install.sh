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
    else
        echo "Not linking $f: already exists"
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

# Add some authorized keys
if [ ! -e $HOME/.ssh/authorized_keys ]
then
    touch $HOME/.ssh/authorized_keys
    chmod go-rwx $HOME/.ssh/authorized_keys
fi
for f in `ls ssh/keys`
do
    if [ ! -n "`grep carl@$f $HOME/.ssh/authorized_keys`" ]
    then
        read -p "Key carl@$f not in authorized_keys. Add (y/n)? "
        if [ $REPLY == 'y' -o $REPLY == 'yes' ]
        then
            cat ssh/keys/$f >> $HOME/.ssh/authorized_keys
        fi
    fi
done
