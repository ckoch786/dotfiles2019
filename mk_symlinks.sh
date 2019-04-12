#!/bin/sh


USER=$(id -un)
CONFIGS=$(ls -AB | grep -v .git | grep -v mk_symlinks | grep -v README)

if [ "$(id -u)" = "0" ]
then
    echo "run as a non-root user"
else
    for i in $CONFIGS 
    do
	ln -s $(pwd)/$i /home/$USER/$i
    done
fi
