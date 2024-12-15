#! /bin/false
#
# Source this, don't run it.
VERSION_PREFIX=
VERSION=14.2.0
VERSION_SUFFIX=
BUILD=2

SRCDIR=gcc
PKGNAME=gcc


# glibc version is obtained from the compilation enviroment using `ldd --version`
GLIBC_VERSION=`ldd --version | head -n 1 | cut -d' ' -f2-`

APTLY_REPO=janwilmans-debian12
APTLY_REPO_REASON="gcc-14.2 build for Debian 12 (bookworm) ${GLIBC_VERSION}"
