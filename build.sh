#!/bin/bash

if [ -d "etr.AppDir" ]
then
	rm -r etr.AppDir
fi

if [ -d "tmp" ]
then
	rm -r tmp
fi

mkdir tmp

wget https://sourceforge.net/projects/extremetuxracer/files/releases/0.8.0/etr-0.8.0.tar.xz/download -O tmp/etr.tar.xz
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage -O tmp/linuxdeploy-x86_64.AppImage
#wget https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage -O tmp/appimagetool-x86_64.AppImage

tar -xvf tmp/etr.tar.xz --directory tmp
cd tmp/etr-0.8.0
./configure --prefix="/tmp/etr"
make
make install DESTDIR=`pwd`/etr_data
cd etr_data
tar -cvzf ../../../tmp/etr_build.tar.gz tmp
cd ../../..

cp tmp/etr-0.8.0/etr_data/tmp/etr/share/pixmaps/etr.png tmp
mkdir -p etr.AppDir/usr/bin
mkdir -p etr.AppDir/usr/share
mv tmp/etr_build.tar.gz etr.AppDir/usr/share
cp -r src/* etr.AppDir/usr/share
mv etr.AppDir/usr/share/etr.sh etr.AppDir/usr/bin
cp `pwd`/tmp/etr.png etr.AppDir/usr/share/

ARCH=x86_64 ./tmp/linuxdeploy-x86_64.AppImage --appdir etr.AppDir -i `pwd`/tmp/etr.png -d `pwd`/etr.AppDir/usr/share/etr.desktop --output appimage

rm -r etr.AppDir
rm -r tmp
