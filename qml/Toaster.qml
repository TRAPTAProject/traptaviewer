import QtQuick 2.0

Rectangle {

    id: toasterRoot
    visible: false

    width: parent.width
    height: toasterText.height+20
    anchors.bottom: parent.verticalCenter
    color: "white"

    Text {
        id: toasterText
        color: "black"
        width: parent.width
        font.pixelSize: 30
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Timer {
        id: toasterTimer
        interval: 200;
        onTriggered: opacityAnim.start()
    }

    NumberAnimation {
        id: opacityAnim
        target: toasterRoot
        duration: 200
        property: "opacity"
        from: 1
        to: 0
        easing.type: Easing.Linear
        onStopped: {
            toasterRoot.visible = false
            toasterRoot.opacity = 1
        }
    }

    function toast(text) {
        opacityAnim.stop();
        toasterText.text = text
        toasterRoot.visible = true
        toasterTimer.start()
    }

}

