#!/bin/bash

ORIGINAL_DIR="$(pwd)"
DIR="$(mktemp -d)"
mkdir -p $DIR/toor/usr

cd $DIR

curl -L https://storage.googleapis.com/concord-libs/rocksdb-3.11.2.tar.gz | tar zxf -

cd rocksdb-3.11.2

PORTABLE=1 INSTALL_PATH=$DIR/toor/usr make -j9 install-shared

cd $DIR/toor

echo fpm -a x86_64 --category misc -t deb -s dir \
  -v 3.11.2 -n rocksdb-dev \
  -p $ORIGINAL_DIR/rocksdb-3.11.2-dev.deb -- .

fpm -a x86_64 --category misc -t deb -s dir \
  -v 3.11.2 -n rocksdb-dev \
  -p $ORIGINAL_DIR/rocksdb-3.11.2-dev.deb -- .

