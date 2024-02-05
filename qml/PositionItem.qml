import QtQuick

Item {

    property int fontRatio: 90
    property alias visibleClub: idClub.visible

    Item {

        anchors.left: parent.left
        anchors.right: idCateg.left
        height: parent.height

        Text {
            id: idName
            text: name
            elide: Text.ElideRight
            height: parent.height
            anchors.left: parent.left
            anchors.right: idClub.left
            anchors.leftMargin: parent.height*1.4
            font.pixelSize: parent.height*fontRatio/100
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }

        Text {
            id: idClub
            text: " " + club
            elide: Text.ElideRight
            height: parent.height
            width: idClub.visible ? parent.width*0.38 : 0
            anchors.right: parent.right
            leftPadding: parent.height/2
            rightPadding: parent.height/2
            font.pixelSize: parent.height*fontRatio/100
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }

    }

    Text {
        id: idCateg
        text: categ
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: (parent.width*2)/3
        font.pixelSize: parent.height*fontRatio/100
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: "white"
    }

    Row {
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: parent.height*1.4
        spacing: 5

        // position
        Rectangle {
            id: idPosition
            visible: true
            height: parent.height*0.9
            width: parent.height*1.8
            color: "cyan"
            radius: parent.height*0.3

            Text {
                height: parent.height
                width: parent.width
                text: position
                font.pixelSize: parent.height*fontRatio/100
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "black"
            }

        }

        Image {
            id: idTrispot
            visible: true
            height: parent.height*0.9
            width: parent.height*0.9
            fillMode: Image.PreserveAspectFit
            source: trispot?"qrc:/images/trispot.png":"qrc:/images/singlespot.png"
        }
    }
}
