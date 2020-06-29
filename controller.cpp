#include "controller.h"
#include <QQmlEngine>
#include <QDebug>
#include <QSettings>
#include <QThread>
#include "connectivity.h"
#include "global.h"

#define CONNECTION_TIMER 3000
#define SETTINGS_FONTRATIO "fontRatio"
#define SETTINGS_SPEED "speed"
#define SETTINGS_MARQUEE "marquee"
#define SETTINGS_DISPLAYMARQUEE "displayMarquee"
#define SETTINGS_POSITION "positionChecked"
#define SETTINGS_PROGRESS "progressChecked"
#define SETTINGS_TREND "trendChecked"
#define SETTINGS_CLUB "clubChecked"

#define MARQUEE_DEFAULT "Retrouvez les résultats en direct sur internet à l'adresse: score.trapta.eu"

Controller::Controller(QObject *parent) : QObject(parent),
    _positionChecked(true),
    _progressChecked(true),
    _trendChecked(true),
    _clubChecked(false),
    _busy(false),
    _connected(false),
    _fontRatio(90),
    _speed(700),
    _marquee(MARQUEE_DEFAULT),
    _displayMarquee(true)

{
    QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);
    _positionChecked = _settings.value(SETTINGS_POSITION, true).toBool();
    _progressChecked = _settings.value(SETTINGS_PROGRESS, true).toBool();
    _trendChecked = _settings.value(SETTINGS_TREND, true).toBool();
    _clubChecked = _settings.value(SETTINGS_CLUB, false).toBool();
    _fontRatio = _settings.value(SETTINGS_FONTRATIO, 90).toInt();
    _speed = _settings.value(SETTINGS_SPEED, 700).toInt();
    _marquee = _settings.value(SETTINGS_MARQUEE, MARQUEE_DEFAULT).toString();
    _displayMarquee = _settings.value(SETTINGS_DISPLAYMARQUEE, true).toBool();
    _connectionTimer.setSingleShot(true);
    connect(&_connectionTimer, SIGNAL(timeout()), SLOT(checkConnectionStatus()));
    checkConnectionStatus();

}

void Controller::setPositionChecked(bool checked) {
    if (checked!=_positionChecked) {
        _positionChecked = checked;
        _settings.setValue(SETTINGS_POSITION, _positionChecked);
        emit positionCheckedChanged(checked);
    }
}

void Controller::setProgressChecked(bool checked) {
    if (checked!=_progressChecked) {
        _progressChecked = checked;
        _settings.setValue(SETTINGS_PROGRESS, _progressChecked);
        emit progressCheckedChanged(checked);
    }
}

void Controller::setTrendChecked(bool checked) {
    if (checked!=_trendChecked) {
        _trendChecked = checked;
        _settings.setValue(SETTINGS_TREND, _trendChecked);
        emit trendCheckedChanged(checked);
    }
}

void Controller::setClubChecked(bool checked) {
    if (checked!=_clubChecked) {
        _clubChecked = checked;
        _settings.setValue(SETTINGS_CLUB, _clubChecked);
        emit clubCheckedChanged(checked);
    }
}

void Controller::connected() {
    qDebug() << "Connected to TRAPTA";
    _connected = true;
    if (_connectionTimer.isActive()) _connectionTimer.stop();
    checkConnectionStatus();
}

void Controller::disconnected(QString msg) {
    qDebug() << "Disconnected from TRAPTA";
    _connected = false;
    if (_connectionTimer.isActive()) _connectionTimer.stop();
    checkConnectionStatus();

}

void Controller::quit() {
    emit needToQuit();
}

void Controller::setFontRatio(int fontRatio) {
    if (_fontRatio!=fontRatio) {
        _fontRatio = fontRatio;
        _settings.setValue(SETTINGS_FONTRATIO, _fontRatio);
        emit fontRatioChanged(_fontRatio);
    }
}

void Controller::setSpeed(int speed) {
    if (_speed!=speed) {
        _speed = speed;
        _settings.setValue(SETTINGS_SPEED, _speed);
        emit speedChanged(speed);
    }
}


void Controller::checkConnectionStatus() {
    if (!_connected) {
        QStringList ipAddressList = Connectivity::getIPAddressList();
        if (ipAddressList.count()<1) {  // NO IP ADDRESS
            _message = "Cet appareil n'est connecté à aucun réseau.\nVeuillez le connecter.";
            _status = QString("%0 | Aucun réseau détecté").arg(VERSION);
            _busy = false;
            emit messageChanged(_message);
            emit statusChanged(_status);
            emit busyChanged(_busy);
        }
        else {  // CONNECTED TO NETWORK BUT NOT TO TRAPTA
            QString ipList = ipAddressList.join(',');
            _message = QString("Connecté au réseau\nIP: %0\nEn attente de TRAPTA...").arg(ipList);
            _status = QString("%0 | En attente de TRAPTA...").arg(VERSION);
            _busy = true;
            emit messageChanged(_message);
            emit statusChanged(_status);
            emit busyChanged(_busy);
        }
        _connectionTimer.start(CONNECTION_TIMER);
    }
    else {
        _message = QString();
        _status = QString("%0 | Connecté au serveur TRAPTA").arg(VERSION);
        _busy = false;
        emit messageChanged(_message);
        emit statusChanged(_status);
        emit busyChanged(_busy);
    }

}

void Controller::decFontRatio() {
    if (_fontRatio>30) setFontRatio(_fontRatio-5);
}

void Controller::incFontRatio() {
    if (_fontRatio<100) setFontRatio(_fontRatio+5);
}

void Controller::decSpeed() {
    if (_speed>100) setSpeed(_speed-10);
}

void Controller::incSpeed() {
    if (_speed<2000) setSpeed(_speed+10);
}


void Controller::setMarquee(QString marquee) {
    if (_marquee == marquee) return;
    _marquee = marquee;
    _settings.setValue(SETTINGS_MARQUEE, _marquee);
    emit marqueeChanged(marquee);
}

void Controller::setDisplayMarquee(bool displayMarquee) {
    if (_displayMarquee == displayMarquee) return;
    _displayMarquee = displayMarquee;
    _settings.setValue(SETTINGS_DISPLAYMARQUEE, _displayMarquee);
    emit displayMarqueeChanged(displayMarquee);
}
