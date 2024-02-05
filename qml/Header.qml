import QtQuick

Rectangle {

    property alias titleText: title.text
    property alias marqueeText: titleMarquee.marqueeText
    property int fontRatio: 90
    property alias marqueeVisible: titleMarquee.visible

    id: header
    color: "white"
    height: 30
    width: parent.width
    anchors.top: parent.top

    Text {
        id: title
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        height: parent.height
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: (parent.height*fontRatio*0.8)/100
        color: "black"
    }

    Marquee {
        id: titleMarquee
        anchors.left: title.right
        anchors.top: parent.top
        anchors.leftMargin: 50
        anchors.right: parent.right
        height: parent.height
        speed: 150
        fontRatio: header.fontRatio*0.65
    }

}

