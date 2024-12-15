#!/bin/bash -x

script_dir=$(realpath $(dirname $0))
prerequisites_dir=${script_dir}/prerequisites

VERSION_PREFIX=
VERSION=14.2.0
VERSION_SUFFIX=
BUILD=2

SRCDIR=gcc
PKGNAME=gcc

APTLY_REPO=janwilmans-debian12

# glibc version is obtained from the compilation enviroment using `ldd --version`
APTLY_REPO_REASON="gcc-14.2 build for Debian 12 (bookworm) (Debian GLIBC 2.36-9+deb12u9) 2.36"

SHORT_VERSION=$( echo "${VERSION}" | sed 's/\.[0-9]*$//' )

rm -rf debian
mkdir debian

DESTDIR=$(realpath debian)
echo "Destination: $DESTDIR"

# --prefix specifies the toplevel _installation_ directory

mkdir -p ${prerequisites_dir}
cd gcc-${VERSION}
./contrib/download_prerequisites --directory=${prerequisites_dir} --no-force
rm -rf build
mkdir build
cd build
../configure \
    --build=x86_64-linux-gnu \
    --host=x86_64-linux-gnu \
    --target=x86_64-linux-gnu \
    --enable-checking=release \
    --enable-libstdcxx-backtrace=yes \
    --disable-multilib \
    --program-suffix=-${SHORT_VERSION} \
    --prefix /opt/gcc-${SHORT_VERSION}
make -j8 || exit 1
make -i install-strip DESTDIR=$DESTDIR
