Take a 16GB sd card and flash Pi OS.

Then:

wget https://download.qt.io/archive/qt/5.12/5.12.9/single/qt-everywhere-src-5.12.9.tar.xz 
tar xf qt-everywhere-src-5.12.9.tar.xz
cd qt-everywhere-src-5.12.9
rm -rf web* qt3d qtmultimedia qtvirtualkeyboard qtscript qtremoteobjects qtlocation qtandroidextras qtcanvas3d qtcharts qtdatavis3d qtgamepad qtmacextras qtpurchasing qtscxml qtsensors qtserialbus qtserialport qtspeech qtvirtualkeyboard qtwinextras qtwebchannel qtwebengine qtwebglplugin qtwebsockets qtwebview qtwayland qtxmlpatterns qtgraphicaleffects qtconnectivity qtactiveqt qtnetworkauth qttools qtlottie qtquick3d qtquicktimeline
cd ..
git clone https://github.com/oniongarlic/qt-raspberrypi-configuration.git
cd qt-raspberrypi-configuration
make install DESTDIR=../qt-everywhere-src-5.12.9
cd ..
sudo apt-get update
sudo apt-get -y install \
    build-essential \
    libfontconfig1-dev \
    libdbus-1-dev \
    libfreetype6-dev \
    libicu-dev \
    libinput-dev \
    libxkbcommon-dev \
    libsqlite3-dev \
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    libglib2.0-dev \
    libraspberrypi-dev \
    chrpath

$ sudo dphys-swapfile swapoff
$ sudo dphys-swapfile uninstall
$ sudo nano /etc/dphys-swapfile
 
 	CONF_SWAPSIZE=2000 # instead of 100
 
$ sudo dphys-swapfile setup
$ sudo dphys-swapfile swapon
 
# check that a ~2GB swap file is active now
$ cat /proc/swaps

# Make a shadow build
mkdir build
cd build

PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/share/pkgconfig ../qt-everywhere-src-5.12.9/configure -platform linux-rpi3-g++ -v -opengl es2 -eglfs -qpa eglfs -no-gtk -opensource -confirm-license -release -reduce-exports -force-pkg-config -nomake examples -no-compile-examples -qt-pcre -no-pch -no-xcb -no-icu -no-dbus -no-cups -no-tslib -make libs -sql-sqlite -no-openssl -evdev -system-freetype -fontconfig -glib

Output:
Configure summary:

Build type: linux-rpi3-g++ (arm, CPU features: neon)
Compiler: gcc 8.3.0
Configuration: enable_new_dtags largefile neon shared shared rpath release c++11 c++14 c++1z concurrent reduce_exports stl
Build options:
  Mode ................................... release
  Optimize release build for size ........ no
  Building shared libraries .............. yes
  Using C standard ....................... C11
  Using C++ standard ..................... C++17
  Using ccache ........................... no
  Using new DTAGS ........................ yes
  Relocatable ............................ yes
  Using precompiled headers .............. no
  Using LTCG ............................. no
  Target compiler supports:
    NEON ................................. yes
  Build parts ............................ libs
Qt modules and options:
  Qt Concurrent .......................... yes
  Qt D-Bus ............................... no
  Qt D-Bus directly linked to libdbus .... no
  Qt Gui ................................. yes
  Qt Network ............................. yes
  Qt Sql ................................. yes
  Qt Testlib ............................. yes
  Qt Widgets ............................. yes
  Qt Xml ................................. yes
Support enabled for:
  Using pkg-config ....................... yes
  udev ................................... yes
  Using system zlib ...................... yes
  Zstandard support ...................... no
Qt Core:
  DoubleConversion ....................... yes
    Using system DoubleConversion ........ no
  GLib ................................... yes
  iconv .................................. yes
  ICU .................................... no
  Built-in copy of the MIME database ..... yes
  Tracing backend ........................ <none>
  Logging backends:
    journald ............................. no
    syslog ............................... no
    slog2 ................................ no
  PCRE2 .................................. yes
    Using system PCRE2 ................... no
Qt Network:
  getifaddrs() ........................... yes
  IPv6 ifname ............................ yes
  libproxy ............................... no
  Linux AF_NETLINK ....................... yes
  OpenSSL ................................ no
    Qt directly linked to OpenSSL ........ no
  OpenSSL 1.1 ............................ no
  DTLS ................................... no
  OCSP-stapling .......................... no
  SCTP ................................... no
  Use system proxies ..................... yes
  GSSAPI ................................. no
Qt Gui:
  Accessibility .......................... yes
  FreeType ............................... yes
    Using system FreeType ................ yes
  HarfBuzz ............................... yes
    Using system HarfBuzz ................ no
  Fontconfig ............................. yes
  Image formats:
    GIF .................................. yes
    ICO .................................. yes
    JPEG ................................. yes
      Using system libjpeg ............... yes
    PNG .................................. yes
      Using system libpng ................ yes
  Text formats:
    HtmlParser ........................... yes
    CssParser ............................ yes
    OdfWriter ............................ yes
    MarkdownReader ....................... yes
      Using system libmd4c ............... no
    MarkdownWriter ....................... yes
  EGL .................................... yes
  OpenVG ................................. yes
  OpenGL:
    Desktop OpenGL ....................... no
    OpenGL ES 2.0 ........................ yes
    OpenGL ES 3.0 ........................ no
    OpenGL ES 3.1 ........................ no
    OpenGL ES 3.2 ........................ no
  Vulkan ................................. no
  Session Management ..................... yes
Features used by QPA backends:
  evdev .................................. yes
  libinput ............................... yes
  INTEGRITY HID .......................... no
  mtdev .................................. yes
  tslib .................................. no
  xkbcommon .............................. yes
  X11 specific:
    XLib ................................. no
    XCB Xlib ............................. no
    EGL on X11 ........................... no
QPA backends:
  DirectFB ............................... no
  EGLFS .................................. yes
  EGLFS details:
    EGLFS OpenWFD ........................ no
    EGLFS i.Mx6 .......................... no
    EGLFS i.Mx6 Wayland .................. no
    EGLFS RCAR ........................... no
    EGLFS EGLDevice ...................... no
    EGLFS GBM ............................ no
    EGLFS VSP2 ........................... no
    EGLFS Mali ........................... no
    EGLFS Raspberry Pi ................... yes
    EGLFS X11 ............................ no
  LinuxFB ................................ yes
  VNC .................................... yes
Qt Sql:
  SQL item models ........................ yes
Qt Widgets:
  GTK+ ................................... no
  Styles ................................. Fusion Windows
Qt PrintSupport:
  CUPS ................................... no
Qt Sql Drivers:
  DB2 (IBM) .............................. no
  InterBase .............................. no
  MySql .................................. no
  OCI (Oracle) ........................... no
  ODBC ................................... no
  PostgreSQL ............................. no
  SQLite2 ................................ no
  SQLite ................................. yes
    Using system provided SQLite ......... no
  TDS (Sybase) ........................... no
Qt Testlib:
  Tester for item models ................. yes
Further Image Formats:
  JasPer ................................. no
  MNG .................................... no
  TIFF ................................... yes
    Using system libtiff ................. no
  WEBP ................................... yes
    Using system libwebp ................. no
Qt QML:
  QML network support .................... yes
  QML debugging and profiling support .... yes
  QML just-in-time compiler .............. yes
  QML sequence object .................... yes
  QML XML http request ................... yes
  QML Locale ............................. yes
Qt QML Models:
  QML list model ......................... yes
  QML delegate model ..................... yes
Qt Quick:
  Direct3D 12 ............................ no
  AnimatedImage item ..................... yes
  Canvas item ............................ yes
  Support for Qt Quick Designer .......... yes
  Flipable item .......................... yes
  GridView item .......................... yes
  ListView item .......................... yes
  TableView item ......................... yes
  Path support ........................... yes
  PathView item .......................... yes
  Positioner items ....................... yes
  Repeater item .......................... yes
  ShaderEffect item ...................... yes
  Sprite item ............................ yes

Qt is now configured for building. Just run 'make'.
Once everything is built, you must run 'make install'.
Qt will be installed into '/usr/local/Qt-5.14.2'.

make -j2
sudo make install
cd
git clone https://github.com/TRAPTAProject/traptaviewer.git
/usr/local/Qt-5.12.9/bin/qmake
make -j2

readelf -d ./traptaviewer0x00000001 (NEEDED)                     Shared library: [libQt5Quick.so.5]
 0x00000001 (NEEDED)                     Shared library: [libQt5Gui.so.5]
 0x00000001 (NEEDED)                     Shared library: [libQt5QmlModels.so.5]
 0x00000001 (NEEDED)                     Shared library: [libQt5Qml.so.5]
 0x00000001 (NEEDED)                     Shared library: [libQt5Network.so.5]
 0x00000001 (NEEDED)                     Shared library: [libQt5Core.so.5]
 0x00000001 (NEEDED)                     Shared library: [libbrcmGLESv2.so]
 0x00000001 (NEEDED)                     Shared library: [libbrcmEGL.so]
 0x00000001 (NEEDED)                     Shared library: [libpthread.so.0]
 0x00000001 (NEEDED)                     Shared library: [libstdc++.so.6]
 0x00000001 (NEEDED)                     Shared library: [libm.so.6]
 0x00000001 (NEEDED)                     Shared library: [libgcc_s.so.1]
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]
 0x0000001d (RUNPATH)                    Library runpath: [./lib]

