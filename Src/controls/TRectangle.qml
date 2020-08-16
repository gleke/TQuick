import QtQuick 2.6
import TQuick 1.1

/* 矩形实体颜色区域 */
Rectangle {
    id: tRectangle
    color: "#FAFAFA"
    border.width: 0
    border.color: Qt.darker(color,1.1)

    property alias theme: tRectangleTheme

    TThemeBinder {
        id: tRectangleTheme
        state: tRectangle.state
        className: "TRectangle"

        property alias color: tRectangle.color
        property alias width: tRectangle.width
        property alias height: tRectangle.height
        property alias radius: tRectangle.radius
        property alias opacity: tRectangle.opacity

        TThemeBinder {
            target: tRectangle.border
            childName: "border"

            property int width: tRectangle.border.width
            property color color: tRectangle.border.color
        }

        Component.onCompleted: initialize()
    }

}
