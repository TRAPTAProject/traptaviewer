#include <QVariant>
#include "rowranking.h"
#include <QDebug>

RowRanking::RowRanking(const QString& rank,
                       const QString& name,
                       const QString& club,
                       int volley,
                       int score,
                       int overallScore,
                       int shift,
                       int trend,
                       const QString& position,
                       bool currentRound,
                       const QString& categ):
    RowModel()
{
    _rowType = "rank";
    _params.insert(rankRole, QVariant(rank));
    _params.insert(nameRole, QVariant(name));
    _params.insert(clubRole, QVariant(club));
    _params.insert(volleyRole, QVariant(volley));
    _params.insert(scoreRole, QVariant(score));
    _params.insert(overallScoreRole, QVariant(overallScore));
    _params.insert(shiftRole, QVariant(shift));
    _params.insert(trendRole, QVariant(trend));
    _params.insert(positionRole, QVariant(position));
    _params.insert(currentRoundRole, QVariant(currentRound));

}
