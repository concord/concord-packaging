#!/bin/bash

ORIGINAL_DIR="$(pwd)"
DIR="$(mktemp -d)"
mkdir -p $DIR/toor/usr

cd $DIR

curl -L https://storage.googleapis.com/concord-libs/folly-0.31.0.tar.gz | tar zxf -

cd folly-0.31.0/folly

autoreconf -ivf
./configure --prefix=$DIR/toor/usr

make -j9 && make install

cd $DIR/toor

echo fpm -a x86_64 --category misc -t deb -s dir \
  -v 0.31.0 -n folly-dev \
  -p $ORIGINAL_DIR/folly-0.31.0-dev.deb -- .

fpm -a x86_64 --category misc -t deb -s dir \
  -v 0.31.0 -n folly-dev \
  -p $ORIGINAL_DIR/folly-0.31.0-dev.deb -- .

