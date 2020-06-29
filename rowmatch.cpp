#include <QVariant>
#include "rowmatch.h"

RowMatch::RowMatch(int initialRank, const QString &name, QList<int> volleyList, QList<bool> markerList, int score, bool winner):
    RowModel()
{
    _rowType = "match";
    _params.insert(rankRole, QVariant(initialRank));
    _params.insert(nameRole, QVariant(name));

    if (volleyList.count()>0)
        _params.insert(matchVolley1Role, QVariant(volleyList[0]));
    else _params.insert(matchVolley1Role, QVariant(-1));

    if (volleyList.count()>1)
        _params.insert(matchVolley2Role, QVariant(volleyList[1]));
    else _params.insert(matchVolley2Role, QVariant(-1));

    if (volleyList.count()>2)
        _params.insert(matchVolley3Role, QVariant(volleyList[2]));
    else _params.insert(matchVolley3Role, QVariant(-1));

    if (volleyList.count()>3)
        _params.insert(matchVolley4Role, QVariant(volleyList[3]));
    else _params.insert(matchVolley4Role, QVariant(-1));

    if (volleyList.count()>4)
        _params.insert(matchVolley5Role, QVariant(volleyList[4]));
    else _params.insert(matchVolley5Role, QVariant(-1));

    if (markerList.count()>0)
        _params.insert(matchMarker1Role, QVariant(markerList[0]));
    else _params.insert(matchMarker1Role, QVariant(-1));

    if (markerList.count()>1)
        _params.insert(matchMarker2Role, QVariant(markerList[1]));
    else _params.insert(matchMarker2Role, QVariant(-1));

    if (markerList.count()>2)
        _params.insert(matchMarker3Role, QVariant(markerList[2]));
    else _params.insert(matchMarker3Role, QVariant(-1));

    if (markerList.count()>3)
        _params.insert(matchMarker4Role, QVariant(markerList[3]));
    else _params.insert(matchMarker4Role, QVariant(-1));

    if (markerList.count()>4)
        _params.insert(matchMarker5Role, QVariant(markerList[4]));
    else _params.insert(matchMarker5Role, QVariant(-1));

    _params.insert(scoreRole, QVariant(score));
    _params.insert(winnerRole, QVariant(winner));

}
