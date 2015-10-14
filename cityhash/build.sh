#!/bin/bash

ORIGINAL_DIR="$(pwd)"
DIR="$(mktemp -d)"
mkdir -p $DIR/toor/usr

cd $DIR

curl -L https://storage.googleapis.com/concord-libs/cityhash-1.1.1.tar.gz | tar zxf -

cd cityhash-1.1.1

./configure --prefix=$DIR/toor/usr

make && make install

cd $DIR/toor

echo fpm -a x86_64 --category misc -t deb -s dir \
  -v 1.1.1 -n cityhash-dev \
  -p $ORIGINAL_DIR/cityhash-1.1.1-dev.deb -- .

fpm -a x86_64 --category misc -t deb -s dir \
  -v 1.1.1 -n cityhash-dev \
  -p $ORIGINAL_DIR/cityhash-1.1.1-dev.deb -- .

