#include <QHash>
#include <QVariant>
#include "rowcateg.h"


RowCateg::RowCateg(const QString &name) : RowModel() {

    _rowType = "categ";
    _params.insert(nameRole, QVariant(name));

}

