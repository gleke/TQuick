import QtQuick 2.6
import TQuick 1.1

/*! TODO */
Item {
    id: tFpsMonitor
    width: contentItemLoader.width + 5
    height: contentItemLoader.height + 5

    readonly property alias fps: mPrivate.fps
    readonly property alias fpsAvg: mPrivate.fpsAvg

    property color color: "#C0C0C0"
    property Component contentItem: contentComponent

    Component {
        id: contentComponent
        TLabel {
            font.pixelSize: 10
            font.bold: true
            text: " Avg " + fpsAvg + " | " + fps + " Fps"
        }
    }

    TObject {
        id: mPrivate
        property int frameCounter: 0
        property int frameCounterAvg: 0
        property int counter: 0
        property int fps: 0
        property int fpsAvg: 0
    }

    Rectangle {
        id: monitor
        radius: 3
        width: 6
        height: width
        opacity: 0

        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }
        onRotationChanged: mPrivate.frameCounter++
    }

    Loader{
        id: contentItemLoader
        sourceComponent: contentItem
    }

    Timer {
        interval: 2000
        repeat: true
        running: visible
        onTriggered: {
            mPrivate.frameCounterAvg += mPrivate.frameCounter
            mPrivate.fps = mPrivate.frameCounter/2
            mPrivate.counter++
            mPrivate.frameCounter = 0
            if (mPrivate.counter >= 3) {
                mPrivate.fpsAvg = mPrivate.frameCounterAvg/(2 * mPrivate.counter)
                mPrivate.frameCounterAvg = 0
                mPrivate.counter = 0
            }
        }
    }
}

