This repository provides a framework to unpackage an APK, modify the libraries within the APK, repackage and then sign a new APK.

Use:
1) Place your to-be-modified apk in `docker/app-normal-release.apk`
2) Run `./build.bash`
3) Run `./run.bash` to start a bash prompt into the docker
4) Modify the unpackaged APK in /root/apks/orig
5) Run the commands in the Dockerfile manually after the line starting with "TODO"