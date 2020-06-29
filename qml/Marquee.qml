import QtQuick 2.5

Item {

    id: marqueeRoot

    property int fontRatio: 90
    property int speed: 100
    property string marqueeText: "Default QML text for marquee"
    property string processedText: marqueeText + " --- " + marqueeText + " --- "

    clip: true

    Text {
        id: textElement
        height: parent.height
        color: "black"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: parent.height*fontRatio/100
        text: processedText
    }

    Text {
        id: hiddenText
        visible: false
        height: parent.height
        color: "red"
        width: parent.width
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: parent.height*fontRatio/100
        text: marqueeText
        elide: Text.ElideRight
        onFontChanged: checkIfScrollNeeded()
        onTextChanged: checkIfScrollNeeded()
        Component.onCompleted: checkIfScrollNeeded()
        onWidthChanged: checkIfScrollNeeded()
    }

    NumberAnimation {
        id: textScroller
        target: textElement
        loops: Animation.Infinite
        property: "x";
        from: 0
        to: -textElement.contentWidth/2
        duration: textElement.contentWidth / speed * 1000
        easing.type: Easing.Linear
    }

    function checkIfScrollNeeded() {
        if (marqueeText=="" || !hiddenText.truncated) {
            processedText = marqueeText
            textScroller.stop();
            textElement.x = 0
        }
        else {
            processedText = marqueeText + " --- " + marqueeText + " --- "
            textScroller.restart();
        }
    }


}
