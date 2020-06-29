#ifndef HELLOLISTENER_H
#define HELLOLISTENER_H

#include <QObject>
#include <QUdpSocket>
#include <QThread>
#include <QTimer>

class HelloListener : public QThread {
    Q_OBJECT
public:
    HelloListener();

    void listen();
    
signals:
    
    void hello(QString host, int port);

private slots:

    void bindToSocket();
    void readPendingDatagrams();

private:


    QUdpSocket* _udpSocket;
    QTimer _bindingTimer;


    // QThread interface
protected:
    void run();
};

#endif // HELLOLISTENER_H
