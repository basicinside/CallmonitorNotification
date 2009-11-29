#!/bin/sh

cp ~/.CallmonitorNotification/phonebook .

rm -r ~/.CallmonitorNotification

mkdir ~/.CallmonitorNotification

touch phonebook

cp ./README ~/.CallmonitorNotification/
cp ./application.rb ~/.CallmonitorNotification/
cp ./phonedirectory.rb ~/.CallmonitorNotification/
cp ./notify.rb ~/.CallmonitorNotification/
cp ./start.sh ~/.CallmonitorNotification/
cp ./phonebook ~/.CallmonitorNotification/

user=`whoami`
echo "[Desktop Entry]
Name=Anrufmonitor
Type=Application
GenericName=CallmonitorNotification
Comment=Display incoming calls
Exec=sh \"/home/$user/.CallmonitorNotification/start.sh\"
X-GNOME-Autostart-enabled=true
Icon=/usr/share/pixmaps/gnome-irc.png" > ~/Desktop/callmon.desktop


