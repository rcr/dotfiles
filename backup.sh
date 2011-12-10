#!/bin/bash

echo -e "*\nDon't forget to remove your password from muttrc!\n*"

cp ~/.Xdefaults ./Xdefaults
cp ~/.config/tint2/tint2rc .
cp ~/.bashrc ./bashrc
cp ~/.muttrc ./muttrc
cp ~/.vimrc ./vimrc
cp /etc/rc.conf .
cp /etc/conky/conky_todo .
cp /etc/conky/conky.conf .
cp -fR ~/.config/openbox .
