#include "socketadapter.h"
#include <QAbstractSocket>
#include <QJsonParseError>
#include <QJsonDocument>

#define SOCKET_TIMER 3000

SocketAdapter::SocketAdapter() : QThread(),
    _socket(0),
    _port(0),
    _connected(false),
    _closed(false)
{
    moveToThread(this);

    _socket.moveToThread(this);
    connect(&_socket, SIGNAL(disconnected()), SLOT(disconnectedFromServer()));
    connect(&_socket, SIGNAL(readyRead()), SLOT(read()));

    this->start();

}

bool SocketAdapter::isConnected() {
    return _connected;
}

QJsonDocument SocketAdapter::jsonDocument() const {
    return _jsonDocument;
}

void SocketAdapter::connectToServer(const QString& host, int port) {

    if (_socket.isOpen() || _closed) return;
    //UGLY workaround - we need to clear writebuffer before reusing this socket
    //https://bugreports.qt-project.org/browse/QTBUG-28914
    _socket.connectToHost("",0);
    _socket.abort();
    _socket.connectToHost(host, port);
    if (!_socket.waitForConnected(5000)) {
        qCritical() << "Cannot connect to TRAPTA !";
        emit disconnected(QString("Délai dépassé pour se connecter à TRAPTA serveur (hote=%0, port=%1)").arg(host, port));
        return;
    }
    emit connected();
    _connected = true;
}

void SocketAdapter::disconnectedFromServer() {
    qDebug() << "Disconnecting from server";
    _socket.close();
    _connected = false;
    emit disconnected("Déconnecté de TRAPTA serveur");

}

void SocketAdapter::read() {
    qDebug() << "Reading from socket";
    int n = 0;
    while ((n=_socket.bytesAvailable())>0) {
        qDebug() << n << "bytes are available in socket";
        char c;
        bool eof = false;
        while (!eof) {
            bool ok = _socket.getChar(&c);
            if (!ok) break;
            if (c==(char)4) {
                eof = true;
                break;
            }
            if (c!='\n') _byteArray.append(c);
        }
        if (!eof) continue;

        // we've reached eof char, process
        QJsonParseError parseError;
        QJsonDocument jsonDoc = QJsonDocument::fromJson(_byteArray, &parseError);
        _byteArray.clear();
        if (jsonDoc.isNull()) {
            qDebug() << "Parsing error: " << parseError.errorString() << " offset: " << parseError.offset;
            continue;
        }
        if (parseError.error==QJsonParseError::NoError) {
            _jsonDocument = jsonDoc;
            emit incomingJsonDocument(jsonDoc);
            continue;
        }
        qDebug() << "Error while parsing json doc: " << parseError.errorString() << " offset:" << parseError.offset;
    }
}




