import QtQuick
import QtQuick.Controls

FocusScope {

    id: appView
    anchors.fill: parent

    focus: true

    ScrollingList {

        id: scrollingList
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        listRowHeight: listModel.rowHeight
        scroll: listModel.scroll
        listFontRatio: controller.fontRatio
        duration: controller.speed
        positionVisible: controller.positionChecked
        trendVisible: controller.trendChecked
        shiftVisible: controller.progressChecked
        clubVisible: controller.clubChecked

        model: listModel

        onRowIndexChanged: {
            listModel.setCurrentRowIndex(rowIndex);
        }
        onHeightChanged: {
            listModel.setScrollAreaHeight(scrollingList.height);
        }

        Component.onCompleted: {
            listModel.setScrollAreaHeight(scrollingList.height);
        }

    }

    Header {
        id: header
        height: listModel.rowHeight
        titleText: listModel.title
        marqueeText: controller.marquee
        marqueeVisible: controller.displayMarquee
        fontRatio: controller.fontRatio
    }


    Subtitle {
        id: subtitleHeader
        visible: subtitleHeader.text!==""
        opacity: 0.8
        anchors.top: header.bottom
        width: parent.width
        height: listModel.rowHeight
        fontRatio: controller.fontRatio
        text: listModel.subtitle

    }

    Toaster {
        id: toaster

    }

    BusyIndicator {
        id:hourglass
        visible: controller.busy
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.margins: 25
        running: hourglass.visible
    }


    MessageBox {
        id: messageBox
        text: controller.message
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (configPanel.visible) {
                configPanel.visible = false
                configPanel.focus = false
            }
            else {
                configPanel.visible = true
                configPanel.focus = true

            }
        }
    }

    ConfigPanel {
        id: configPanel
        height: 300
        width: 800
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        visible: false
    }

    Rectangle {
        id: escCheck
        visible: false

        width: parent.width
        height: escText.height+20
        anchors.bottom: parent.verticalCenter
        color: "red"

        Text {
            id: escText
            color: "yellow"
            width: parent.width
            font.pixelSize: 30
            anchors.centerIn: parent
            text: "Appuyez sur Echap (Esc) pour quitter"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }

    property int scrollSpeed: controller.speed

    onScrollSpeedChanged: toaster.toast("Vitesse: "+Math.round(100000/scrollSpeed))

    Keys.onPressed: (event) => {

        if (escCheck.visible && event.key!==Qt.Key_Escape) {
            escCheck.visible = false
            event.accepted = true
            return
        }

        switch (event.key) {

            case Qt.Key_Up:
                listModel.decRowHeight();
                break;

            case Qt.Key_Down:
                listModel.incRowHeight();
                break;

            case Qt.Key_Left:
                controller.decFontRatio();
                break;

            case Qt.Key_Right:
                controller.incFontRatio();
                break;

            case Qt.Key_Plus:
                controller.decSpeed()
                break;

            case Qt.Key_Minus:
                controller.incSpeed()
                break;

            case Qt.Key_Escape:
                if (escCheck.visible) controller.quit();
                else escCheck.visible = true;

                break;

            case Qt.Key_P:
                if (rootWindow.visibility == 5) rootWindow.visibility = 2;
                else rootWindow.visibility = 5;
                break;

            default:

                if (configPanel.visible === true) {
                    configPanel.visible = false
                    configPanel.focus = false
                }
                else {
                    configPanel.visible = true
                    configPanel.focus = true

                }
        }

        event.accepted = true

    }

}

