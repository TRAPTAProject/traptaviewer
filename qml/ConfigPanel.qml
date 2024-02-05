import QtQuick

FocusScope {

    id: configPanelRoot

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    ListView {
        id: tabSelector
        width: 150
        anchors.bottom: status.top
        anchors.left: parent.left
        anchors.top: parent.top

        model: ["Aide", "Réglage", "Message", "Annonce"]

        delegate: TTab {
            text: modelData
            width: parent.width

            onTabClicked: {
                tabSelector.currentIndex = index
                flickablePanel.setSelectedIndex(index)

            }

        }
        highlight: Rectangle {
            color: "darkslategray"
        }

    }

    FlickablePanel {
        id: flickablePanel
        anchors.left: tabSelector.right
        anchors.top: parent.top

        onSelectedIndex: (index) => tabSelector.currentIndex = index
    }

    Rectangle {
        id: status
        width: parent.width
        height: statusText.height + 20
        anchors.bottom: parent.bottom
        color: "white"

        Text {
            id: statusText
            anchors.centerIn: parent
            text: controller.status
            font.pixelSize: 20
            color: "black"
        }
    }

    Keys.onUpPressed: {}
    Keys.onDownPressed: {}
    Keys.onLeftPressed: {}
    Keys.onRightPressed: {}
    Keys.onEscapePressed: {
        configPanelRoot.focus = false
        configPanelRoot.visible = false
    }


}

