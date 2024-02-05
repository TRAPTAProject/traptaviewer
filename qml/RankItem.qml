import QtQuick

Item {

    id: rankItem

    property alias visiblePosition: idPosition.visible
    property alias visibleTrend: idTrend.visible
    property alias visibleShift: idShift.visible
    property alias visibleClub: idClub.visible
    property int fontRatio: 90

    property int _fontSize: rankItem.height*fontRatio/100

    // rank
    Rectangle {
        id: idRank
        anchors.left: parent.left
        height: parent.height
        width: parent.height*1.4
        color: rank=="--"?"black":"white"

        Text {
            height: parent.height
            width: parent.width
            text: rank
            font.pixelSize: _fontSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: rank=="--"?"white":"black"
        }

    }

    Item {

        anchors.right: idVolley.left
        anchors.left: idRank.right
        height: parent.height

        Text {
            id: idName
            anchors.right: idClub.left
            anchors.left: parent.left
            height: parent.height
            elide: Text.ElideRight
            text: " "+name
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: _fontSize
            color: currentRound?"white":"yellow"
        }

        Text {
            id: idClub
            anchors.right: parent.right
            height: parent.height
            width: idClub.visible ? parent.width*0.38 : 0
            elide: Text.ElideRight
            text: " "+club
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: _fontSize
            color: currentRound?"white":"yellow"
        }

    }

    Text {
        id: idVolley
        anchors.right: idCurrentRound.left
        width: parent.height*2.3
        height: parent.height
        text: {
            if (volley<0) return "(?)"
            else return "("+volley+")";
        }
        font.pixelSize: _fontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: currentRound?"white":"yellow"
    }

    Text {
        id: idCurrentRound
        anchors.right: idScore.left
        width: parent.height*2.3
        height: parent.height
        text: score
        font.pixelSize: _fontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: currentRound?"white":"yellow"
    }

    Text {
        id: idScore
        visible: (overallScore>-1)
        anchors.right: idOption.left
        width: parent.height*2.3
        height: parent.height
        text: overallScore
        font.pixelSize: _fontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: currentRound?"white":"yellow"
    }

    Row {

        id: idOption
        spacing: 5
        anchors.right: parent.right
        height: parent.height

        Row {
            id: idShift
            height: parent.height
            width: parent.height*2.8

            Item {
                visible: shift!=0
                height: parent.height
                width: parent.height
                Image {
                    height: parent.height*0.9
                    width: parent.width*0.9
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: shift>0?"qrc:/images/arrowup.png":
                            shift<0?"qrc:/images/arrowdown.png":""
                }
            }
            Text {
                visible: shift!=0
                height: parent.height
                text: shift
                font.pixelSize: _fontSize
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                color: currentRound?"white":"yellow"

            }
        }

        Item {
            id: idTrend
            height: parent.height
            width: parent.height
            Image {
                height: parent.height*0.9
                width: parent.width*0.9
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: trend==-2?"qrc:/images/smiley-2.png":
                        trend==-1?"qrc:/images/smiley-1.png":
                        trend==1?"qrc:/images/smiley1.png":
                        trend==2?"qrc:/images/smiley2.png":""

            }
        }

        // position
        Rectangle {
            id: idPosition
            height: parent.height*0.9
            width: parent.height*1.8
            color: "cyan"

            Text {
                height: parent.height
                width: parent.width
                text: position
                font.pixelSize: _fontSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "black"
            }

        }
    }

}
