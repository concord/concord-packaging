#!/bin/bash

ORIGINAL_DIR="$(pwd)"
DIR="$(mktemp -d)"
mkdir $DIR/toor

cd $DIR

curl -L https://storage.googleapis.com/concord-libs/cityhash-1.1.1.tar.gz | tar zxf -

cd cityhash-1.1.1

./configure --prefix=$DIR/toor

make && make install

cd $DIR/toor

echo $ORIGINAL_DIR IS MY PWD

echo fpm -a x86_64 --category misc -t deb -s dir \
  -v 1.1.1 -n cityhash-dev \
  -p $ORIGINAL_DIR/cityhash-1.1.1-dev.deb -- .

fpm -a x86_64 --category misc -t deb -s dir \
  -v 1.1.1 -n cityhash-dev \
  -p $ORIGINAL_DIR/cityhash-1.1.1-dev.deb -- .

