Format: 1.0
Source: tor
Binary: tor, tor-dbg, tor-geoipdb
Architecture: any all
Version: 0.2.4.23-2~d70.wheezy+1
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
 877135dcae4bacd2ce1f2a7d25fe4f614fe2ed8f 2977006 tor_0.2.4.23.orig.tar.gz
 c2b84f0bac96b1a9c3016f1adce31f526938f60f 34907 tor_0.2.4.23-2~d70.wheezy+1.diff.gz
Checksums-Sha256: 
 05a3793cfb66b694cb5b1c8d81226d0f7655031b0d5e6a8f5d9c4c2850331429 2977006 tor_0.2.4.23.orig.tar.gz
 f0a13f6527d208ed98ae0f0060027106b884183a0a0118859ea0848ceb36b150 34907 tor_0.2.4.23-2~d70.wheezy+1.diff.gz
Files: 
 9e39928e310612c3bffee727f554c63f 2977006 tor_0.2.4.23.orig.tar.gz
 20be23ae96a6c9e142bc097defe31f68 34907 tor_0.2.4.23-2~d70.wheezy+1.diff.gz
