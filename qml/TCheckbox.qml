import QtQuick

Rectangle {

    id: checkboxRoot
    property alias text: checkboxText.text
    property bool checked: false

    signal checkboxClicked()

    color: activeFocus ? "steelblue": "darkslategray"
    width: checkboxText.width+50
    height: checkboxText.height+20
    radius: 5

    Rectangle {
        id: checkboxRect
        width: 20
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        border.width: 2
        border.color: "white"
        color: "transparent"
    }

    Image {
        id: tick
        visible: checked
        height: parent.height*0.6
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
        source: "qrc:/images/tick.png"

    }

    Text {
        id: checkboxText
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.rightMargin: 10
        font.pixelSize: 20
        text: "Default"
        color: "white"
    }



    Keys.onReturnPressed: {
        checkboxClicked()
    }

    Keys.onSpacePressed: {
        checkboxClicked()
    }


    MouseArea {
        anchors.fill: parent
        onPressed: {
            checkboxClicked()
            checkboxRoot.focus = true
        }

    }

    onActiveFocusChanged: {
        checkboxRoot.color = checkboxRoot.activeFocus ? "steelblue": "darkslategray"
    }


}


