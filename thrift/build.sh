#!/bin/bash

ORIGINAL_DIR="$(pwd)"
DIR="$(mktemp -d)"
mkdir -p $DIR/toor/usr

cd $DIR

curl -L https://storage.googleapis.com/concord-libs/thrift-0.9.2.tar.gz | tar zxf -

cd thrift-0.9.2

./configure --prefix=$DIR/toor/usr \
  --without-qt4 \
  --without-c_glib \
  --without-csharp \
  --without-java \
  --without-erlang \
  --without-nodejs \
  --without-lua \
  --without-python \
  --without-perl \
  --without-php \
  --without-php_extension \
  --without-ruby \
  --without-haskell \
  --without-go \
  --without-d

make -j9 && make install

cd $DIR/toor

echo fpm -a x86_64 --category misc -t deb -s dir \
  -v 0.9.2 -n thrift-dev \
  -p $ORIGINAL_DIR/thrift-0.9.2-dev.deb -- .

fpm -a x86_64 --category misc -t deb -s dir \
  -v 0.9.2 -n thrift-dev \
  -p $ORIGINAL_DIR/thrift-0.9.2-dev.deb -- .

