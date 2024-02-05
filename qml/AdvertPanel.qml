import QtQuick

FocusScope {
    id: setting
    height: 300

    property int advertLineCount: listModel.advertLineCount
    //onAdvertLineCountChanged: controller.setAdvertLineCount = advertLineCount

    Rectangle {
        anchors.fill: parent
        color: "darkslategray"
    }
    Item {
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.leftMargin: 40
        anchors.rightMargin: 40

        TCheckbox {
            id: advertCheckbox
            focus: true
            anchors.top: parent.top
            anchors.left: parent.left
            text: "Afficher ce bandeau d'annonce à chaque boucle :"
            checked: listModel.displayAdvert
            onCheckboxClicked: listModel.setDisplayAdvert(!advertCheckbox.checked)
            KeyNavigation.down: adHeightMinus
        }

        Row {
            id: heightSetting
            anchors.top: advertCheckbox.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
            width: parent.width
            spacing: 30
            Text {
                text: "Hauteur :"
                font.pixelSize: 20
                color: "white"
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
            TButton {
                id: adHeightMinus
                width: 100
                focus: true
                sourceNormal: "qrc:/images/minus-white.png"
                sourcePressed: "qrc:/images/minus-black.png"
                KeyNavigation.right: adHeightPlus
                KeyNavigation.left: adHeightMinus
                KeyNavigation.down: chooseButton
                KeyNavigation.up: advertCheckbox
                onButtonClicked: {
                    listModel.decAdvertLineCount()
                }
            }
            Text {
                id: adHeight
                text: advertLineCount+" lignes"
                font.pixelSize: 20
                color: "white"
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }

            TButton {
                id: adHeightPlus
                sourceNormal: "qrc:/images/plus-white.png"
                sourcePressed: "qrc:/images/plus-black.png"
                width: 100
                KeyNavigation.left: adHeightMinus
                KeyNavigation.right: adHeightPlus
                KeyNavigation.down: chooseButton
                KeyNavigation.up: advertCheckbox
                onButtonClicked: {
                    listModel.incAdvertLineCount();

                }
            }
        }

        Item {

            width: parent.width
            anchors.top: heightSetting.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 50

            Image {
                id: banner
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: chooseButton.left
                source: listModel.advertFile===""?"qrc:/images/adbanner.png":listModel.advertFile
            }


            TButton {
                id: chooseButton
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "Choisir une image..."
                KeyNavigation.up: adHeightPlus
                onButtonClicked: {
                    fileDialog.open()
                }
            }

        }

    }

}
