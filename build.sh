#!/bin/bash -x

script_dir=$(realpath $(dirname $0))
prerequisites_dir=${script_dir}/prerequisites

. version.sh

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
