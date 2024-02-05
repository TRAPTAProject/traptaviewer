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
    QCoreApplication::setOrganizationDomain("trapta.fr");
    QCoreApplication::setApplicationName("TRAPTAViewer");

    HelloListener helloListener;
    SocketAdapter socketAdapter;

    QObject::connect(&helloListener, &HelloListener::hello,
                     &socketAdapter, &SocketAdapter::connectToServer);

    QQmlApplicationEngine engine;
    ListModel listModel;
    Controller controller;

    QObject::connect(&socketAdapter, &SocketAdapter::incomingJsonDocument,
                     &listModel, &ListModel::processJsonDocument);

    QObject::connect(&socketAdapter, &SocketAdapter::connected,
                     &controller, &Controller::connected);

    QObject::connect(&socketAdapter, &SocketAdapter::disconnected,
                     &controller, &Controller::disconnected);

    QObject::connect(&controller, &Controller::needToQuit,
                     &app, &QGuiApplication::quit);

    if (socketAdapter.isConnected()) controller.connected();
    else controller.disconnected(QString());

    listModel.processJsonDocument(socketAdapter.jsonDocument());

    engine.rootContext()->setContextProperty("listModel", &listModel);
    engine.rootContext()->setContextProperty("controller", &controller);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    app.exec();

    socketAdapter.quit();
    helloListener.quit();

}

