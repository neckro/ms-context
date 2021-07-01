  #!/bin/sh -x
./configure \
  --arch=amd64 \
  --target-os=linux \
  --prefix=/usr/local \
  --extra-cflags="-I/usr/local/include" \
  --extra-ldflags="-I/usr/local/lib" \
  --extra-libs="-lpthread -lm -latomic" \
  --disable-debug \
  --disable-doc \
  --enable-hardcoded-tables \
  --enable-nonfree \
  --enable-pthreads \
  --enable-gmp \
  --enable-gpl \
  --enable-static \
  --enable-version3 \
  --enable-libdrm               ` # enable DRM code (Linux) [no] ` \
` # ---- Raspberry Pi acceleration ` \
  --disable-mmal                ` # enable Broadcom Multi-Media Abstraction Layer (Raspberry Pi) via MMAL [no] ` \
  --enable-omx                  ` # enable OpenMAX IL code [no] ` \
  --disable-omx-rpi             ` # enable OpenMAX IL code for Raspberry Pi [no] ` \
` # ---- LIBRARIES ` \
  --enable-avisynth             ` # enable reading of AviSynth script files [no] ` \
  --enable-chromaprint          ` # enable audio fingerprinting with chromaprint [no] ` \
  --enable-frei0r               ` # enable frei0r video filtering [no] ` \
  --disable-gcrypt              ` # enable gcrypt, needed for rtmp(t)e support if openssl, librtmp or gmp is not used [no] ` \
  --disable-gmp                 ` # enable gmp, needed for rtmp(t)e support if openssl or librtmp is not used [no] ` \
  --disable-gnutls              ` # enable gnutls, needed for https support if openssl, libtls or mbedtls is not used [no] ` \
  --disable-jni                 ` # enable JNI support [no] ` \
  --enable-libaom               ` # enable AV1 video encoding/decoding via libaom [no] ` \
  --enable-ladspa               ` # enable LADSPA audio filtering [no] ` \
  --enable-libass               ` # enable libass subtitles rendering, needed for subtitles and ass filter [no] ` \
  --enable-libaribb24           ` # enable ARIB text and caption decoding via libaribb24 [no] ` \
  --enable-libbluray            ` # enable BluRay reading using libbluray [no] ` \
  --enable-libbs2b              ` # enable bs2b DSP library [no] ` \
  --enable-libcaca              ` # enable textual display using libcaca [no] ` \
` # libcelt not available via apt ` \
  ` # --enable-libcelt `        ` # enable CELT decoding via libcelt [no] ` \
  --disable-libcdio             ` # enable audio CD grabbing with libcdio [no] ` \
  --enable-libcodec2            ` # enable codec2 en/decoding using libcodec2 [no] ` \
  --enable-libdav1d             ` # enable AV1 decoding via libdav1d [no] ` \
  --enable-libdavs2             ` # enable AVS2 decoding via libdavs2 [no] ` \
  --enable-libfdk-aac           ` # enable AAC de/encoding via libfdk-aac [no] ` \
  --enable-libdc1394            ` # enable IIDC-1394 grabbing using libdc1394 and libraw1394 [no] ` \
  --enable-libfontconfig        ` # enable libfontconfig, useful for drawtext filter [no] ` \
` # package libflite1 does not work for build ` \
  ` # --enable-libflite `       ` # enable flite (voice synthesis) support via libflite [no] ` \
  --enable-libfreetype          ` # enable libfreetype, needed for drawtext filter [no] ` \
  --enable-libfribidi           ` # enable libfribidi, improves drawtext filter [no] ` \
  --enable-libglslang           ` # enable GLSL->SPIRV compilation via libglslang [no] ` \
  --enable-libgme               ` # enable Game Music Emu via libgme [no] ` \
  --enable-libgsm               ` # enable GSM de/encoding via libgsm [no] ` \
` # package libiec61883-dev does not work for build ` \
  ` # --enable-libiec61883 `    ` # enable iec61883 via libiec61883 [no] ` \
  --enable-libilbc              ` # enable iLBC de/encoding via libilbc [no] ` \
  --enable-libjack              ` # enable JACK audio sound server [no] ` \
  --enable-libkvazaar           ` # enable HEVC encoding via libkvazaar [no] ` \
` # libklvanc not available via apt ` \
  ` # --enable-libklvanc `      ` # enable Kernel Labs VANC processing [no] ` \
` # liblensfun build error ` \
  ` # --enable-liblensfun `     ` # enable lensfun lens correction [no] ` \
  --enable-libmp3lame           ` # enable MP3 encoding via libmp3lame [no] ` \
  --enable-libmodplug           ` # enable ModPlug via libmodplug [no] ` \
  --enable-libopencore-amrnb    ` # enable AMR-NB de/encoding via libopencore-amrnb [no] ` \
  --enable-libopencore-amrwb    ` # enable AMR-WB decoding via libopencore-amrwb [no] ` \
` # libopencv don't work ` \
  ` # --enable-libopencv `      ` # enable video filtering via libopencv [no] ` \
  --enable-libopenjpeg          ` # enable JPEG 2000 de/encoding via OpenJPEG [no] ` \
  --enable-libopenh264          ` # enable H.264 encoding via OpenH264 [no] ` \
  --enable-libopenmpt           ` # enable decoding tracked files via libopenmpt [no] ` \
  --enable-libopus              ` # enable Opus de/encoding via libopus [no] ` \
` # libopenvino not available via apt ` \
  ` # --enable-libopenvino `    ` # enable OpenVINO as a DNN module backend for DNN based filters like dnn_processing [no] ` \
  --enable-libpulse             ` # enable Pulseaudio input via libpulse [no] ` \
  --enable-librabbitmq          ` # enable RabbitMQ library [no] ` \
` # librav1e not available via apt ` \
  ` # --enable-librav1e `       ` # enable AV1 encoding via rav1e [no] ` \
  --enable-librist              ` # enable RIST via librist [no] ` \
  --enable-librsvg              ` # enable SVG rasterization via librsvg [no] ` \
  --disable-librtmp             ` # enable RTMP[E] support via librtmp [no] ` \
  --enable-librubberband        ` # enable rubberband needed for rubberband filter [no] ` \
  --enable-libshine             ` # enable fixed-point MP3 encoding via libshine [no] ` \
  --enable-libsnappy            ` # enable Snappy compression, needed for hap encoding [no] ` \
  --enable-libsmbclient         ` # enable Samba protocol via libsmbclient [no] ` \
  --enable-libsoxr              ` # enable Include libsoxr resampling [no] ` \
  --enable-libspeex             ` # enable Speex de/encoding via libspeex [no] ` \
  --enable-libssh               ` # enable SFTP protocol via libssh [no] ` \
` # libsrt don't work ` \
  ` # --enable-libsrt `         ` # enable Haivision SRT protocol via libsrt [no] ` \
  --enable-libsvtav1            ` # enable AV1 encoding via SVT [no] ` \
  ` # --enable-libtensorflow `  ` # enable TensorFlow as a DNN module backend  for DNN based filters like sr [no] ` \
  --enable-libtheora            ` # enable Theora encoding via libtheora [no] ` \
  --enable-libtesseract         ` # enable Tesseract, needed for ocr filter [no] ` \
  --disable-libtls              ` # enable LibreSSL (via libtls), needed for https support if openssl, gnutls or mbedtls is not used [no] ` \
  --enable-libtwolame           ` # enable MP2 encoding via libtwolame [no] ` \
` # libuabs3d not available via apt ` \
  ` # --enable-libuavs3d `      ` # enable AVS3 decoding via libuavs3d [no] ` \
  --enable-libv4l2              ` # enable libv4l2/v4l-utils [no] ` \
  --enable-libvmaf              ` # enable vmaf filter via libvmaf [no] ` \
  --enable-libvidstab           ` # enable video stabilization using vid.stab [no] ` \
  --enable-libvorbis            ` # enable Vorbis en/decoding via libvorbis, native implementation exists [no] ` \
  --enable-libvo-amrwbenc       ` # enable AMR-WB encoding via libvo-amrwbenc [no] ` \
  --enable-libvpx               ` # enable VP8 and VP9 de/encoding via libvpx [no] ` \
  --enable-libwebp              ` # enable WebP encoding via libwebp [no] ` \
  --enable-libx264              ` # enable H.264 encoding via x264 [no] ` \
  --enable-libx265              ` # enable HEVC encoding via x265 [no] ` \
` # libxavs not available via apt ` \
  ` # --enable-libxavs `        ` # enable AVS encoding via xavs [no] ` \
  --enable-libxavs2             ` # enable AVS2 encoding via xavs2 [no] ` \
  --disable-libxcb              ` # enable X11 grabbing using XCB [autodetect] ` \
  --disable-libxcb-shm          ` # enable X11 grabbing shm communication [autodetect] ` \
  --disable-libxcb-xfixes       ` # enable X11 grabbing mouse rendering [autodetect] ` \
  --disable-libxcb-shape        ` # enable X11 grabbing shape rendering [autodetect] ` \
  --disable-libxvid             ` # enable Xvid encoding via xvidcore, native MPEG-4/Xvid encoder exists [no] ` \
  --enable-libxml2              ` # enable XML parsing using the C library libxml2, needed for dash demuxing support [no] ` \
  --enable-libzimg              ` # enable z.lib, needed for zscale filter [no] ` \
  --enable-libzmq               ` # enable message passing via libzmq [no] ` \
  --enable-libzvbi              ` # enable teletext support via libzvbi [no] ` \
  --enable-lv2                  ` # enable LV2 audio filtering [no] ` \
  --disable-decklink            ` # enable Blackmagic DeckLink I/O support [no] ` \
  --disable-mbedtls             ` # enable mbedTLS, needed for https support if openssl, gnutls or libtls is not used [no] ` \
` # mediacodec not available via apt ` \
  ` # --enable-mediacodec `     ` # enable Android MediaCodec support [no] ` \
  --disable-mediafoundation     ` # enable encoding via MediaFoundation [auto] ` \
  --enable-libmysofa            ` # enable libmysofa, needed for sofalizer filter [no] ` \
  --disable-openal              ` # enable OpenAL 1.1 capture support [no] ` \
  --disable-opencl              ` # enable OpenCL processing [no] ` \
  --disable-opengl              ` # enable OpenGL rendering [no] ` \
  --enable-openssl              ` # enable openssl, needed for https support if gnutls, libtls or mbedtls is not used [no] ` \
  --enable-pocketsphinx         ` # enable PocketSphinx, needed for asr filter [no] ` \
  --disable-vapoursynth         ` # enable VapourSynth demuxer [no] ` \
` # ---- END LIBRARIES `
