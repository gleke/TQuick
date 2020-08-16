import QtQuick 2.6
import TQuick 1.1

Item {
    id: tCarousel
    clip: true

    signal triggered(var modelData)

    property int itemWidth
    property int itemHeight
    property int margen: itemWidth / 3
    property int interval: TTimePreset.ShortTime2s
    property int pathItemCount: 3

    property alias count: pathView.count
    property alias currentIndex: pathView.currentIndex
    property alias currentItem: pathView.currentItem
    property alias theme: tCarouselTheme

    default property alias childs: tCarousel.chillilst

    property list<TCarouselElement> chillilst

    property Component contentComponent

    function addElement(element) {
        pathView.model.append(element)
    }

    function decrementCurrentIndex() {
        pathView.decrementCurrentIndex()
    }

    function incrementCurrentIndex() {
        pathView.incrementCurrentIndex()
    }

    contentComponent: TAvatar {
        source: modelData.imageSource
        radius: 10
        theme.state: tCarouselTheme.state
        theme.className: tCarouselTheme.className
        theme.groupName: tCarouselTheme.groupName
    }

    PathView {
        id: pathView

        anchors.fill: parent
        interactive: false
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        pathItemCount: tCarousel.pathItemCount
        cacheItemCount: model.count
        highlightRangeMode: PathView.StrictlyEnforceRange
        model: ListModel{}

        delegate: Loader {
            //可供contentComponent 使用
            property int itemIndex: index
            property var modelData: model
            property bool isCurrentItem: PathView.isCurrentItem

            width: itemWidth
            height: itemHeight
            z: PathView.zOrder
            scale: PathView.itemScale
            visible: PathView.onPath

            sourceComponent: contentComponent
        }

        path:Path {
            startX: margen
            startY: tCarousel.height / 2
            PathAttribute {
                name: "zOrder"
                value: 0
            }
            PathAttribute {
                name: "itemScale"
                value: 0.8
            }
            PathLine {
                x: tCarousel.width / 2
                y: tCarousel.height / 2
            }
            PathAttribute {
                name: "zOrder"
                value: 10
            }
            PathAttribute {
                name: "itemScale"
                value: 1
            }
            PathLine {
                x: tCarousel.width - margen
                y: tCarousel.height / 2
            }
            PathAttribute {
                name: "zOrder"
                value: 0
            }
            PathAttribute {
                name: "itemScale"
                value: 0.8
            }
        }

        Component.onCompleted: {
            if (chillilst.length >= 3 && pathItemCount < 3) {
                pathItemCount = 3
            }
            for (var i in chillilst) {
                pathView.model.append(chillilst[i])
            }
        }

        onCurrentIndexChanged: autoNextTimer.restart()
    }

    TMouseArea {
        anchors.fill: parent
        property int px: 0
        property int dis: 10
        hoverEnabled: true

        onPressed: px = mouseX
        onReleased: {
            if (Math.abs(px - mouseX) > dis) {
                if (px < mouseX) {
                    pathView.decrementCurrentIndex()
                } else if (px > mouseX) {
                    pathView.incrementCurrentIndex()
                }
            } else {
                var c = pathView.currentItem
                if (mouseX < c.x) {
                    pathView.decrementCurrentIndex()
                } else if (mouseX > c.x + c.width) {
                    pathView.incrementCurrentIndex()
                } else {
                    triggered(c.modelData)
                }
            }
            autoNextTimer.restart()
        }
    }

    Timer {
        id: autoNextTimer
        interval: tCarousel.interval
        running: tCarousel.interval > 0
        repeat: true
        onTriggered: pathView.incrementCurrentIndex()
    }

    TThemeBinder {
        id: tCarouselTheme
        className: "TCarousel"

        property alias itemWidth: tCarousel.itemWidth
        property alias itemHeight: tCarousel.itemHeight

        Component.onCompleted: initialize()
    }
}
