#!/bin/bash

#git clone git@gitlab.vimec.nl:open-source/gcc.git
wget https://ftp.nluug.nl/languages/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.gz
tar xfz gcc-14.2.0.tar.gz
cp -R patch/* gcc-14.2.0/
