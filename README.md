tor-build-arm
=============

This is a repo for Tor build for the arm architecture. It's designed to run on raspberry pi's or any arm chips. This is a more up-to-date version of Tor compared to the ones used by Debian

## Why? ##
 * Debian(and Raspbian) repos are notoriously out of date
 * The custom repos you normally use for Debian and Ubuntu do not support Arm

So if you want a newer version of Tor, you have to compile it yourself including the build tools that you might not want to have on your including the build tools that you might not want to install (or setup a virtual environment). Or just use this pre-compiled version that was built off a Raspberry Pi. 

## Why not a PPA?##
Because Launchpad doesn't support arm architecture

## Why should I trust you ##
You shouldn't. Although I know I'm not messing with the source, you shouldn't trust a binary and if this is a concern of yours, you should build it from source yourself. 
