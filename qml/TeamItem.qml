import QtQuick 2.0

Item {

    property int fontRatio: 90

    // rank
    Rectangle {
        id: idRank
        anchors.left: parent.left
        height: parent.height
        width: parent.height*1.4
        color: "white"

        Text {
            height: parent.height
            width: parent.width
            text: rank
            font.pixelSize: parent.height*fontRatio/100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
        }

    }

    Text {
        id: idName
        anchors.right: idScore.left
        anchors.left: idRank.right
        height: parent.height
        elide: Text.ElideRight
        text: " "+name
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height*fontRatio/100
        color: "white"
    }


    Text {
        id: idScore
        visible: score>-1
        anchors.right: parent.right
        width: parent.height*2.3
        height: parent.height
        text: score
        font.pixelSize: parent.height*fontRatio/100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "white"
    }

}
