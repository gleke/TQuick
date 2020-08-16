import QtQuick 2.6
import TQuick 1.1

Item {
    id: tAwesomeIcon
    width: 16
    height: 16

    property color color
    property string source

    property alias theme: tAwesomeIconTheme

    Text {
        id: contentText
        anchors.fill: parent
        enabled: false
        color: tAwesomeIcon.color
        font.family: "fontawesome"
        font.pixelSize: Math.max(tAwesomeIcon.width, tAwesomeIcon.height)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    TObject {
        id: wrapper
        property alias source: tAwesomeIcon.source
        onSourceChanged: {
            if (source.indexOf("FA") === 0) {
                contentText.text = TQuick.awesomeFromKey(source)
            } else if (source.charAt(0) !== "\\") {
                contentText.text = TQuick.awesomeFromValue(source)
            } else {
                contentText.text = source
            }
        }
    }

    TThemeBinder {
        id: tAwesomeIconTheme
        className: "TAwesomeIcon"
        state: tAwesomeIcon.state

        property alias color: tAwesomeIcon.color
        property alias source: tAwesomeIcon.source
        property alias width: tAwesomeIcon.width
        property alias height: tAwesomeIcon.height

        Component.onCompleted: initialize()
    }
}
