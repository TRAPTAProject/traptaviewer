#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "socketadapter.h"
#include "hellolistener.h"
#include <QTimer>
#include <QSettings>

class Controller : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int fontRatio READ fontRatio NOTIFY fontRatioChanged)
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)
    Q_PROPERTY(bool busy READ busy NOTIFY busyChanged)

    Q_PROPERTY(QString marquee READ marquee NOTIFY marqueeChanged)
    Q_PROPERTY(bool displayMarquee READ displayMarquee NOTIFY displayMarqueeChanged)
    Q_PROPERTY(bool positionChecked READ positionChecked NOTIFY positionCheckedChanged)
    Q_PROPERTY(bool progressChecked READ progressChecked NOTIFY progressCheckedChanged)
    Q_PROPERTY(bool trendChecked READ trendChecked NOTIFY trendCheckedChanged)
    Q_PROPERTY(bool clubChecked READ clubChecked NOTIFY clubCheckedChanged)

public:
    explicit Controller(QObject *parent = 0);

    QString message() const { return _message; }
    int fontRatio() const { return _fontRatio; }
    bool busy() const { return _busy; }
    int speed() const { return _speed; }

    QString marquee() const { return _marquee; }
    bool displayMarquee() const { return _displayMarquee; }

    bool positionChecked() const { return _positionChecked; }
    bool progressChecked() const { return _progressChecked; }
    bool trendChecked() const { return _trendChecked; }
    bool clubChecked() const { return _clubChecked; }

    QString status() const { return _status; }

public slots:

    void decFontRatio();
    void incFontRatio();
    void decSpeed();
    void incSpeed();

    void setMarquee(QString marquee);
    void setDisplayMarquee(bool displayMarquee);

    void setPositionChecked(bool checked);
    void setProgressChecked(bool checked);
    void setTrendChecked(bool checked);
    void setClubChecked(bool checked);

    void connected();
    void disconnected(QString msg);

    void quit();


signals:


    void fontRatioChanged(int fontRatio);
    void positionChanged(bool visible);
    void advertLineCountChanged(int advertLineCount);
    void messageChanged(QString message);
    void busyChanged(bool busy);
    void speedChanged(int speed);

    void marqueeChanged(QString marquee);
    void displayMarqueeChanged(bool displayMarquee);
    void positionCheckedChanged(bool positionChecked);
    void progressCheckedChanged(bool progessChecked);
    void trendCheckedChanged(bool trendChecked);
    void clubCheckedChanged(bool clubChecked);

    void needToQuit();
    void statusChanged(QString status);

private slots:
    void checkConnectionStatus();

private:

    QSettings _settings;

    int _fontRatio;
    QString _message;
    QString _status;
    QTimer _connectionTimer; // timer to get IP address

    bool _busy;
    bool _connected;
    int _speed;

    void setFontRatio(int fontRatio);
    void setSpeed(int speed);

    QString _marquee;
    bool _displayMarquee;
    bool _positionChecked;
    bool _progressChecked;
    bool _trendChecked;
    bool _clubChecked;


};

#endif // CONTROLLER_H
