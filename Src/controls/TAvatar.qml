import QtQuick 2.6
import TQuick 1.1

Item {
    id: tAvatar
    width: sourceImage.sourceSize.width
    height: sourceImage.sourceSize.height

    property int radius
    property bool asynchronous: true
    property bool smooth: true

    /*! A border */
    property alias border: mGadgetBorder
    property alias source: sourceImage.source
    property alias fillMode: sourceImage.fillMode

    property alias theme: tAvatarTheme

    TGadgetBorder {
        id: mGadgetBorder
        width: 0
        color: "#8D8D8D"
    }

    Image {
        id: sourceImage
        visible: false
        enabled: false
        anchors.fill: parent
        antialiasing: tAvatar.smooth
        smooth: tAvatar.smooth
        asynchronous: tAvatar.asynchronous
    }

    Rectangle {
        id: mask
        color: "black"
        anchors.fill: parent
        radius: tAvatar.radius
        visible: false
        antialiasing: true
        smooth: true
        enabled: false
    }

    TMask {
        anchors.fill: parent
        sourceItem: sourceImage
        maskItem: mask
    }

    TRectangle {
        color: "transparent"
        radius: tAvatar.radius
        border.width: mGadgetBorder.width
        border.color: mGadgetBorder.color
        anchors.fill: parent
        theme.parent: tAvatarTheme
    }

    TThemeBinder {
        id: tAvatarTheme
        className: "TAvatar"

        property alias radius: tAvatar.radius

        Component.onCompleted: initialize()
    }
}
