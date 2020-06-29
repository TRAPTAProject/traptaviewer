#ifndef ROWPOSITION_H
#define ROWPOSITION_H

#include "rowmodel.h"

class RowPosition : public RowModel
{
public:
    RowPosition(const QString& name,
                  const QString& club,
                  const QString& categ,
                  const QString& position,
                  bool trispot);


};

#endif // ROWPOSITION_H
