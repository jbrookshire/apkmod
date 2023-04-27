#!/bin/bash

TAG=android_apk_mod

docker run --rm -it \
       -v `pwd`/..:/root/rapu_android \
       ${TAG}
