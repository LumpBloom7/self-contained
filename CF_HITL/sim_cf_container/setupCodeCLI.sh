#!/usr/bin/env bash

cd ~

mkdir patchelf
cd patchelf
wget https://github.com/NixOS/patchelf/releases/download/0.18.0/patchelf-0.18.0-x86_64.tar.gz
tar -xf patchelf-0.18.0-x86_64.tar.gz
mv bin/patchelf /bin/patchelf

cd ~

mkdir -p crosstools
tar -xf sysroot.tar.gz 
mv sysroot/ crosstools/sysroot

curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
tar -xf vscode_cli.tar.gz
mv code /bin/code

rm -rf sysroot.tar.gz vscode_cli.tar.gz patchelf