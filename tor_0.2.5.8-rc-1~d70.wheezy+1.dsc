Format: 1.0
Source: tor
Binary: tor, tor-dbg, tor-geoipdb
Architecture: any all
Version: 0.2.5.8-rc-1~d70.wheezy+1
Maintainer: Peter Palfrader <weasel@debian.org>
Homepage: https://www.torproject.org/
Standards-Version: 3.9.4
Vcs-Browser: https://gitweb.torproject.org/debian/tor.git
Vcs-Git: https://git.torproject.org/debian/tor.git
Build-Depends: debhelper (>= 8.1.0~), quilt, libssl-dev, zlib1g-dev, libevent-dev (>= 1.1), binutils (>= 2.14.90.0.7), hardening-includes, asciidoc (>= 8.2), docbook-xml, docbook-xsl, xmlto, dh-apparmor
Build-Conflicts: libnacl-dev, libseccomp-dev [!amd64 !i386]
Package-List: 
 tor deb net optional
 tor-dbg deb debug extra
 tor-geoipdb deb net extra
Checksums-Sha1: 
 e7766f21651f44e51209669dbf15893309fb57f9 3175566 tor_0.2.5.8-rc.orig.tar.gz
 6b940eb27160f479888ca054495bc7a66c5c65bd 34807 tor_0.2.5.8-rc-1~d70.wheezy+1.diff.gz
Checksums-Sha256: 
 a4c04e049f8c5798991eb5028fb2831ea2353bf12c7f5afa9c1df1472787b22c 3175566 tor_0.2.5.8-rc.orig.tar.gz
 67022ee9aee0928b61123a501f5b3de046626d4d5d7708bdbda56a08a0c2b3d9 34807 tor_0.2.5.8-rc-1~d70.wheezy+1.diff.gz
Files: 
 f72f4a9647b0e5ce01c7f126f6e54beb 3175566 tor_0.2.5.8-rc.orig.tar.gz
 8b50b00ef9330c32918b0feaeae33acf 34807 tor_0.2.5.8-rc-1~d70.wheezy+1.diff.gz
