#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "controller.h"
#include "listmodel.h"
#include "hellolistener.h"
#include "logging.h"

int main(int argc, char *argv[]) {

    INIT_LOG

    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("TRAPTA");
    QCoreApplication::setOrganizationDomain("trapta.eu");
    QCoreApplication::setApplicationName("TRAPTAViewer");

    HelloListener helloListener;
    SocketAdapter socketAdapter;

    QObject::connect(&helloListener, SIGNAL(hello(QString,int)),
                     &socketAdapter, SLOT(connectToServer(QString,int)));

    ListModel listModel;
    Controller controller;

    QObject::connect(&socketAdapter, SIGNAL(incomingJsonDocument(QJsonDocument)),
                     &listModel, SLOT(processJsonDocument(QJsonDocument)));

    QObject::connect(&socketAdapter, SIGNAL(connected()),
                     &controller, SLOT(connected()));

    QObject::connect(&socketAdapter, SIGNAL(disconnected(QString)),
                     &controller, SLOT(disconnected(QString)));

    QObject::connect(&controller, SIGNAL(needToQuit()),
                     &socketAdapter, SLOT(close()));

    QObject::connect(&socketAdapter, SIGNAL(closed()),
                     &app, SLOT(quit()));

    if (socketAdapter.isConnected()) controller.connected();
    else controller.disconnected(QString());

    listModel.processJsonDocument(socketAdapter.jsonDocument());

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("listModel", &listModel);
    engine.rootContext()->setContextProperty("controller", &controller);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    app.exec();

    socketAdapter.quit();
    helloListener.quit();

}

