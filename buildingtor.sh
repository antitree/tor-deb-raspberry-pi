#!/bin/sh
# Tor source build script
# Designed for the Raspberry Pi

# add sources to list vi tor.list
# install requirements apt-get install build-essential fakeroot devscripts
# apt-get install deb.torproject.org-keyring
# gpg --keyserver keys.gnupg.net --recv 886DDD89
# gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
# apt-get update
# apt-get install build-essential fakeroot devscripts
# apt-get build-dep tor
# mkdir ~/debian-packages; cd ~/debian-packages
echo Gathering latest Tor code
apt-get source tor

echo Building Tor environment
cd tor-0.2.4.22/
debuild -rfakeroot -uc -us

echo Build complete
## add mail alerts
cd ..
ls *.deb
