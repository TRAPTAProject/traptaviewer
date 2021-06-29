# Run this script by docker container as follow:
# docker run --rm -v ${PWD}:/host raspian_qt:1.0 bash /host/build.sh

#!/bin/bash
cd /home
echo "Creating package folder and copying files"
mkdir TRAPTAViewer && cd TRAPTAViewer
mkdir lib && cd lib
cp /usr/local/Qt-5.12.9/lib/libQt5Core.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5EglFSDeviceIntegration.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5Gui.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5Network.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5OpenGL.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5Qml.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5Quick.so.5 .
cp /usr/local/Qt-5.12.9/lib/libQt5Widgets.so.5 .
cp /opt/vc/lib/libbrcmGLESv2.so libGLESv2.so
cp /opt/vc/lib/libbrcmEGL.so libEGL.so
mkdir fonts && cd fonts
cp /usr/share/fonts/truetype/dejavu/* .
cd ../../
mkdir plugins && cd plugins
mkdir egldeviceintegrations && cd egldeviceintegrations
cp /usr/local/Qt-5.12.9/plugins/egldeviceintegrations/libqeglfs-brcm-integration.so .
cd ../
mkdir imageformats && cd imageformats
cp /usr/local/Qt-5.12.9/plugins/imageformats/libqjpeg.so .
cd ../
mkdir platforms && cd platforms
cp /usr/local/Qt-5.12.9/plugins/platforms/libqeglfs.so .
cd ../../
mkdir qml && cd qml
cp -R /usr/local/Qt-5.12.9/qml/Qt .
cp -R /usr/local/Qt-5.12.9/qml/QtQuick .
cp -R /usr/local/Qt-5.12.9/qml/QtQuick.2 .
cd ../
touch qt.conf
cd ..

echo "Cloning https://github.com/TRAPTAProject/traptaviewer.git into /home"
git clone https://github.com/TRAPTAProject/traptaviewer.git
echo "Compiling..."
cd traptaviewer
/usr/local/Qt-5.12.9/bin/qmake
make
cd ../TRAPTAViewer
echo "Copying to package folder"
cp ../traptaviewer/TRAPTAViewer .
echo "Make executable and adjust lib rpath in binary"
chmod +x ./TRAPTAViewer
chrpath -r ./lib/ ./TRAPTAViewer
cd ..
echo "Archiving and compressing"
tar zcvf traptaviewer-raspberry3.tar.gz package
echo "Copying archive to host folder"
cp traptaviewer-raspberry3.tar.gz /host


