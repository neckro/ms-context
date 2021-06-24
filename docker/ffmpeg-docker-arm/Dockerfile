# --- base
FROM balenalib/rpi-raspbian:buster AS base

ENV INITSYSTEM on
ENV BINDIR="/usr/local/bin"
ENV FFMPEG_SRC_URL="https://github.com/jjustman/ffmpeg-hls-pts-discontinuity-reclock/archive/f46551d510573b3a132dba0c52adf19101e2223a.tar.gz"
ENV FFMPEG_SRC_DIR="/usr/local/src/ffmpeg"

ENV DEBIAN_FRONTEND=noninteractive

RUN \
  rm -f /etc/apt/sources.list &&\
  rm -rf /etc/apt/sources.list.d &&\
  mkdir /etc/apt/sources.list.d &&\
  echo "deb      http://archive.raspberrypi.org/debian     buster  main" >> /etc/apt/sources.list &&\
  echo "deb-src  http://archive.raspberrypi.org/debian     buster  main" >> /etc/apt/sources.list &&\
  echo "deb      http://raspbian.raspberrypi.org/raspbian  buster  main contrib non-free rpi" >> /etc/apt/sources.list &&\
  echo "deb-src  http://raspbian.raspberrypi.org/raspbian  buster  main contrib non-free rpi" >> /etc/apt/sources.list

# For whatever reason, if ca-certificates isn't removed first then
# the current certs don't get installed (and curl doesn't like that)
RUN \
  apt-get -q update &&\
  apt-get purge ca-certificates &&\
  apt-get install -qy ca-certificates &&\
  apt-get install -qy --no-install-recommends build-essential pkg-config curl git cmake &&\
  apt-get clean

# build rpi userspace libs
WORKDIR "/usr/local"
RUN git clone --depth 1 https://github.com/raspberrypi/userland.git rpi-userland
WORKDIR "/usr/local/rpi-userland"
RUN ./buildme && echo "/opt/vc/lib" > /etc/ld.so.conf.d/00-vmcs.conf && ldconfig

# add deb-multimedia repo
RUN \
  echo "deb      http://www.deb-multimedia.org  buster   main non-free" >> /etc/apt/sources.list.d/zz-deb-multimedia.list &&\
  echo "deb-src  http://www.deb-multimedia.org  buster   main non-free" >> /etc/apt/sources.list.d/zz-deb-multimedia.list

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

# ffmpeg dependencies available through Debian
RUN apt-get install -qy --no-install-recommends \
  libaom-dev \
  libass-dev \
  libdav1d-dev \
  libdrm-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgmp-dev \
  libmp3lame-dev \
  libopencore-amrnb-dev \
  libopencore-amrwb-dev \
  libopenjp2-7-dev \
  libopus-dev \
  libomxil-bellagio-dev \
  librtmp-dev \
  libsnappy-dev \
  libsoxr-dev \
  libssh-dev \
  libssl-dev \
  libwebp-dev \
  libxml2-dev \
  libtheora-dev \
  libvorbis-dev \
  libvpx-dev \
  libwavpack-dev \
  libx264-dev \
  libx265-dev \
  libxvidcore-dev \
&& apt-get clean

# ffmpeg dependencies available through deb-multimedia (unauthenticated)
RUN apt-get install -qy --no-install-recommends --allow-unauthenticated \
  libfdk-aac-dev \
  libkvazaar-dev \
  libzimg-dev \
&& apt-get clean

# add bullseye
RUN \
  echo "deb      http://www.deb-multimedia.org  sid main non-free" >> /etc/apt/sources.list.d/zz-deb-multimedia.list &&\
  echo "deb-src  http://www.deb-multimedia.org  sid main non-free" >> /etc/apt/sources.list.d/zz-deb-multimedia.list

# add avisynth
RUN \
  apt-get update &&\
  apt-get install -qy --no-install-recommends --allow-unauthenticated \
    avisynth+-dev \
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
apt-get install -qy --no-install-recommends \
  libaom0 \
  libass9 \
  libdav1d3 \
  libdrm2 \
  libfontconfig \
  libfribidi0 \
  libmp3lame0 \
  libopencore-amrwb0 \
  libopencore-amrnb0 \
  libopenjp2-7 \
  libopus0 \
  libsnappy1v5 \
  libssh-4 \
  libsoxr0 \
  libtheora0 \
  libx264-155 \
  libx265-165 \
  libvorbis0a \
  libvorbisenc2 \
  libvpx5 \
  libwavpack1 \
  libwebpmux3 \
  libxml2 \
  libxvidcore4 \
&& apt-get clean

# binary libs (from deb-multimedia)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends --allow-unauthenticated \
  libfdk-aac2 \
  libkvazaar4 \
  libzimg2 \
&& apt-get clean

# now we can install the dep(s) from bullseye
COPY --from=build /etc/apt /etc/apt
RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends --allow-unauthenticated \
  avisynth+-dev \
&& apt-get clean

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/share /usr/local/share


# --- boom
FROM binary AS boom

ENTRYPOINT ["/usr/local/bin/ffmpeg"]
CMD ["--help"]
