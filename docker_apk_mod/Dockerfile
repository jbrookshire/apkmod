FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    wget \
    git \
    unzip \
    zip \
    build-essential \
    openjdk-8-jdk-headless \
    zipalign

#openjdk-17-jdk-headless
    
RUN cd ${HOME} && \
    wget https://dl.google.com/android/repository/android-ndk-r23b-linux.zip && \
    unzip android-ndk-r23b-linux.zip

ENV ANDROID_NDK=/root/android-ndk-r23b/

RUN cd ${HOME} && \
    wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/osx/apktool && \
    wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.6.1.jar && \
    mv apktool_2.6.1.jar apktool.jar && \
    chmod +x apktool* && \
    mv apktool apktool.jar /usr/local/bin

ENV KEY=${HOME}/quick.keystore
ENV PW=password

RUN cd ${HOME} && \
    keytool -genkey -noprompt -v \
    	    -keystore ${KEY} \
	    -alias sblquick \
    	    -keyalg RSA -keysize 2048 \
    	    -validity 10000 \
    	    -storepass ${PW} \
    	    -keypass ${PW} \
    	    -dname "CN=yourserver.com, OU=ID, O=ABC, L=Hursley, S=Hants, C=GB"


#COPY app-debug.apk /root/apks/
#ENV ORIG_APK=app-debug.apk

COPY app-normal-release.apk /root/apks/
ENV ORIG_APK=app-normal-release.apk

RUN cd ${HOME}/apks && \
    apktool d -o orig/ ${ORIG_APK}

#TODO: modify the directory orig

RUN cd ${HOME}/apks && \
    apktool b orig -o new.apk

RUN apt install -y apksigner

RUN cd ${HOME}/apks && \
    zipalign -v -p 4 new.apk new-aligned.apk

RUN cd ${HOME}/apks && \
    java -jar /usr/bin/apksigner sign --ks ${KEY} --ks-pass pass:${PW} new-aligned.apk


    
    