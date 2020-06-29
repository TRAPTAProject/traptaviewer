#include <QHash>
#include <QVariant>

#include "rowtitle.h"


RowTitle::RowTitle(const QString &name) : RowModel() {

    _rowType = "title";
    _params.insert(nameRole, QVariant(name));

}

