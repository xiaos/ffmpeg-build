#!/bin/bash

echo "###### x264 ######"

SOURCE=$TARGET_X264_DIR
echo $SOURCE
cd $SOURCE

EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__"
EXTRA_LDFLAGS="-nostdlib"

./configure \
    --prefix=$PREFIX \
    --cross-prefix=$CROSS_PREFIX \
    --extra-cflags="$EXTRA_CFLAGS" \
    --extra-ldflags="$EXTRA_LDFLAGS" \
    --enable-static \
    --enable-pic \
    --enable-strip \
    --disable-cli \
    --host=arm-linux \
    --sysroot=$SYSROOT

make clean
make && make install

echo "###### x264######"
cd ../
