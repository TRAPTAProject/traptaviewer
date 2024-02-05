#ifndef SOCKETADAPTER_H
#define SOCKETADAPTER_H

#include <QTcpSocket>
#include <QStringList>
#include <QJsonDocument>
#include <QThread>
#include <QTimer>

class SocketAdapter : public QThread {

    Q_OBJECT
public:
    SocketAdapter();

    bool isConnected();
    QJsonDocument jsonDocument() const;

signals:
    void connected();
    void disconnected(QString error);
    void incomingJsonDocument(QJsonDocument jsonDoc);

public slots:
    void connectToServer(const QString& host = QString(), int port = 0);
    void disconnectedFromServer();
    void read();

private:

    QString _host;
    int _port;
    bool _connected;
    bool _closed;
    QTcpSocket _socket;
    QByteArray _byteArray;
    QJsonDocument _jsonDocument;

};

#endif // SOCKETADAPTER_H
