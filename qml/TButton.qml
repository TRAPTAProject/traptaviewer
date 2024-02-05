import QtQuick

Rectangle {

    id: buttonRoot
    property alias text: buttonText.text
    property alias horizontalAlignment: buttonText.horizontalAlignment
    property string sourceNormal
    property string sourcePressed


    signal buttonClicked()

    color: activeFocus ? "steelblue": "darkslategray"
    width: buttonText.width+30
    height: buttonText.height+20
    radius: 5
    border.width: 2
    border.color: "white"

    Image {
        id: buttonImage
        source: sourceNormal
        anchors.centerIn: parent
        height: parent.height/2
        fillMode: Image.PreserveAspectFit

    }

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 20
        color: "white"
    }

    Keys.onReturnPressed: {
        buttonPressed();
    }

    Keys.onReleased: {
        buttonReleased();
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            buttonRoot.focus = true
            buttonPressed();

        }
        onReleased: {
            buttonReleased();

        }
    }

    onActiveFocusChanged: {
        buttonRoot.color = buttonRoot.activeFocus ? "steelblue": "darkslategray"
    }

    function buttonPressed() {
        buttonRoot.color = "white"
        buttonText.color = "black"
        buttonImage.source = sourcePressed
        buttonClicked()
    }

    function buttonReleased() {
        buttonRoot.color = buttonRoot.activeFocus ? "steelblue": "darkslategray"
        buttonText.color = "white"
        buttonImage.source = sourceNormal
    }

}

