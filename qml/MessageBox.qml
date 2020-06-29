import QtQuick 2.0

Rectangle {
    id: messageBox

    property alias text: messageText.text

    color: "white"
    width: messageText.width + 20
    height: messageText.height + 20
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.verticalCenter
    visible: messageText.text!==""

    Text {
        id: messageText
        color: "black"
        font.pixelSize: 20
        width: 300
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment:  Text.AlignVCenter
        wrapMode: Text.WordWrap
    }
}
