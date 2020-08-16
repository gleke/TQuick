import QtQuick 2.6
import TQuick 1.1

/* 滚动条-竖向
滚动条可配合 Qt ListView ，Qt Flickable ,等等使用。
 TScrllbarV{
    target:listView
 }
*/
Item {
    id: tScrollbarV
    width: 22

    property Flickable target: parent
    //0 - 1
    property double yPosition: 0
    //小方块
    property alias thumb: mThumbGadgetBackground
    //轨道
    property alias track: mgadgettrack
    //可变小  ，true 启动状态为 narrowed false 启动状态为 full
    property bool narrowed: true
    property bool autoHide: false
    //Too small a height affects drag accuracy
    property int thumbMinHieght: 30
    property int stateDuration: 1000

    property Component thumbComponent
    property Component trackComponent

    state: narrowed ? "narrowed" : "full"

    TGadgetBackground {
        id: mgadgettrack
        onWidthChanged: console.error("Width Invalid setting...")
        onHeightChanged: console.error("Height Invalid setting...")
    }

    Loader {
        id: trackLoader
        anchors.right: parent.right
        sourceComponent: trackComponent
        height: parent.height
        visible: mgadgettrack.visible
    }

    Loader {
        id: thumbLoader
        anchors.horizontalCenter: trackLoader.horizontalCenter
        sourceComponent: thumbComponent
        visible: mThumbGadgetBackground.visible
        height: thumbMinHieght
    }

    //这些可以不用要了
    TGadgetBackground {
        id: mThumbGadgetBackground
        onWidthChanged: console.error("Width Invalid setting...")
        onHeightChanged: console.error("Height Invalid setting...")
    }

    MouseArea{
        id: mouseArea
        //anchors.fill: parent
        width: parent.width
        height: parent.height
        hoverEnabled: true

        property bool ishold: false
        property bool isdrag: false
        property double offset: 0

        onWheel: {

        }

        onPressed: {
            ishold = true
            if (mouseY > thumbLoader.y && mouseY < thumbLoader.height + thumbLoader.y) {
                offset = mouseY - thumbLoader.y
                isdrag = true
            } else {
                mPrivate.setValue(mouseY - thumbLoader.height / 2)
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
            tScrollbarV.state = "full"
            stateTimer.stop()
        }

        onExited: {
            if (!ishold) {
                stateTimer.rStart()
            }
        }

        onMouseYChanged: {
            if (ishold && isdrag) {
                mPrivate.setValue(mouseY - offset)
            }
        }

        Component.onCompleted: {
            mPrivate.checkVisible()
        }

        onIsholdChanged: target.interactive = !ishold
    }

    onYPositionChanged: {
        if (mouseArea.ishold) {//drag interior setting
            target.contentY = (target.contentHeight - target.height) * yPosition
        }
    }

    Connections {
        target: tScrollbarV.target
        onContentYChanged:{
            if (!mouseArea.ishold) {
                var t = tScrollbarV.target
                var p = t.contentY / (t.contentHeight - t.height)
                mPrivate.setValue(p * (height - thumbLoader.height))
            }

            mPrivate.restoreVisibleState()
        }

        onContentHeightChanged: {
            var t  = tScrollbarV.target
            var nh = t.height / t.contentHeight * tScrollbarV.height
            if (nh > thumbMinHieght) {
                thumbLoader.height = nh
            }
            mPrivate.checkVisible()
        }

        onHeightChanged:mPrivate.checkVisible()
    }

    TObject{
        id: mPrivate

        function setValue(v) {
            if (v < 0) {
                thumbLoader.y = 0
            } else if (v + thumbLoader.height > height){
                thumbLoader.y = height - thumbLoader.height
            } else {
                thumbLoader.y = v
            }

            yPosition = thumbLoader.y / (height -  thumbLoader.height)
        }

        function checkVisible() {
            var t = tScrollbarV.target
            if (t) {
                tScrollbarV.visible = t.contentHeight > t.height
                tScrollbarV.enabled = tScrollbarV.visible
            }
        }

        function restoreVisibleState() {
            if (!mouseArea.containsMouse && !mouseArea.ishold && !stateTimer.running) {
                if (tScrollbarV.narrowed) {
                    tScrollbarV.state = "narrowed"
                } else {
                    tScrollbarV.state = "full"
                }
                stateTimer.rStart()
            }
        }
    }


    trackComponent: TRectangle {
        id: mt
        theme.enabled: false
        state: tScrollbarV.state
        color: "#E5E5E5"
        opacity: 0.1
        states: [
            State {
                name: "full"
                PropertyChanges {
                    target: mt
                    color:"#5d5d5d"
                    width: 15
                }
            },
            State {
                name: "narrowed"
                PropertyChanges {
                    target: mt
                    width:5
                    visible:false
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: mt
                    visible:false
                }
            }
        ]
    }

    thumbComponent: TRectangle{
        id: mth
        theme.enabled: false
        state: tScrollbarV.state
        radius: width / 2
        color: "#B2B2B2"
        states: [
            State {
                name: "full"
                PropertyChanges {
                    target: mth
                    width: 8
                }
            },
            State {
                name: "narrowed"
                PropertyChanges {
                    target: mth
                    width: 3
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
        repeat : true
        onTriggered: {
            if (tScrollbarV.state === "full") {
                if (tScrollbarV.narrowed) {
                    tScrollbarV.state = "narrowed"
                } else if (tScrollbarV.autoHide) {
                    tScrollbarV.state = "hide"
                }
            } else if (tScrollbarV.state === "narrowed") {
                if (tScrollbarV.autoHide) {
                    tScrollbarV.state = "hide"
                }
            }

            if (tScrollbarV.state === "hide") {
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
