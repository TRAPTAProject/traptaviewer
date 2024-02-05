import QtQuick

Rectangle {

    property bool marker: false
    property alias text: matchVolleyText.text
    property alias fontPixelSize: matchVolleyText.font.pixelSize

    height: parent.height
    width: parent.height*2
    color: marker?"white":"black"
    radius: 20.0

    Text {
        id: matchVolleyText
        anchors.fill: parent
        text: textValue
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: marker?"#010101":"#FEFEFE"

    }
}

