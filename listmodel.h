#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include "rowmodel.h"
#include <QSettings>

class ListModel : public QAbstractListModel
{

    Q_OBJECT

    Q_PROPERTY(int rowHeight READ rowHeight NOTIFY rowHeightChanged)
    Q_PROPERTY(bool scroll READ scroll NOTIFY scrollChanged) // true if list is to be scrolled
    Q_PROPERTY(QString title READ title NOTIFY titleChanged)
    Q_PROPERTY(QString subtitle READ subtitle NOTIFY subtitleChanged)

    Q_PROPERTY(int advertLineCount READ advertLineCount NOTIFY advertLineCountChanged)
    Q_PROPERTY(bool displayAdvert READ displayAdvert NOTIFY displayAdvertChanged)
    Q_PROPERTY(QString advertFile READ advertFile NOTIFY advertFileChanged)


public:
    explicit ListModel(QObject *parent = 0);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    void displayDemoContent(const QString &filename);
    int rowHeight() const { return _rowHeight; }

    bool scroll() const { return _scroll; }
    QString title() const { return _title; }
    QString subtitle() const { return _subtitle; }

    int advertLineCount() const { return _advertLineCount; }
    bool displayAdvert(); const
    QString advertFile() const { return _advertFile; }

signals:

    void rowHeightChanged(int rowHeight);
    void scrollChanged(bool scroll);
    void titleChanged(QString title);
    void subtitleChanged(QString subtitle);

    void advertLineCountChanged(int advertLineCount);
    void displayAdvertChanged(bool display);
    void advertFileChanged(QString advertFile);

public slots:

    void processJsonDocument(const QJsonDocument& jsonDoc);
    void setScrollAreaHeight(int scrollAreaHeight);

    void decRowHeight();
    void incRowHeight();    
    void setCurrentRowIndex(int index);

    void decAdvertLineCount();
    void incAdvertLineCount();

    void setAdvertFile(const QString& advertFile);
    void setDisplayAdvert(bool display);

private:

    QSettings _settings;

    QList<RowModel> _rowList;
    QList<RowModel> _advertList;
    QString _displayType;
    QString _title;
    int _rowHeight;
    int _scrollAreaHeight;

    QList<RowModel> parseRanking(const QJsonArray& jsonArray);
    QList<RowModel> parseTeam(const QJsonObject& jsonObject);
    QList<RowModel> parsePosition(const QJsonArray& jsonArray);
    QList<RowModel> parseMatch(const QJsonArray &jsonArray);

    QVariant rowData(int rowIndex, int role) const;
    void setAdvertLineCount(int advertLineCount);

    void setRowHeight(int rowHeight);
    void checkScroll(); // check if scrolling is needed

    bool _scroll;
    bool _displayAdvert;
    QString _subtitle;
    int _advertLineCount;
    QString _advertFile;

    void updateAdBanner();
};

#endif // LISTMODEL_H
