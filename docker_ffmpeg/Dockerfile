FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    wget \
    git \
    unzip \
    build-essential

RUN cd ${HOME} && \
    wget https://dl.google.com/android/repository/android-ndk-r23b-linux.zip && \
    unzip android-ndk-r23b-linux.zip

RUN cd ${HOME} && \
    git clone git://source.ffmpeg.org/ffmpeg.git && \
    cd ffmpeg && \
    git checkout release/5.0

ENV ANDROID_NDK=/root/android-ndk-r23b/

COPY ffmpeg-build.bash /root

# compliance with ffmpeg license
RUN cd ${HOME}/ffmpeg && \
    git diff > changes.diff && \
    cd .. && \
    tar -czvf ffmpeg.tgz ffmpeg/

# do build
RUN cd ${HOME}/ffmpeg && \
    ${HOME}/ffmpeg-build.bash


# split ffmpeg.tgz to fit on github
RUN cd ${HOME} && \
    split -b 75MB ffmpeg.tgz ffmpeg_tgz