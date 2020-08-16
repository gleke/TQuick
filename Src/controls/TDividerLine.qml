import QtQuick 2.6
import TQuick 1.1

Rectangle {
    id: tDividerLine

    property alias theme: tDividerLineTheme

    color: "#DCDFE6"

    TThemeBinder {
        id: tDividerLineTheme
        state: tDividerLine.state
        className: "TDividerLine"

        property alias color: tDividerLine.color

        Component.onCompleted: initialize()
    }

}
