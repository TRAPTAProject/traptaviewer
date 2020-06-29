import QtQuick 2.4

Item {

    id: tabRoot
    property alias text: tabText.text
    height: tabText.height+20

    signal tabClicked()

    Text {
        id: tabText
        anchors.centerIn: parent
        font.pixelSize: 20
        text: "Default"
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            tabClicked()
        }

    }

}

