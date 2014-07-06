Format: 1.0
Source: tor
Binary: tor, tor-dbg, tor-geoipdb
Architecture: any all
Version: 0.2.4.22-1~d70.wheezy+1
Maintainer: Peter Palfrader <weasel@debian.org>
Homepage: https://www.torproject.org/
Standards-Version: 3.9.4
Vcs-Browser: https://gitweb.torproject.org/debian/tor.git
Vcs-Git: https://git.torproject.org/debian/tor.git
Build-Depends: debhelper (>= 8.1.0~), quilt, libssl-dev, zlib1g-dev, libevent-dev (>= 1.1), binutils (>= 2.14.90.0.7), hardening-includes, asciidoc (>= 8.2), docbook-xml, docbook-xsl, xmlto, dh-apparmor
Build-Conflicts: libnacl-dev
Package-List: 
 tor deb net optional
 tor-dbg deb debug extra
 tor-geoipdb deb net extra
Checksums-Sha1: 
 42349e02c3f6db4e6f2cc52b8a61ea91761ac4d6 2908812 tor_0.2.4.22.orig.tar.gz
 e3dc4cbd007b348e9af8a2cb06777f901f73834a 34393 tor_0.2.4.22-1~d70.wheezy+1.diff.gz
Checksums-Sha256: 
 6bf7942e93b8919a7d01a601390c2a8e7c32d6d53713a73c02d734bad9bd694c 2908812 tor_0.2.4.22.orig.tar.gz
 176220f47a763db94156712f13b8947d54918bbf99f29a98969810bbdff46cd4 34393 tor_0.2.4.22-1~d70.wheezy+1.diff.gz
Files: 
 5a7eee0d9df87233255d78b25c6f8270 2908812 tor_0.2.4.22.orig.tar.gz
 cf51c0fce88a5c71c11b89e7bd5524b4 34393 tor_0.2.4.22-1~d70.wheezy+1.diff.gz
