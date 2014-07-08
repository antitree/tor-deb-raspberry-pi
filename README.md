tor-raspberry-pi
=============

This is a repo for Tor .deb packages built for the arm architecture and specifically for the Raspberry Pi. This is a more up-to-date version of Tor compared to the ones used by Debian and Raspbian. 

## Installation
 * Download the latest .deb under releases
 * on the pi as root run
 dpkg -i tor-{whateverversion}.deb
 * If you receive an error stating that libevent is not installed, you can automatically install it by running
 apt-get install -f

## Why? ##
 * Debian(and Raspbian) repos are notoriously out of date
 * The custom repos you normally use for Debian and Ubuntu do not support Arm
 * Building from source is not easy in a chroot environment and very time consuming

This is meant to be an up-to-date version of Tor .DEB package that can easily be installed on Raspbian or other Debian-based distros running on the Raspberry Pi. It is built on a Raspberry Pi Model B but should also work on A just fine. 

For more background and detailed explanation:
https://tor.stackexchange.com/questions/242/how-to-run-tor-on-raspbian-on-the-raspberry-pi

## Why not a PPA?##
Because Launchpad doesn't support arm architecture at this point. 

## Why should I trust you ##
You shouldn't. Although I know I'm not messing with the source, you shouldn't trust a binary and if this is a concern of yours, you should build it from source yourself. 

## Future Versions ##
 [ ] build for experimental builds as well
 
 [ ] automate the build process
