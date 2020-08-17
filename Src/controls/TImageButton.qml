import QtQuick 2.6
import TQuick 1.2

TMouseArea{
    id: tImageButton

    property string source
    property string pressSource
    property double pressScale: 0.9

    property alias theme: tImageButtonTheme

    states: TThemeManager.appThemeInvalid ? defstates : []

    Image {
        id: image
        anchors.fill: parent
        source: tImageButton.source
    }

    property list<State> defstates: [
        State {
            name: statetoString(TStateType.Pressed)
            PropertyChanges {
                target: image
                scale: pressScale
                source: {
                    if (pressSource) {
                        return pressSource
                    }
                    return tImageButton.source
                }
            }
        }
    ]

    TThemeBinder {
        id: tImageButtonTheme
        className: "TImageButton"
        state: tImageButton.state
        target: image

        property string source: image.source
        property double scale: image.scale

        Component.onCompleted: initialize()
    }

}
