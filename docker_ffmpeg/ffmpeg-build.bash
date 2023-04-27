#!/bin/bash
if [ -z "$ANDROID_NDK" ]; then
  echo "Please set ANDROID_NDK to the Android NDK folder"
  exit 1
fi

#Change to your local machine's architecture
HOST_OS_ARCH=linux-x86_64

function configure_ffmpeg {

  ABI=$1
  PLATFORM_VERSION=$2
  TOOLCHAIN_PATH=$ANDROID_NDK/toolchains/llvm/prebuilt/${HOST_OS_ARCH}/bin
#  local STRIP_COMMAND

  # Determine the architecture specific options to use
  case ${ABI} in
  armeabi-v7a)
    TOOLCHAIN_PREFIX=armv7a-linux-androideabi
#    STRIP_COMMAND=arm-linux-androideabi-strip
    ARCH=armv7-a
    ;;
  arm64-v8a)
    TOOLCHAIN_PREFIX=aarch64-linux-android
    ARCH=aarch64
    ;;
  x86)
    TOOLCHAIN_PREFIX=i686-linux-android
    ARCH=x86
    EXTRA_CONFIG="--disable-asm"
    ;;
  x86_64)
    TOOLCHAIN_PREFIX=x86_64-linux-android
    ARCH=x86_64
    EXTRA_CONFIG="--disable-asm"
    ;;
  esac

#  if [ -z ${STRIP_COMMAND} ]; then
#    STRIP_COMMAND=${TOOLCHAIN_PREFIX}-strip
#  fi

  echo "Configuring FFmpeg build for ${ABI}"
  echo "Toolchain path ${TOOLCHAIN_PATH}"
  echo "Command prefix ${TOOLCHAIN_PREFIX}"
#  echo "Strip command ${STRIP_COMMAND}"

  ./configure \
  --prefix=build/${ABI} \
  --target-os=android \
  --arch=${ARCH} \
  --enable-cross-compile \
  --cc=${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}${PLATFORM_VERSION}-clang \
  --strip=${TOOLCHAIN_PATH}/llvm-strip \
  --enable-small \
  --disable-programs \
  --disable-doc \
  --enable-shared \
  --disable-static \
  --disable-everything \
  --enable-decoder=mp3 \
  --enable-demuxer=mp3 \
  --enable-decoder=pcm* \
  --enable-decoder=wavpack \
  --enable-demuxer=pcm* \
  --enable-demuxer=wav \
  ${EXTRA_CONFIG}
  
  return $?
}

function build_ffmpeg {

  configure_ffmpeg $1 $2

  if [ $? -eq 0 ]
  then
          make clean
          make -j $(nproc)
          make install
  else
          echo "FFmpeg configuration failed, please check the error log."
  fi
}

API_VERSION=24
build_ffmpeg armeabi-v7a ${API_VERSION}
build_ffmpeg arm64-v8a ${API_VERSION}
build_ffmpeg x86 ${API_VERSION}
build_ffmpeg x86_64 ${API_VERSION}
