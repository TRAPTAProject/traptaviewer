#include "rowmodel.h"
#include <QHash>
#include <QVariant>
#include <QDebug>

QHash<int, QByteArray> RowModel::initRoles() {
    QHash<int, QByteArray> roleNames;
    roleNames.insert(typeRole, ROLE_ROWTYPE);
    roleNames.insert(nameRole, ROLE_NAME);
    roleNames.insert(clubRole, ROLE_CLUB);
    roleNames.insert(rankRole, ROLE_RANK);
    roleNames.insert(positionRole, ROLE_POSITION);
    roleNames.insert(volleyRole, ROLE_VOLLEY);
    roleNames.insert(scoreRole, ROLE_SCORE);
    roleNames.insert(overallScoreRole, ROLE_OVERALLSCORE);
    roleNames.insert(trendRole, ROLE_TREND);
    roleNames.insert(shiftRole, ROLE_SHIFT);
    roleNames.insert(currentRoundRole, ROLE_CURRENTROUND);
    roleNames.insert(locationRole, ROLE_LOCATION);
    roleNames.insert(spanRole, ROLE_SPAN);
    roleNames.insert(categRole, ROLE_CATEG);
    roleNames.insert(trispotRole, ROLE_TRISPOT);
    roleNames.insert(winnerRole, ROLE_WINNER);
    roleNames.insert(matchVolley1Role, ROLE_MATCHVOLLEY1);
    roleNames.insert(matchVolley2Role, ROLE_MATCHVOLLEY2);
    roleNames.insert(matchVolley3Role, ROLE_MATCHVOLLEY3);
    roleNames.insert(matchVolley4Role, ROLE_MATCHVOLLEY4);
    roleNames.insert(matchVolley5Role, ROLE_MATCHVOLLEY5);
    roleNames.insert(matchMarker1Role, ROLE_MATCHMARKER1);
    roleNames.insert(matchMarker2Role, ROLE_MATCHMARKER2);
    roleNames.insert(matchMarker3Role, ROLE_MATCHMARKER3);
    roleNames.insert(matchMarker4Role, ROLE_MATCHMARKER4);
    roleNames.insert(matchMarker5Role, ROLE_MATCHMARKER5);
    return roleNames;
}

QHash<int, QByteArray> RowModel::_roleNames = RowModel::initRoles();

QHash<int, QByteArray> RowModel::roleNames() {
    return _roleNames;
}

RowModel::RowModel() {

    _rowType = "blank";
}

RowModel::RowModel(const RowModel &copy) {
    _rowType = copy.rowType();
    _params = copy.params();
}

RowModel& RowModel::operator = (const RowModel& copy) {
    _rowType = copy.rowType();
    _params = copy.params();
    return *this;
}

QHash<int, QVariant> RowModel::params() const {
    return _params;
}

QString RowModel::rowType() const {
    return _rowType;
}

QVariant RowModel::data(int role) const {
    if (role==typeRole) return QVariant(_rowType);
    return _params.value(role);
}

