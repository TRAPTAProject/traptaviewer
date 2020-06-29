import QtQuick 2.4

Flickable {

    id: flickablePanel
    height: 300
    width: 650

    contentHeight: 1200
    contentWidth: width

    clip: true

    signal selectedIndex(int index)

    Behavior on contentY {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
        }
    }



    function setSelectedIndex(index) {
        switch (index) {
            case 0: {
                flickablePanel.contentY = 0
                settingPanel.focus = true
                break;
            }
            case 1: {
                flickablePanel.contentY = 300
                settingPanel.focus = true
                break;
            }
            case 2: {
                flickablePanel.contentY = 600
                marqueePanel.focus = true
                break;
            }
            case 3: {
                flickablePanel.contentY = 900
                advertPanel.focus = true
                break;
            }
        }
    }

    Column {

        width: parent.width

        HelpPanel {
            id: helpPanel
            width: parent.width
            visible: true
            focus: true
            Keys.onDownPressed: {
                flickablePanel.contentY = 300
                settingPanel.focus = true
                selectedIndex(1)
            }
        }
        SettingPanel {
            id: settingPanel
            width: parent.width
            visible: true
            Keys.onUpPressed: {
                flickablePanel.contentY = 0
                helpPanel.focus = true
                selectedIndex(0)
            }

            Keys.onDownPressed: {
                flickablePanel.contentY = 600
                marqueePanel.focus = true
                selectedIndex(2)
            }
        }

        MarqueePanel {
            id: marqueePanel
            width: parent.width
            visible: true
            Keys.onUpPressed: {
                flickablePanel.contentY = 300
                settingPanel.focus = true
                selectedIndex(1)
            }

            Keys.onDownPressed: {
                flickablePanel.contentY = 900
                advertPanel.focus = true
                selectedIndex(3)
            }
        }

        AdvertPanel {
            id: advertPanel
            width: parent.width
            visible: true
            Keys.onUpPressed: {
                flickablePanel.contentY = 600
                marqueePanel.focus = true
                selectedIndex(2)
            }
        }

    }

}

