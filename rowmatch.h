#ifndef ROWMATCH_H
#define ROWMATCH_H

#include "rowmodel.h"
#include <QList>

class RowMatch : public RowModel
{
public:
    //initialRank, name, volleyList, markerList[i], score, winner==i)
    RowMatch(int initialRank,
                  const QString& name,
                  QList<int> volleyList,
                  QList<bool> markerList,
                  int score,
                  bool winner);


};

#endif // ROWMATCH_H
