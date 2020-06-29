#include <QVariant>
#include "rowposition.h"
#include <QDebug>

RowPosition::RowPosition(const QString &name,
                         const QString& club,
                         const QString &categ,
                         const QString &position,
                         bool trispot):
    RowModel()
{
    _rowType = "position";
    _params.insert(nameRole, QVariant(name));
    _params.insert(categRole, QVariant(categ));
    _params.insert(clubRole, QVariant(club));
    _params.insert(positionRole, QVariant(position));
    _params.insert(trispotRole, QVariant(trispot));

}

