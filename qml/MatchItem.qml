import QtQuick 2.0

Item {

    id: matchItem

    property int fontRatio: 90

    property int _fontSize: matchItem.height*fontRatio/100

    Text {
        id: idRank
        height: parent.height
        width: parent.height*1.4
        text: rank
        font.pixelSize: parent.height*fontRatio/100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "yellow"
    }

    Rectangle {
        id: idName
        anchors.right: idVolley.left
        anchors.left: idRank.right
        height: parent.height
        color: winner?"white":"black"
        Text {
            anchors.fill: parent
            elide: Text.ElideRight
            text: " "+name
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: _fontSize
            color: winner?"black":"white"
        }
    }

    Row {
        id: idVolley
        height: parent.height
        anchors.right: idSpot.left
        spacing: 5
        width: parent.height*10+4*spacing // 5*MatchVolley size
        MatchVolley {
            visible: matchVolley1>-1
            text: matchVolley1
            marker: matchMarker1
            fontPixelSize: _fontSize
        }
        MatchVolley {
            visible: matchVolley2>-1
            text: matchVolley2
            marker: matchMarker2
            fontPixelSize: _fontSize
        }
        MatchVolley {
            visible: matchVolley3>-1
            text: matchVolley3
            marker: matchMarker3
            fontPixelSize: _fontSize
        }
        MatchVolley {
            visible: matchVolley4>-1
            text: matchVolley4
            marker: matchMarker4
            fontPixelSize: _fontSize
        }
        MatchVolley {
            visible: matchVolley5>-1
            text: matchVolley5
            marker: matchMarker5
            fontPixelSize: _fontSize
        }

    }

    Item {
        id: idSpot
        height: parent.height
        width: parent.height
        anchors.right: idScore.left
        Image {
            anchors.centerIn: parent
            height: parent.height*0.8
            width: parent.height*0.8
            fillMode: Image.PreserveAspectFit
            source: winner?"qrc:/images/greenspot.png":"qrc:/images/redspot.png"
        }
    }

    Text {
        id: idScore
        text: score
        height: parent.height
        width: parent.height*1.5
        anchors.right: parent.right
        font.pixelSize: parent.height*fontRatio/100
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        color: "white"
    }
}
