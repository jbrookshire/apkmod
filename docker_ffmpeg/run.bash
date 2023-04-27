#!/bin/bash

TAG=android_ffmpeg_build

docker run --rm -it \
       -v `pwd`:/root/rapu_android/docker_ffmpeg \
       ${TAG}
