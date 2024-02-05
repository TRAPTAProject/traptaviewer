import QtQuick

Rectangle {

    property int fontRatio: 90
    color: "yellow"
    Text {

        height: parent.height
        width: parent.width
        text: "Limite qualification phases finales"
        font.pixelSize: parent.height*fontRatio/100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "black"

    }
}
