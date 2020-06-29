import QtQuick 2.0

ListView {

    property int listRowHeight: 30
    property alias duration: scrollingAnim.duration
    property int listFontRatio: 90
    property bool positionVisible: true
    property bool trendVisible: true
    property bool shiftVisible: true
    property bool clubVisible: true
    property bool scroll: true
    property int rowIndex: 0

    property int _startY: 0

    id: scrollingList
    cacheBuffer: 10000

    delegate: Loader {
        sourceComponent: {
            if (rowType=="rank") return idRankComponent;
            if (rowType=="blank") return idBlankComponent;
            if (rowType=="position") return idPositionComponent;
            if (rowType=="cut") return idCutComponent;
            if (rowType=="categ") return idTitleComponent;
            if (rowType=="title") return idTitleComponent;
            if (rowType=="advert") return idAdvertComponent;
            if (rowType=="team") return idTeamComponent;
            if (rowType=="match") return idMatchComponent;

        }

        Component {
            id: idRankComponent
            RankItem {
                height: listRowHeight
                width: scrollingList.width
                fontRatio: listFontRatio
                visiblePosition: scrollingList.positionVisible
                visibleShift: scrollingList.shiftVisible
                visibleTrend: scrollingList.trendVisible
                visibleClub: scrollingList.clubVisible
            }

        }

        Component {
            id: idTeamComponent
            TeamItem {
                height: listRowHeight
                width: scrollingList.width
                fontRatio: listFontRatio
            }

        }

        Component {
            id: idMatchComponent
            MatchItem {
                height: listRowHeight
                width: scrollingList.width
                fontRatio: listFontRatio
            }

        }

        Component {
            id: idPositionComponent
            PositionItem {
                height: listRowHeight
                width: scrollingList.width
                visibleClub: scrollingList.clubVisible
                fontRatio: listFontRatio
            }

        }

        Component {
            id: idBlankComponent
            Item {
                height: listRowHeight
                width: scrollingList.width

            }

        }

        Component {
            id: idCutComponent
            CutItem {
                height: listRowHeight
                width: scrollingList.width
                fontRatio: listFontRatio
            }

        }

        Component {
            id: idTitleComponent
            TitleItem {
                height: listRowHeight
                width: scrollingList.width
                fontRatio: listFontRatio
            }

        }

        Component {
            id: idAdvertComponent
            AdvertItem {
                height: listRowHeight
                width: scrollingList.width

            }

        }

    }


    NumberAnimation {
        id: scrollingAnim;
        target: scrollingList
        property: "contentY";
        from: _startY
        to: _startY+listRowHeight
        easing.type: Easing.Linear
        onStopped: restartScrolling()
    }


    function resetScrolling() {
        scrollingAnim.stop();
        _startY = 0;
        scrollingList.contentY = 0
    }

    function restartScrolling() {
        if (!scroll) return;
        _startY = scrollingList.contentY;
        if (_startY>=(scrollingList.count/2)*listRowHeight) {
            _startY =0;
        }
        rowIndex = _startY/listRowHeight;
        scrollingAnim.start()
    }

    onScrollChanged: {
        if (scroll) restartScrolling();
        else resetScrolling();
    }

    Component.onCompleted: {
        if (scroll) restartScrolling();
    }

}
