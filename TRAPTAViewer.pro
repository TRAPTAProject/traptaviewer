TARGET = TRAPTAViewer
TEMPLATE = app

QT += network qml quick
CONFIG += c++11
CONFIG += release

debug {
    DESTDIR = bin/debug
    MOC_DIR = build/lib/debug
    OBJECTS_DIR = build/lib/debug
}
release {
    DESTDIR = bin/release
    MOC_DIR = build/lib/release
    OBJECTS_DIR = build/lib/release
}

unix:!macx {
	QMAKE_LFLAGS += -no-pie
}

HEADERS += \
    controller.h \
    rowadvert.h \
    rowcateg.h \
    rowcut.h \
    rowmatch.h \
    rowmodel.h \
    rowposition.h \
    rowranking.h \
    rowteam.h \
    rowtitle.h \
    socketadapter.h \
    hellolistener.h \
    connectivity.h \
    listmodel.h \
    logging.h \
    global.h

SOURCES += main.cpp \
    controller.cpp \
    rowadvert.cpp \
    rowcateg.cpp \
    rowcut.cpp \
    rowmatch.cpp \
    rowmodel.cpp \
    rowposition.cpp \
    rowranking.cpp \
    rowteam.cpp \
    rowtitle.cpp \
    socketadapter.cpp \
    hellolistener.cpp \
    connectivity.cpp \
    listmodel.cpp

RESOURCES += \
    resources.qrc

RC_FILE = traptaviewer.rc
ICON = traptaviewer.icns
