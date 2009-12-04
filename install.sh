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
cp ./start_gui.sh ~/.CallmonitorNotification/
cp ./phonebook ~/.CallmonitorNotification/
cp ./phone.png ~/.CallmonitorNotification/
cp ./phone-disabled.png ~/.CallmonitorNotification/
cp ./gui.rb ~/.CallmonitorNotification/

USER=`whoami`
echo "[Desktop Entry]
Name=fritz!box Callmonitor
Type=Application
GenericName=CallmonitorNotification
Comment=Display incoming calls
Exec=/home/$USER/.CallmonitorNotification/start_gui.sh
X-GNOME-Autostart-enabled=true
Icon=/home/$USER/.CallmonitorNotification/phone.png" > ~/Desktop/callmon.desktop

echo "[Desktop Entry]
Name=fritz!box Callmonitor
Type=Application
GenericName=CallmonitorNotification
Comment=Display incoming calls
Exec=/home/$USER/.CallmonitorNotification/start_gui.sh
X-GNOME-Autostart-enabled=true
Icon=/home/$USER/.CallmonitorNotification/phone.png" > ~/.config/autostart/callmon.desktop


