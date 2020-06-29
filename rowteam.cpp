#include "rowteam.h"

RowTeam::RowTeam(int rank, const QString &name, int score) : RowModel()
{
    _rowType = "team";
    _params.insert(rankRole, QVariant(rank));
    _params.insert(nameRole, QVariant(name));
    _params.insert(scoreRole, QVariant(score));

}

