# --- base
FROM debian:buster AS base

ENV BINDIR="/usr/local/bin"
ENV FFMPEG_SRC_URL="https://github.com/jjustman/ffmpeg-hls-pts-discontinuity-reclock/archive/f46551d510573b3a132dba0c52adf19101e2223a.tar.gz"
ENV FFMPEG_SRC_DIR="/usr/local/src/ffmpeg"

ENV INITSYSTEM on
ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get -q update &&\
  apt-get install -qy ca-certificates

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

RUN apt-get install -qy --no-install-recommends \
  build-essential \
  yasm \
  pkg-config \
  curl \
  cmake \
&& apt-get clean


# ffmpeg dependencies available through Debian
RUN apt-get install -qy --no-install-recommends \
  libaom-dev \
  libass-dev \
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
  libdav1d-dev \
  libfdk-aac-dev \
  libkvazaar-dev \
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
  libaom0 \
  libass9 \
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
  libdav1d1 \
  libfdk-aac2 \
  libkvazaar4 \
  libzimg2 \
&& apt-get clean

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/share /usr/local/share


# --- boom
FROM binary AS boom

ENTRYPOINT ["/usr/local/bin/ffmpeg"]
CMD ["--help"]
