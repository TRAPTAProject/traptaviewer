import QtQuick

Rectangle {
    color: "grey"
    Image {
        anchors.centerIn: parent
        sourceSize.height: parent.height*span
        source: location==""?"qrc:/images/adbanner.png":location
    }

}
