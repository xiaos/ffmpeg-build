#!/bin/bash

echo "###### start to compile ffmpeg ######"

SOURCE=$TARGET_FFMPEG_DIR
echo $SOURCE
cd $SOURCE


ADD_H264_FEATURE="--enable-encoder=aac \
    --enable-decoder=aac \
    --enable-gpl \
    --enable-encoder=libx264 \
    --enable-libx264 \
    --extra-cflags=-I$PREFIX/include \
    --extra-ldflags=-L$PREFIX/lib "

echo $ADD_H264_FEATURE

function build_one_so
{
    ./configure \
        --prefix=$PREFIX \
        --disable-shared \
        --enable-pthreads \
        --enable-gpl \
        --enable-version3 \
        --enable-nonfree \
        --enable-static \
        --disable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
        --disable-doc \
        --disable-symver \
        --disable-avdevice \
        --disable-avfilter \
        --enable-libx264 \
        --enable-small \
        --enable-asm \
        --enable-neon \
        --cross-prefix=$CROSS_PREFIX \
        --target-os=linux \
        --arch=arm \
        --enable-cross-compile \
        --enable-runtime-cpudetect \
        --sysroot=$SYSROOT \
        --disable-parsers \
        --enable-parser=aac \
        --enable-parser=h264 \
        --enable-parser=mjpeg \
        --enable-parser=png \
        --enable-parser=bmp \
        --enable-parser=mpegvideo \
        --enable-parser=mpegaudio \
        --disable-encoders \
        --enable-encoder=libx264 \
        --enable-encoder=aac \
        --enable-encoder=png \
        --disable-decoders \
        --enable-decoder=h263 \
        --enable-decoder=h264 \
        --enable-decoder=mpeg4 \
        --enable-decoder=mjpeg \
        --enable-decoder=gif \
        --enable-decoder=mp3 \
        --enable-decoder=aac \
        --enable-decoder=png \
        --enable-decoder=bmp \
        --enable-decoder=yuv4 \
        --disable-network \
        --enable-protocols \
        --disable-protocol=concat \
        --disable-protocol=hls \
        --enable-protocol=file \
        --disable-demuxers \
        --enable-demuxer=h263 \
        --enable-demuxer=h264 \
        --enable-demuxer=flv \
        --enable-demuxer=gif \
        --enable-demuxer=aac \
        --enable-demuxer=ogg \
        --enable-demuxer=dts \
        --enable-demuxer=mp3 \
        --enable-demuxer=mov \
        --enable-demuxer=m4v \
        --enable-demuxer=concat \
        --enable-demuxer=mpegts \
        --enable-demuxer=mjpeg \
        --enable-demuxer=mpegvideo \
        --enable-demuxer=rawvideo \
        --enable-demuxer=yuv4mpegpipe \
        --disable-muxers \
        --enable-muxer=mp4 \
        --disable-filters \
       #	--enable-filter=asetpts \
        --extra-cflags="-mfloat-abi=softfp -mfpu=neon -marm -march=armv7-a" \
        $ADD_H264_FEATURE

    make clean
    make -j4
    make install
}

build_one_so

echo "###### ffmpeg compile done ######"
cd ../
