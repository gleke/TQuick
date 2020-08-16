import QtQuick 2.6
import TQuick 1.1

/* 滚动条-竖向
滚动条可配合 Qt ListView ，Qt Flickable ,等等使用。
 TScrllbarV{
    target:listView
 }
*/
Item {
    id: tScrollbarH
    height: 22
    state: narrowed ? "narrowed" : "full"

    property Flickable target: parent
    //0 - 1
    property double xPosition: 0
    //可变小  ，true 启动状态为 narrowed false 启动状态为 full
    property bool narrowed: true
    property bool autoHide: false
    //Too small a height affects drag accuracy
    property int thumbMinWidth: 30
    property int stateDuration: 1000

    //小方块
    property alias thumb: mgadgetthumb
    //轨道
    property alias track: mTrackGadgetBackground

    property Component thumbComponent
    property Component trackComponent

    TGadgetBackground {
        id: mTrackGadgetBackground
        onWidthChanged: console.error("Width Invalid setting...")
        onHeightChanged: console.error("Height Invalid setting...")
    }

    Loader{
        id: trackLoader
        anchors.bottom: parent.bottom
        sourceComponent: trackComponent
        width: parent.width
        visible: mTrackGadgetBackground.visible
    }

    Loader{
        id: thumbLoader
        anchors.verticalCenter: trackLoader.verticalCenter
        sourceComponent: thumbComponent
        visible: mgadgetthumb.visible
        width: thumbMinWidth
    }

    //这些可以不用要了
    TGadgetBackground {
        id: mgadgetthumb
        onWidthChanged: console.error("Width Invalid setting...")
        onHeightChanged: console.error("Height Invalid setting...")
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        property bool ishold: false
        property bool isdrag: false
        property double offset: 0

        onWheel: {

        }

        onPressed: {
            ishold = true
            if (mouseX > thumbLoader.x && mouseX < thumbLoader.width + thumbLoader.x) {
                offset  = mouseX - thumbLoader.x
                isdrag = true
            } else {
                mPrivate.setValue(mouseX - thumbLoader.width / 2)
            }
        }

        onReleased: {
            ishold = false
            isdrag = false
            if (!containsMouse) {
                stateTimer.rStart()
            }
        }

        onEntered: {
            tScrollbarH.state = "full"
            stateTimer.stop()
        }

        onExited: {
            if (!ishold) {
                stateTimer.rStart()
            }
        }

        onMouseXChanged: {
            if (ishold && isdrag) {
                mPrivate.setValue(mouseX - offset)
            }
        }

        Component.onCompleted: {
            mPrivate.checkVisible()
        }

        onIsholdChanged: target.interactive = !ishold
    }

    onXPositionChanged: {
        if (mouseArea.ishold) {//drag interior setting
            target.contentX = (target.contentWidth - target.width) * xPosition
        }
    }

    Connections {
        target: tScrollbarH.target
        onContentXChanged: {
            if (!mouseArea.ishold) {
                var t = tScrollbarH.target
                var p = t.contentX / (t.contentWidth - t.width)
                mPrivate.setValue(p * (width - thumbLoader.width))
            }

            mPrivate.restoreVisibleState()
        }

        onContentWidthChanged: {
            var t  = tScrollbarH.target
            var nh = t.width / t.contentWidth * tScrollbarH.width
            if(nh > thumbMinWidth){
                thumbLoader.width = nh
            }

            mPrivate.checkVisible()
        }

        onWidthChanged:mPrivate.checkVisible()
    }

    TObject{
        id: mPrivate

        function setValue(v) {
            if(v < 0) {
                thumbLoader.x = 0
            } else if (v + thumbLoader.width > width){
                thumbLoader.x = width - thumbLoader.width
            } else {
                thumbLoader.x = v
            }

            xPosition = thumbLoader.x / (width -  thumbLoader.width)
        }

        function checkVisible() {
            var t = tScrollbarH.target
            if (t) {
                tScrollbarH.visible = t.contentWidth > t.width
                tScrollbarH.enabled = tScrollbarH.visible
            }
        }

        function restoreVisibleState() {
            if (!mouseArea.containsMouse && !mouseArea.ishold && !stateTimer.running) {
                if (tScrollbarH.narrowed) {
                    tScrollbarH.state = "narrowed"
                } else {
                    tScrollbarH.state = "full"
                }
                stateTimer.rStart()
            }
        }
    }


    trackComponent: TRectangle {
        id: mt
        state: tScrollbarH.state
        color: "#E5E5E5"
        opacity: 0.1
        states: [
            State {
                name: "full"
                PropertyChanges {
                    target: mt
                    color:"#5d5d5d"
                    height: 15
                }
            },
            State {
                name: "narrowed"
                PropertyChanges {
                    target: mt
                    height: 5
                    visible: false
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: mt
                    visible: false
                }
            }
        ]
    }

    thumbComponent: Rectangle {
        id:mth
        state: tScrollbarH.state
        radius: width / 2
        color: "#B2B2B2"
        states: [
            State {
                name: "full"
                PropertyChanges {
                    target: mth
                    height: 8
                }
            },
            State {
                name: "narrowed"
                PropertyChanges {
                    target: mth
                    height: 3
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: mth
                    visible: false
                }
            }
        ]
    }

    Timer{
        id: stateTimer
        property bool isrun: narrowed || autoHide
        interval: stateDuration
        running: isrun
        repeat: true
        onTriggered: {
            if (tScrollbarH.state === "full") {
                if (tScrollbarH.narrowed) {
                    tScrollbarH.state = "narrowed"
                } else if (tScrollbarH.autoHide) {
                    tScrollbarH.state = "hide"
                }
            } else if (tScrollbarH.state === "narrowed") {
                if(tScrollbarH.autoHide){
                    tScrollbarH.state = "hide"
                }
            }

            if (tScrollbarH.state === "hide") {
                stop()
            }
        }

        function rStart() {
            if (isrun) {
                restart()
            }
        }
    }

}
