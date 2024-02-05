import QtQuick

Rectangle {

    property alias text: label.text
    property int fontRatio: 80
    color: "white"
    Text {
        id: label
        anchors.left: parent.left
        width: parent.width
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height*fontRatio/100
        color: "black"
    }

}
