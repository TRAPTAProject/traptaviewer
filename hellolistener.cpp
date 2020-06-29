#include "hellolistener.h"
#include <QStringList>

#define BINDING_TIMER 3000
#define BINDING_PORT 5433
#define BINDING_FALLBACK_PORT 5434

HelloListener::HelloListener() :
    QThread(),
    _udpSocket(0)
{

    moveToThread(this);
    _bindingTimer.setSingleShot(true);
    _bindingTimer.moveToThread(this);
    connect(&_bindingTimer, SIGNAL(timeout()), SLOT(bindToSocket()));
    this->start();
}

void HelloListener::bindToSocket() {
    qDebug() << "Hello Listener: Binding to socket";
    if (_udpSocket!=0) {
        _udpSocket->close();
        _udpSocket->deleteLater();
    }
    _udpSocket = new QUdpSocket();
    connect(_udpSocket, SIGNAL(readyRead()), SLOT(readPendingDatagrams()));
    connect(_udpSocket, SIGNAL(disconnected()), SLOT(bindToSocket()));
    if (!_udpSocket->bind(BINDING_PORT)) {
        qWarning() << "Cannot init udp socket on port " << BINDING_PORT;
        if (!_udpSocket->bind(BINDING_FALLBACK_PORT)) {
            qWarning() << "Cannot init udp socket on port " << BINDING_FALLBACK_PORT;
            _bindingTimer.start(BINDING_TIMER);
        }
    }
}


void HelloListener::readPendingDatagrams() {

    while (_udpSocket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(_udpSocket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        _udpSocket->readDatagram(datagram.data(), datagram.size(),
                                &sender, &senderPort);

        QString string(datagram.data());
        QStringList tab = string.split(",");
        if (tab.size()<6) return;
        QString host = tab[3];
        bool ok;
        int port = tab[5].toInt(&ok);
        if (!ok) return;
        emit hello(host, port);

    }
}

void HelloListener::run() {

    bindToSocket();
    exec();

}
