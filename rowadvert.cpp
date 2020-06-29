#include "rowadvert.h"


RowAdvert::RowAdvert(int height, const QString &location): RowModel() {

     _rowType = "advert";
    _params.insert(spanRole, QVariant(height));
    _params.insert(locationRole, QVariant(location));

}

