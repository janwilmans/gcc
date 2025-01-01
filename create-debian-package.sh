#!/bin/bash

. version.sh

SHORT_VERSION=$( echo "${VERSION}" | sed 's/\.[0-9]*$//' )

cp -R DEBIAN debian/

# Make includes and library available at expected location, note that the symlinks
# are absolute but created in DESTDIR.
mkdir -p debian/usr/lib/gcc/x86_64-linux-gnu/ debian/usr/include/c++/
ln -sf /opt/gcc-${SHORT_VERSION}/lib/gcc/x86_64-linux-gnu/${VERSION}/ debian/usr/lib/gcc/x86_64-linux-gnu/${VERSION}
ln -sf /opt/gcc-${SHORT_VERSION}/include/c++/${VERSION}/ debian/usr/include/c++/${VERSION}
# Remove accidental pythons
rm -rf debian/opt/gcc-${SHORT_VERSION}-runtime/lib64/*.py

# Note SHORT_VERSION needs to be before VERSION, because VERSION is a
# substring of the former (otherwise you get SHORT_13.1.0, for instance).
sed -i \
    -e s/SIZE/`du -sk debian | cut -f1`/ \
    -e s/SHORT_VERSION/$SHORT_VERSION/g \
    -e s/VERSION/$VERSION/g \
    -e s/BUILD/$BUILD/ \
    debian/DEBIAN/control \
    debian/DEBIAN/postinst \
    debian/DEBIAN/postrm

# --root-owner-group makes sure all packaged files are owned by root
dpkg-deb --build --root-owner-group debian ${PKGNAME}_${VERSION}-${BUILD}_amd64.deb
