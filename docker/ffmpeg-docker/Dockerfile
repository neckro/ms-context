# --- base
FROM debian:sid AS base

ENV FFMPEG_SRC_URL="https://github.com/neckro/FFmpeg/archive/910786b5de.tar.gz"
ENV FFMPEG_SRC_DIR="/usr/local/src/ffmpeg"

ENV BINDIR="/usr/local/bin"

ENV INITSYSTEM on
ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get -q update &&\
  apt-get install -qy ca-certificates

# add deb-multimedia repo
RUN \
  echo "deb      http://www.deb-multimedia.org  sid   main non-free" >> /etc/apt/sources.list.d/zz-deb-multimedia.list &&\
  echo "deb-src  http://www.deb-multimedia.org  sid   main non-free" >> /etc/apt/sources.list.d/zz-deb-multimedia.list

# keep deb-multimedia's unsigned packages from taking priority over debian ones
RUN \
  echo "Package: *"                         >> /etc/apt/preferences.d/zz-deb-multimedia &&\
  echo "Pin: origin www.deb-multimedia.org" >> /etc/apt/preferences.d/zz-deb-multimedia &&\
  echo "Pin-Priority: 100"                  >> /etc/apt/preferences.d/zz-deb-multimedia

RUN \
  apt-get update -oAcquire::AllowInsecureRepositories=true &&\
  apt-get install -qy --no-install-recommends --allow-unauthenticated deb-multimedia-keyring &&\
  apt-get clean


# --- build
FROM base AS build

RUN apt-get install -qy --no-install-recommends \
  build-essential \
  yasm \
  pkg-config \
  curl \
  cmake \
&& apt-get clean

# ffmpeg dependencies available through Debian
RUN apt-get install -qy --no-install-recommends \
  frei0r-plugins-dev \
  glslang-dev \
  ladspa-sdk \
  libaom-dev \
  libaribb24-dev \
  libass-dev \
  libbluray-dev \
  libbs2b-dev \
  libcaca-dev \
  libchromaprint-dev \
  libcodec2-dev \
  libczmq-dev \
  libdav1d-dev \
  libdavs2-dev \
  libdc1394-dev \
  libdrm-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgme-dev \
  libgmp-dev \
  libgsm1-dev \
  libjack-dev \
  liblensfun-dev \
  liblilv-dev \
  libmodplug-dev \
  libmp3lame-dev \
  libmysofa-dev \
  libomxil-bellagio-dev \
  libopencore-amrnb-dev \
  libopencore-amrwb-dev \
  libopenjp2-7-dev \
  libopus-dev \
  libpocketsphinx-dev \
  libpulse-dev \
  librabbitmq-dev \
  libraw1394-dev \
  librsvg2-dev \
  librtmp-dev \
  librubberband-dev \
  libsmbclient-dev \
  libsnappy-dev \
  libsoxr-dev \
  libspeex-dev \
  libssh-dev \
  libssl-dev \
  libtheora-dev \
  libtwolame-dev \
  libv4l-dev \
  libvidstab-dev \
  libvo-amrwbenc-dev \
  libvorbis-dev \
  libvpx-dev \
  libwebp-dev \
  libx264-dev \
  libx265-dev \
  libxavs2-dev \
  libxml2-dev \
  libxvidcore-dev \
  libzvbi-dev \
&& apt-get clean

# ffmpeg dependencies available through deb-multimedia (unauthenticated)
RUN apt-get install -qy --no-install-recommends --allow-unauthenticated \
  avisynth+-dev \
  libdav1d5 \
  libfdk-aac-dev \
  libffms2-dev \
  libilbc-dev \
  libkvazaar-dev \
  libopenh264-dev \
  libopenmpt-dev \
  librist-dev \
  libshine-dev \
  libsvtav1-dev \
  libtesseract-dev \
  libvmaf-dev \
  libzimg-dev \
&& apt-get clean

# prepare to build
ENV CPUCOUNT=4
WORKDIR ${FFMPEG_SRC_DIR}

RUN curl -sD /dev/stderr -L ${FFMPEG_SRC_URL} | tar zx --strip-components=1

COPY config.sh .

RUN sh ./config.sh
RUN make -j${CPUCOUNT}
RUN make install


# --- binary
FROM base AS binary

# binary libs
RUN DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get install -qy --no-install-recommends \
  frei0r-plugins \
  libaom0 \
  libaribb24-0 \
  libass9 \
  libbluray2 \
  libbs2b0 \
  libcaca0 \
  libchromaprint1 \
  libcodec2-0.9 \
  libczmq4 \
  libdav1d4 \
  libdavs2-16 \
  libdc1394-25 \
  libdrm2 \
  libfontconfig \
  libfribidi0 \
  libgme0 \
  libgsm1 \
  libjack0 \
  liblensfun1 \
  liblilv-0-0 \
  libmodplug1 \
  libmp3lame0 \
  libmysofa1 \
  libopencore-amrnb0 \
  libopencore-amrwb0 \
  libopencv-core4.5 \
  libopenjp2-7 \
  libopenmpt0 \
  libopus0 \
  libpocketsphinx3 \
  libpulse0 \
  librabbitmq4 \
  libraw1394-11 \
  librsvg2-2 \
  librubberband2 \
  libshine3 \
  libsmbclient \
  libsnappy1v5 \
  libsoxr0 \
  libspeex1 \
  libssh-4 \
  libtesseract4 \
  libtheora0 \
  libtwolame0 \
  libv4l-0 \
  libvidstab1.1 \
  libvo-amrwbenc0 \
  libvorbis0a \
  libvorbisenc2 \
  libvpx6 \
  libwebpmux3 \
  libx264-160 \
  libx265-192 \
  libxavs2-13 \
  libxml2 \
  libxvidcore4 \
  libzvbi0 \
&& apt-get clean

# binary libs (from deb-multimedia)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends --allow-unauthenticated \
  avisynth+ \
  libfdk-aac2 \
  libilbc3 \
  libkvazaar6 \
  libopenh264-6 \
  librist4 \
  libsvtav1-0 \
  libvmaf1 \
  libzimg2 \
&& apt-get clean

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/share /usr/local/share


# --- boom
FROM binary AS boom

ENTRYPOINT ["/usr/local/bin/ffmpeg"]
CMD ["--help"]
