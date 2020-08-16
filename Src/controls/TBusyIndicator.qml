import QtQuick 2.6
import TQuick 1.1

Item {
    id: tBusyIndicator
    width: contentWidth + padding
    height: contentWidth + padding

    readonly property int contentWidth: contentComponentLoader.width
    readonly property int contentHeight: contentComponentLoader.height

    property int padding: 5
    property int  duration: 500

    property alias icon: mGadgetIcon
    property alias color: mGadgetIcon.color
    property alias theme: tBusyIndicatorTheme
    property alias running: tBusyIndicator.visible

    property Component contentComponent: defaultIconAnimator

    TGadgetIcon {
        id: mGadgetIcon
        source: TAwesomeType.FA_circle_o_notch
        color: "#5D5D5D"
    }

    Loader {
        id: contentComponentLoader
        anchors.centerIn: parent
        sourceComponent: contentComponent
    }

    readonly property Component defaultIconAnimator: TAwesomeIcon {
        source: icon.source
        color: icon.color
        theme.enabled: false
        width: 26
        height: 26
        RotationAnimator on rotation {
            from: 0
            to: 360
            duration: tBusyIndicator.duration
            running: tBusyIndicator.visible
            loops: Animation.Infinite
        }
    }

    readonly property Component defaultDotAnimator: Row {
        id: contentLayoutComponent
        spacing: 5
        Repeater {
            model: 3
            delegate: TRectangle {
                width: 12
                height: 12
                radius: 6
                color: tBusyIndicator.color
                theme.enabled: false
                property bool animrun: false
                SequentialAnimation on scale {
                    running: animrun
                    loops: Animation.Infinite
                    ScaleAnimator {
                        from: 1
                        to: 0.2
                        duration:600
                    }
                    ScaleAnimator {
                        from: 0.2
                        to: 1
                        duration:600
                    }
                }
            }
        }

        Timer {
            id: delay
            interval: 200
            repeat: true
            property int count: contentLayoutComponent.children.length
            property int i: 0
            onTriggered: {
                if (contentLayoutComponent.children[i].animrun !== "undefined") {
                    contentLayoutComponent.children[i].animrun = true
                }
                if (++i >= count - 1) {
                    stop()
                }
            }
        }

        Component.onCompleted: delay.start()
    }

    TThemeBinder {
        id: tBusyIndicatorTheme
        className: "TBusyIndicator"

        property alias source: mGadgetIcon.source
        property alias color: mGadgetIcon.color
        property alias size: tBusyIndicator.width

        Component.onCompleted: initialize()
    }
}
