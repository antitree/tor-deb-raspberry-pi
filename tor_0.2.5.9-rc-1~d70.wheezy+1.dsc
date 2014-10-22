Format: 1.0
Source: tor
Binary: tor, tor-dbg, tor-geoipdb
Architecture: any all
Version: 0.2.5.9-rc-1~d70.wheezy+1
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
 7fe7f0dd51503988049e1ad52334e07028737238 3166038 tor_0.2.5.9-rc.orig.tar.gz
 24963ac94a1ff32882b5a17dfd02d9e46f26817d 34376 tor_0.2.5.9-rc-1~d70.wheezy+1.diff.gz
Checksums-Sha256: 
 115863c35c7f9ff45e494c9981a89b6c7035f122cc07a44d034686e051b51d06 3166038 tor_0.2.5.9-rc.orig.tar.gz
 2bc42489933ff929f0c63f4f121a7f906184c6d588e42b85e39b965e513ee2a7 34376 tor_0.2.5.9-rc-1~d70.wheezy+1.diff.gz
Files: 
 9f120a07749e6b581a4017131463db09 3166038 tor_0.2.5.9-rc.orig.tar.gz
 e98b234a4f9dba112726d0b079ea163f 34376 tor_0.2.5.9-rc-1~d70.wheezy+1.diff.gz
