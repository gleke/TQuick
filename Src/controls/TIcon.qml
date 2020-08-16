import QtQuick 2.0
import TQuick 1.1

Item {
    id: tIcon
    property alias theme: tIconTheme

    property string source
    property color color

    Loader {
        anchors.fill: parent
        sourceComponent: {
            if (tIcon.source.toLowerCase().indexOf(".svg") !== -1) {
                return svgComponent
            }
            return awesomeiconComponent
        }
    }

    Component {
        id: awesomeiconComponent
        TAwesomeIcon {
            enabled: false
            theme.enabled: false

            source: tIcon.source
            color: tIcon.color
        }
    }

    Component {
        id: svgComponent
        TSVGIcon {
            enabled: false
            theme.enabled: false

            source: tIcon.source
            color: tIcon.color
        }
    }

    TThemeBinder {
        id: tIconTheme
        className: "TIcon"
        state: tIcon.state

        property alias source: tIcon.source
        property alias color: tIcon.color
        property alias width: tIcon.width
        property alias height: tIcon.height

        Component.onCompleted: initialize()
    }
}
