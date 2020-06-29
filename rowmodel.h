#ifndef ROWMODEL_H
#define ROWMODEL_H

#include <QObject>
#include <QHash>
#include <QVariant>

#define ROLE_ROWTYPE "rowType"
#define ROLE_NAME "name"
#define ROLE_CLUB "club"
#define ROLE_RANK "rank"
#define ROLE_POSITION "position"
#define ROLE_VOLLEY "volley"
#define ROLE_SCORE "score"
#define ROLE_OVERALLSCORE "overallScore"
#define ROLE_TREND "trend"
#define ROLE_SHIFT "shift"
#define ROLE_CURRENTROUND "currentRound"
#define ROLE_LOCATION "location"
#define ROLE_SPAN "span"
#define ROLE_CATEG "categ"
#define ROLE_TRISPOT "trispot"
#define ROLE_WINNER "winner"
#define ROLE_MATCHVOLLEY1 "matchVolley1"
#define ROLE_MATCHVOLLEY2 "matchVolley2"
#define ROLE_MATCHVOLLEY3 "matchVolley3"
#define ROLE_MATCHVOLLEY4 "matchVolley4"
#define ROLE_MATCHVOLLEY5 "matchVolley5"
#define ROLE_MATCHMARKER1 "matchMarker1"
#define ROLE_MATCHMARKER2 "matchMarker2"
#define ROLE_MATCHMARKER3 "matchMarker3"
#define ROLE_MATCHMARKER4 "matchMarker4"
#define ROLE_MATCHMARKER5 "matchMarker5"

class RowModel {

public:

    enum {
        typeRole = Qt::UserRole,
        nameRole,
        clubRole,
        rankRole,
        positionRole,
        volleyRole,
        scoreRole,
        overallScoreRole,
        trendRole,
        shiftRole,
        currentRoundRole,
        spanRole,
        locationRole,
        categRole,
        trispotRole,
        winnerRole,
        matchVolley1Role,
        matchVolley2Role,
        matchVolley3Role,
        matchVolley4Role,
        matchVolley5Role,
        matchMarker1Role,
        matchMarker2Role,
        matchMarker3Role,
        matchMarker4Role,
        matchMarker5Role
    };

    static QHash<int, QByteArray> roleNames();

    explicit RowModel();
    RowModel(const RowModel &copy);
    RowModel& operator = (const RowModel& copy);

    QVariant data(int role) const;
    QString rowType() const;
    QHash<int, QVariant> params() const;

protected:

    QString _rowType;
    QHash<int, QVariant> _params;

private:

    static QHash<int, QByteArray> _roleNames;
    static QHash<int, QByteArray> initRoles();

};

#endif // ROWMODEL_H
