import QtQuick 2.6
import QtQml 2.2
import TQuick 1.2

Text {
    id: tLabel
    color: "#303133"

    property alias theme: tLabelTheme

    TObject{
        id: tWrapperFont

        property alias bold: tLabel.font.bold
        property alias family: tLabel.font.family
        property alias pixelSize: tLabel.font.pixelSize
    }

    TThemeBinder {
        id: tLabelTheme
        className: "TLabel"
        state: tLabel.state

        property alias color: tLabel.color
        property alias text: tLabel.text

        property alias bold: tWrapperFont.bold
        property alias family: tWrapperFont.family
        property alias pixelSize: tWrapperFont.pixelSize

        Component.onCompleted: initialize()
    }
}
