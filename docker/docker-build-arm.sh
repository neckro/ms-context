#!/bin/bash
set -ex

time docker build -t ffmpeg-arm ./ffmpeg-docker-arm
