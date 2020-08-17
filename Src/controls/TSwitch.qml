import QtQuick 2.0
import TQuick 1.2

Item {
    id: tSwitch
    width: content.width + padding
    height: content.height + padding

    property int padding: 6
    property bool checked: false

    property alias background: mGadgetBackground
    property alias activeBackground: mActiveGadgetBackground
    property alias dot: mDotGadgetBackground
    property alias theme: tSwitchTheme

    property Component dotComponent
    property Component backgroundComponent

    backgroundComponent: TRectangle {
        id: background
        theme.enabled: false
        width: checked ? mActiveGadgetBackground.width : mGadgetBackground.width
        height: checked ? mActiveGadgetBackground.height : mGadgetBackground.height
        radius: checked ? mActiveGadgetBackground.radius : mGadgetBackground.radius
        color: checked ? mActiveGadgetBackground.color : mGadgetBackground.color
        border.width: 1
        border.color: Qt.darker(background.color,1.1)
    }

    dotComponent: Item {
        width: mDotGadgetBackground.width
        height: mDotGadgetBackground.height

        TRectangle {
            theme.enabled: false
            anchors.fill: parent
            anchors.margins: 2
            color: mDotGadgetBackground.color
            radius: mDotGadgetBackground.radius
        }
    }

    TGadgetBackground {
        id: mGadgetBackground
        color: "#F36D6F"
        width: 40
        height: 20
        radius: height / 2
    }

    TGadgetBackground {
        id: mActiveGadgetBackground
        color: "#46A0FC"
        width: 40
        height: 20
        radius: height / 2
    }

    TGadgetBackground {
        id: mDotGadgetBackground
        width: 20
        height: 20
        radius: height / 2
    }

    Item {
        id: content
        anchors.centerIn: parent
        width: Math.max(backgroundComponentLoader.width,dotComponentLoader.width)
        height: Math.max(backgroundComponentLoader.height,dotComponentLoader.height)

        Loader {
            id: backgroundComponentLoader
            sourceComponent: backgroundComponent
            anchors.verticalCenter: parent.verticalCenter
        }

        Loader {
            id: dotComponentLoader
            sourceComponent: dotComponent
            anchors.verticalCenter: parent.verticalCenter
            x: checked ? content.width - width : 0
            Behavior on x {
                NumberAnimation {
                    duration: 80
                }
            }
        }
    }

    TMouseArea {
        id: tSwitchMousearea
        anchors.fill: parent
        onClicked: tSwitch.checked = !tSwitch.checked
    }

    TThemeBinder {
        id: tSwitchTheme
        className: "TSwitch"

        TThemeBinder {
            childName: "background"
            target: mGadgetBackground

            property color color: mGadgetBackground.color
            property int width: mGadgetBackground.width
            property int height: mGadgetBackground.height
            property int radius: mGadgetBackground.radius
        }

        TThemeBinder {
            childName: "background.active"
            target: mActiveGadgetBackground

            property color color: mActiveGadgetBackground.color
            property int width: mActiveGadgetBackground.width
            property int height: mActiveGadgetBackground.height
            property int radius: mActiveGadgetBackground.radius
        }

        TThemeBinder {
            childName: "dot"
            target: mDotGadgetBackground

            property color color: mDotGadgetBackground.color
            property int width: mDotGadgetBackground.width
            property int height: mDotGadgetBackground.height
            property int radius: mDotGadgetBackground.radius
        }

        Component.onCompleted: initialize()
    }
}

