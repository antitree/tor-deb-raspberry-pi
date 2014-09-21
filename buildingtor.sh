#!/bin/bash
# Tor source build script
# Designed for the Raspberry Pi

#Email alert messages
EMAIL="antitree@gmail.com"
SUBJECT="Tor ARM Build Status"
MSGFILE="/tmp/torbuildmessage.msg"

TORPATH="/home/pi/tor-build-arm" # path of the build directory for cron

## Check root
if [[ $EUID -ne 0 ]]; then
  echo Must be run as root
  exit 1
fi

# add sources to list vi tor.list
# install requirements apt-get install build-essential fakeroot devscripts
# apt-get install deb.torproject.org-keyring
# gpg --keyserver keys.gnupg.net --recv 886DDD89
# gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
# apt-get update
# apt-get install build-essential fakeroot devscripts
# apt-get build-dep tor
# mkdir ~/debian-packages; cd ~/debian-packages

cd $TORPATH

echo Clearing old versions of Tor
rm -rf ./tor-0.2.*
echo Updating packages >> $MSGFILE
apt-get update

echo Gathering latest Tor code
apt-get source tor >> $MSGFILE

echo Building Tor environment
cd tor-0.2.*
debuild -rfakeroot -uc -us >> $MSGFILE

echo Build complete >> $MSGFILE
cd ..
ls *.deb >> $MSGFILE
## TODO find latest version and mve to latest.deb
/usr/bin/mail -s "$SUBJECT" "$EMAIL" < $MSGFILE

git add ./tor_*.deb
