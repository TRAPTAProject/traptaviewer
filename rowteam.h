#ifndef ROWTEAM_H
#define ROWTEAM_H

#include "rowmodel.h"

class RowTeam : public RowModel
{
public:
    RowTeam(int rank, const QString& name, int score);

};

#endif // ROWTEAM_H
