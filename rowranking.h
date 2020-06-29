#ifndef ROWRANKING_H
#define ROWRANKING_H

#include "rowmodel.h"

class RowRanking : public RowModel
{
public:
    RowRanking(const QString& rank,
                  const QString& name,
                  const QString& club,
                  int volley,
                  int score,
                  int overallScore,
                  int shift,
                  int trend,
                  const QString& position,
                  bool currentRound, const QString &categ);


};

#endif // ROWRANKING_H
