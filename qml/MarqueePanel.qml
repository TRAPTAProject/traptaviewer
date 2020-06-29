import QtQuick 2.4

FocusScope {
    id: marquee
    height: 300

    Rectangle {
        anchors.fill: parent
        color: "darkslategray"
    }
    Item {
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.leftMargin: 40
        anchors.rightMargin: 40

        TCheckbox {
            id: marqueeCheckbox
            focus: true
            anchors.top: parent.top
            anchors.left: parent.left
            text: "Faire défiler ce message :"
            KeyNavigation.down: textInput
            checked: controller.displayMarquee
            onCheckboxClicked: controller.setDisplayMarquee(!marqueeCheckbox.checked)
        }

        Rectangle {
            height: textInput.height+20
            color: textInput.activeFocus ? "steelblue": "darkslategray"
            anchors.top: marqueeCheckbox.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 20
            radius: 5
            border.width: 2
            border.color: "white"

            TextInput {
                id: textInput
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.verticalCenter: parent.verticalCenter
                clip: true
                font.pixelSize: 20
                color: "white"
                text: controller.marquee
                KeyNavigation.up: marqueeCheckbox

                onTextChanged: {
                    controller.setMarquee(textInput.text)
                }

                Keys.onPressed: {

                    if (event.key === Qt.Key_Shift) {
                        event.accepted = true
                        return
                    }
                    event.accepted = false

                }

            }
        }
    }


}
