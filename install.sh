#!/bin/bash

for f in `ls | grep -v README | grep -v install`
do
    if [ ! -e $HOME/.$f ]
    then
        echo "Moving $f"
        if [ -d $f ]
        then
            ln -s `pwd`/$f/ $HOME/.$f
        else
            ln -s `pwd`/$f $HOME/.$f
        fi
    fi
done
