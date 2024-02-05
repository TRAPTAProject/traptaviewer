import QtQuick

FocusScope {
    id: setting
    height: 300

    Rectangle {
        anchors.fill: parent
        color: "darkslategray"
    }

    Column {
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.leftMargin: 40
        spacing: 15

        Row {
            width: parent.width
            spacing: 30
            Text {
                text: "Vitesse de défilement :"
                font.pixelSize: 20
                color: "white"
                width: 240
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
            TButton {
                id: speedMinus
                width: 100
                focus: true
                sourceNormal: "qrc:/images/minus-white.png"
                sourcePressed: "qrc:/images/minus-black.png"
                KeyNavigation.right: speedPlus
                KeyNavigation.left: speedMinus
                KeyNavigation.down: heightMinus
                onButtonClicked: controller.incSpeed()
            }
            Text {
                text: { return Math.round(100000/controller.speed) }
                font.pixelSize: 20
                color: "white"
                width: 30
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TButton {
                id: speedPlus
                sourceNormal: "qrc:/images/plus-white.png"
                sourcePressed: "qrc:/images/plus-black.png"
                width: 100
                KeyNavigation.left: speedMinus
                KeyNavigation.right: speedPlus
                KeyNavigation.down: heightPlus
                onButtonClicked: controller.decSpeed()
            }
        }
        Row {
            width: parent.width
            spacing: 30
            Text {
                text: "Hauteur des lignes :"
                font.pixelSize: 20
                color: "white"
                width: 240
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
            TButton {
                id: heightMinus
                text: "-"
                width: 100
                sourceNormal: "qrc:/images/minus-white.png"
                sourcePressed: "qrc:/images/minus-black.png"
                KeyNavigation.right: heightPlus
                KeyNavigation.left: heightMinus
                KeyNavigation.up: speedMinus
                KeyNavigation.down: fontMinus
                onButtonClicked: listModel.decRowHeight();

            }
            Text {
                text: listModel.rowHeight
                font.pixelSize: 20
                color: "white"
                width: 30
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TButton {
                id: heightPlus
                text: "+"
                width: 100
                sourceNormal: "qrc:/images/plus-white.png"
                sourcePressed: "qrc:/images/plus-black.png"
                KeyNavigation.left: heightMinus
                KeyNavigation.right: heightPlus
                KeyNavigation.up: speedPlus
                KeyNavigation.down: fontPlus
                onButtonClicked: listModel.incRowHeight();

            }
        }
        Row {
            width: parent.width
            spacing: 30
            Text {
                text: "Taille de police :"
                font.pixelSize: 20
                color: "white"
                width: 240
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
            TButton {
                id: fontMinus
                text: "-"
                width: 100
                sourceNormal: "qrc:/images/minus-white.png"
                sourcePressed: "qrc:/images/minus-black.png"
                KeyNavigation.right: fontPlus
                KeyNavigation.left: fontMinus
                KeyNavigation.up: heightMinus
                KeyNavigation.down: trendCheck
                onButtonClicked: controller.decFontRatio();
            }
            Text {
                text: controller.fontRatio+"%"
                font.pixelSize: 20
                color: "white"
                width: 30
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TButton {
                id: fontPlus
                text: "+"
                width: 100
                sourceNormal: "qrc:/images/plus-white.png"
                sourcePressed: "qrc:/images/plus-black.png"
                KeyNavigation.right: fontPlus
                KeyNavigation.left: fontMinus
                KeyNavigation.up: heightPlus
                KeyNavigation.down: positionCheck
                onButtonClicked: controller.incFontRatio();
            }
        }
        Row {
            width: parent.width
            spacing: 40
            TCheckbox {
                id: progressCheck
                text: "Progression"
                KeyNavigation.up: fontMinus
                KeyNavigation.right: trendCheck
                KeyNavigation.left: clubCheck
                checked: controller.progressChecked
                onCheckboxClicked: controller.setProgressChecked(!progressCheck.checked)

            }
            TCheckbox {
                id: trendCheck
                text: "Smileys"
                KeyNavigation.up: fontMinus
                KeyNavigation.right: positionCheck
                KeyNavigation.left: progressCheck
                checked: controller.trendChecked
                onCheckboxClicked: controller.setTrendChecked(!trendCheck.checked)


            }
            TCheckbox {
                id: positionCheck
                text: "Position"
                KeyNavigation.up: fontPlus
                KeyNavigation.right: clubCheck
                KeyNavigation.left: trendCheck
                checked: controller.positionChecked
                onCheckboxClicked: controller.setPositionChecked(!positionCheck.checked)

            }
            TCheckbox {
                id: clubCheck
                text: "Club"
                KeyNavigation.up: fontPlus
                KeyNavigation.right: progressCheck
                KeyNavigation.left: positionCheck
                checked: controller.clubChecked
                onCheckboxClicked: controller.setClubChecked(!clubCheck.checked)

            }
        }

    }

}

