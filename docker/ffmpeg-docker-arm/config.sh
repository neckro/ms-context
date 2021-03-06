#!/bin/sh -x
./configure \
  --arch=armel \
  --target-os=linux \
  --prefix=/usr/local \
  --extra-cflags="-I/usr/local/include -I/opt/vc/include -I/opt/vc/include/IL" \
  --extra-ldflags="-I/usr/local/lib -I/opt/vc/lib" \
  --extra-libs="-lpthread -lm -latomic" \
  --disable-debug \
  --disable-doc \
  --enable-avisynth \
  --enable-gmp \
  --enable-gpl \
  --enable-hardcoded-tables \
  --enable-libaom \
  --enable-libass \
  --enable-libdav1d \
  --enable-libdrm \
  --enable-libfdk-aac \
  --enable-libfontconfig \
  --enable-libfreetype \
  --enable-libfribidi \
  --enable-libkvazaar \
  --enable-libmp3lame \
  --enable-libopencore-amrnb \
  --enable-libopencore-amrwb \
  --enable-libopenjpeg \
  --enable-libopus \
  --disable-librtmp \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libssh \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libzimg \
  --enable-libwebp \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libxvid \
  --enable-libxml2 \
  --enable-mmal \
  --enable-nonfree \
  --enable-omx \
  --enable-omx-rpi \
  --enable-openssl \
  --enable-pthreads \
  --enable-static \
  --enable-version3
