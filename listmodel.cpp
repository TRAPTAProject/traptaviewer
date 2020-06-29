#include "listmodel.h"
#include <QFile>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonDocument>
#include "rowmodel.h"
#include "rowcateg.h"
#include "rowranking.h"
#include "rowcut.h"
#include "rowadvert.h"
#include "rowteam.h"
#include "rowposition.h"
#include "rowmatch.h"
#include "rowtitle.h"
#include <QDebug>
#include <QQmlEngine>
#include <QUrl>
#include <QFile>

#define SETTINGS_ROWHEIGHT "rowHeight"
#define SETTINGS_ADVERTLINECOUNT "advertLineCount"
#define SETTINGS_DISPLAYADVERT "displayAdvert"
#define SETTINGS_ADVERTFILE "advertFile"


ListModel::ListModel(QObject *parent) : QAbstractListModel(parent),
    _scrollAreaHeight(9999),
    _rowHeight(30),
    _advertLineCount(5),
    _scroll(true),
    _displayAdvert(true)

{
    QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);
    displayDemoContent(":/json/democontent.json");
    _rowHeight = _settings.value(SETTINGS_ROWHEIGHT, 30).toInt();
    _advertLineCount = _settings.value(SETTINGS_ADVERTLINECOUNT, 5).toInt();
    _displayAdvert = _settings.value(SETTINGS_DISPLAYADVERT, false).toBool();
    _advertFile = _settings.value(SETTINGS_ADVERTFILE).toString();
    updateAdBanner();

}


int ListModel::rowCount(const QModelIndex &parent) const {
    // double the row count if you need to scroll
    int count = _rowList.count()+_advertList.count();
    if (_scroll) return count*2;
    return count;

}

QVariant ListModel::rowData(int rowIndex, int role) const {
    if (rowIndex<0) return QVariant();
    if (rowIndex<_rowList.count()) return _rowList.at(rowIndex).data(role);
    if (!_advertList.isEmpty() && rowIndex<_rowList.count()+_advertList.count())
        return _advertList.at(rowIndex-_rowList.count()).data(role);
    rowIndex = rowIndex - _rowList.count() -_advertList.count();
    if (rowIndex<_rowList.count()) return _rowList.at(rowIndex).data(role);
    return QVariant();
}

QVariant ListModel::data(const QModelIndex &index, int role) const {
    int rowIndex = index.row();
    return rowData(rowIndex, role);
}

QHash<int, QByteArray> ListModel::roleNames() const {
    return RowModel::roleNames();
}


void ListModel::setAdvertLineCount(int advertLineCount) {
    if (_advertLineCount!=advertLineCount) {
        _advertLineCount = advertLineCount;
        _settings.setValue(SETTINGS_ADVERTLINECOUNT, _advertLineCount);
        updateAdBanner();
        emit advertLineCountChanged(_advertLineCount);
    }
}


void ListModel::decAdvertLineCount() {
    if (_advertLineCount>5) setAdvertLineCount(_advertLineCount-2);
}

void ListModel::incAdvertLineCount() {
    if (_advertLineCount<31) setAdvertLineCount(_advertLineCount+2);
}

void ListModel::setAdvertFile(const QString &advertFile) {
    qDebug() << "Setting advertFile to "<< advertFile;
    _advertFile = advertFile;
    _settings.setValue(SETTINGS_ADVERTFILE, _advertFile);
    emit advertFileChanged(_advertFile);
    updateAdBanner();
}

void ListModel::setDisplayAdvert(bool display) {
    _displayAdvert = display;
    _settings.setValue(SETTINGS_DISPLAYADVERT, _displayAdvert);
    updateAdBanner();
    emit displayAdvertChanged(display);
}


void ListModel::updateAdBanner() {

    beginResetModel();
    _advertList.clear();
    if (_displayAdvert && _advertLineCount>0) {
        if (_advertLineCount%2==0) _advertLineCount++;
        _advertList.append(RowModel());
        for (int i=0; i<_advertLineCount/2; i++) _advertList.append(RowModel());
        _advertList.append(RowAdvert(_advertLineCount, _advertFile));
        for (int i=0; i<_advertLineCount/2; i++) _advertList.append(RowModel());

    }
    endResetModel();
}

bool ListModel::displayAdvert() {
    return _displayAdvert;

}

void ListModel::setCurrentRowIndex(int index) {
    QString data = rowData(index+1, RowModel::typeRole).toString();
    if (data=="categ") {
        _subtitle = rowData(index+1, RowModel::nameRole).toString();
        emit subtitleChanged(_subtitle);
    }
    if (data=="blank") {
        _subtitle = "";
        emit subtitleChanged("");
    }

}


void ListModel::processJsonDocument(const QJsonDocument& jsonDoc) {
    QJsonObject rootObject = jsonDoc.object();
    if (rootObject.isEmpty()) {
        qDebug() << "Root object is empty";
        return;
    }
    QList<RowModel> rowList;
    // get data type
    _displayType = rootObject.value("dataType").toString("");
    if (_displayType=="position") {
        _title = rootObject.value("title").toString("DEPART ?");
        rowList = parsePosition(rootObject.value("archerList").toArray());
    }
    else if (_displayType=="ranking") {
        int volleyIndex = (int)rootObject.value("volleyIndex").toInt(-1);
        _title = "";
        if (volleyIndex>-1) _title = QString("Volée %0").arg(volleyIndex+1);
        else _title = "Écran de réglage";
        rowList.append(parseRanking(rootObject.value("ranking").toArray()));
        rowList.append(parseTeam(rootObject.value("team").toObject()));

    }
    else if (_displayType=="matches") {
        _title = rootObject.value("title").toString("ROUND ?");
        rowList.append(parseMatch(rootObject.value("targetList").toArray()));
    }
    else {
        qDebug() << "unknown document type: " << _displayType;
        return;
    }

    // set new model
    beginResetModel();
    _rowList = rowList;
    endResetModel();
    emit titleChanged(_title);
    checkScroll();
}


QList<RowModel> ListModel::parseRanking(const QJsonArray &jsonCategArray) {
    QList<RowModel> rowList;
    for (int categIndex=0; categIndex<jsonCategArray.size(); categIndex++) {
        QJsonObject rootObj = jsonCategArray.at(categIndex).toObject();
        bool runningCateg = rootObj.value("runningCateg").toBool();
        if (!runningCateg) continue; // if this categ does not contain any archer currently drawing, skip
        QJsonArray archerList = rootObj.value("archerList").toArray();
        if (archerList.count()<1) continue;
        QString categTitle = rootObj.value("categName").toString();
        int cut = rootObj.value("cut").toInt(0);
        rowList.append(RowModel());
        rowList.append(RowCateg(categTitle));

        for (int index=0; index<archerList.size(); index++) {

            QJsonObject shell = archerList.at(index).toObject();
            QString rank = shell.value("rank").toString("?");
            bool currentStart = shell.value("currentRun").toBool(true);
            QJsonObject archer = shell.value("archer").toObject();
            QString name = archer.value("name").toString("?");
            QString club = archer.value("club").toString("?");
            QString position = archer.value("position").toString("?");
            int volleyScore = (int)(archer.value("volleyScore").toDouble(-1));
            int score0 = archer.value("score0").toInt(-1);
            int total = archer.value("total").toInt(-1);
            int shift = archer.value("shift").toInt(0);
            int trend = archer.value("trend").toInt(0);

            RowRanking row(rank, name, club, volleyScore, score0, total, shift, trend, position, currentStart, categTitle);
            rowList.append(row);
            if (cut>0 && index==cut-1) {
                rowList.append(RowCut());
            }

        }
    }
    return rowList;
}

QList<RowModel> ListModel::parseTeam(const QJsonObject &jsonObject) {
    QList<RowModel> rowList;

    QStringList categTeamList = jsonObject.keys();
    foreach (QString categ, categTeamList) {
        QJsonArray jsonArray = jsonObject.value(categ).toArray();
        if (jsonArray.count()<1) continue;
        rowList.append(RowModel());
        rowList.append(RowCateg("- "+categ));

        for (int index=0; index<jsonArray.size(); index++) {
            QJsonObject team = jsonArray.at(index).toObject();
            int rank = team.value("rank").toInt(0);
            QString name = team.value("name").toString("?");
            int score = team.value("score").toInt(-1);
            rowList.append(RowTeam(rank, name, score));

        }
    }
    return rowList;
}

QList<RowModel> ListModel::parsePosition(const QJsonArray &jsonArray) {
    QList<RowModel> rowList;
    for (int index=0; index<jsonArray.size(); index++) {
        QJsonObject row = jsonArray.at(index).toObject();
        QString name = row.value("name").toString("?");
        QString club = row.value("club").toString("?");
        QString position = row.value("position").toString("?");
        QString categ = row.value("categ").toString("?");
        bool trispot = row.value("trispot").toBool(false);
        rowList.append(RowPosition(name, club, categ, position, trispot));
    }
    return rowList;
}

QList<RowModel> ListModel::parseMatch(const QJsonArray& jsonArray) {
    QList<RowModel> rowList;
    for (int index=0; index<jsonArray.size(); index++) {
        QJsonObject match = jsonArray.at(index).toObject();
        int targetId = match.value("target").toInt(0);
        QString categ = match.value("categ").toString();
        QJsonArray markerListInt = match.value("markerList").toArray();
        QList<bool> markerList[2];
        for (int i=0; i<markerListInt.count(); i++) {
            int value = markerListInt.at(i).toInt(-1);
            if (value==0) {
                markerList[0] << true;
                markerList[1] << false;
            }
            else if (value==1) {
                markerList[0] << false;
                markerList[1] << true;
            }
            else {
                markerList[0] << false;
                markerList[1] << false;
            }
        }
        int winner = match.value("winner").toInt(-1);
        bool tieBreak = match.value("tieBreak").toBool(false);
        rowList.append(RowModel());
        rowList.append(RowTitle(QString("Cible %0 - %1").arg(targetId).arg(categ)));
        QJsonArray archerList = match.value("archerList").toArray();
        if (archerList.count()!=2) continue;

        for (int i=0; i<2; i++) {
            QJsonObject archer = archerList.at(i).toObject();
            QString name = archer.value("name").toString("BYE");
            int initialRank = archer.value("initialRank").toInt(0);
            int score = archer.value("score").toInt(0);
            if (tieBreak && winner==i && markerListInt.count()>1) score++;  // +1 if tiebreak
            QJsonArray jsonVolleyList = archer.value("volleyList").toArray();
            QList<int> volleyList;
            for (int volleyIndex=0; volleyIndex<jsonVolleyList.size(); volleyIndex++) {
                int value = jsonVolleyList.at(volleyIndex).toInt(-1);
                if (value==-1) break;
                volleyList << value;
            }
            rowList.append(RowMatch(initialRank, name, volleyList, markerList[i], score, winner==i));
        }

    }
    return rowList;
}

void ListModel::displayDemoContent(const QString& filename) {

    QFile file(filename);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open file";
        return;
    }
    QByteArray stream = file.readAll();
    QJsonParseError jsonError;
    QJsonDocument jsonDoc = QJsonDocument::fromJson(stream, &jsonError);
    if (jsonError.error!=QJsonParseError::NoError) {
        qWarning() << "Error while parsing json: " << jsonError.errorString();
        return;
    }
    if (jsonDoc.isNull()) {
        qWarning() << "Json doc is null after parsing. Abort.";
        return;
    }
    processJsonDocument(jsonDoc);
}


void ListModel::setScrollAreaHeight(int scrollAreaHeight) {

    qDebug() << "setScrollAreaHeight=" << scrollAreaHeight;
    beginResetModel();
    _scrollAreaHeight = scrollAreaHeight;
    endResetModel();
    checkScroll();

}

void ListModel::decRowHeight() {
    if (_rowHeight>15) setRowHeight(_rowHeight-1);
}

void ListModel::incRowHeight() {
    if (_rowHeight<150) setRowHeight(_rowHeight+1);
}

void ListModel::setRowHeight(int rowHeight) {

    if (_rowHeight == rowHeight) return;
    _rowHeight = rowHeight;
    _settings.setValue(SETTINGS_ROWHEIGHT, rowHeight);
    emit rowHeightChanged(_rowHeight);
    checkScroll();

}

void ListModel::checkScroll() {

    int count = _rowList.count()+_advertList.count();
    qDebug() << "# rows:" << count << " rowHeight:" << _rowHeight << " areaHeight:" << _scrollAreaHeight << " surface:" << count*_rowHeight;
    if (count*_rowHeight>_scrollAreaHeight && !_scroll) {
        qDebug() << "It is NOT scrolling => go scroll !";
        beginResetModel();
        _scroll = true;
        endResetModel();
        emit scrollChanged(_scroll);
    }
    if (count*_rowHeight<=_scrollAreaHeight && _scroll) {
        qDebug() << "It is scrolling => stop scroll !";
        beginResetModel();
        _scroll = false;
        endResetModel();
        emit scrollChanged(_scroll);

    }

}
