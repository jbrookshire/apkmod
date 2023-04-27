#!/bin/bash

set -e

TAG=android_ffmpeg_build

docker build -t ${TAG} .

mkdir -p results
mkdir -p ffmpeg_src
CONTAINER_ID=$(docker create ${TAG})
docker cp ${CONTAINER_ID}:/root/ffmpeg/build/ results/
docker cp ${CONTAINER_ID}:/root/ffmpeg.tgz ffmpeg_src/
docker rm -v ${CONTAINER_ID}
