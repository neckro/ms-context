#!/bin/bash
set -ex

time docker build --progress=plain -t ffmpeg ./ffmpeg-docker
