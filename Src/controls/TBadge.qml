import QtQuick 2.6
import TQuick 1.2

Rectangle {
    id: tBadge
    radius: height / 2
    color: "#F56C6C"
    border.width: 0
    border.color: "#CB4C4C"
    width: {
        if (contentLabel.contentWidth + padding < height) {
            return height
        }
        return contentLabel.contentWidth + padding * 1.6
    }
    height: {
        return padding + contentLabel.contentHeight
    }

    property int padding: 6
    property int value : 0
    property int max: 0

    property alias label: gadgetLabel
    property alias theme: tBadgeTheme

    TLabel {
        id: contentLabel
        anchors.centerIn: parent

        theme.parent: tBadgeTheme
        theme.childName: "label"
        theme.className: tBadge.theme.className
        theme.state: tBadge.state

        text: gadgetLabel.text
        color: gadgetLabel.color
        font: gadgetLabel.font

    }

    TGadgetLabel {
        id: gadgetLabel
        color: "#FFFFFF"
        text: {
            if (max > 0 && value > max) {
                return max + "+"
            }
            return value
        }
    }

    TThemeBinder {
        id: tBadgeTheme
        state: tBadge.state
        className: "TBadge"

        property alias color: tBadge.color
        property alias width: tBadge.width
        property alias height: tBadge.height
        property alias radius: tBadge.radius
        property alias opacity: tBadge.opacity

        Component.onCompleted: initialize()

        TThemeBinder {
            target: tBadge.border
            childName: "border"

            property int width: tBadge.border.width
            property color color: tBadge.border.color
        }
    }
}
