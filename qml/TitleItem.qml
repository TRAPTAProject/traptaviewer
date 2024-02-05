import QtQuick

Rectangle {

    property int fontRatio: 90
    color: "white"
    Rectangle {
        id: idSpan
        width: parent.height*1.4
    }

    Text {
        id: idTitle
        text: name
        height: parent.height
        anchors.left: idSpan.right
        anchors.right: parent.right
        font.pixelSize: parent.height*fontRatio/100
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: "black"
    }
}
