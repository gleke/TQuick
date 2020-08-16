import QtQuick 2.6
import TQuick 1.1

TMouseArea{
    id: tButton
    width: contentComponentLoader.width + tButton.padding
    height: contentComponentLoader.height + tButton.padding
    states: TThemeManager.currentThemeValid || !theme.enabled ? defaultState : null

    property int padding: 20
    property int contentHAlign: Qt.AlignHCenter //Qt.AlignHCenter 、 Qt.AlignLeft or Qt.AlignRight
    property list<State> defaultState :[
        State {
            name: statetoString(TStateType.Pressed)
            PropertyChanges {
                target: tButtonTheme
                scale: 0.92
            }
        }
    ]

    property alias label: mGadgetLabel
    property alias border: mGadgetBorder
    property alias background: mGadgetBackground
    property alias theme: tButtonTheme

    readonly property alias contentWidth: contentComponentLoader.width
    readonly property alias contentHeight: contentComponentLoader.height

    property Component backgroundComponent
    property Component contentComponent

    Loader {
        id: backgroundComponentLoader
        anchors.fill: tButton
        sourceComponent: backgroundComponent
        visible: tButton.background.visible
    }

    Loader {
        id: contentComponentLoader
        sourceComponent: contentComponent
        anchors.verticalCenter: tButton.verticalCenter
        x: {
            if (contentHAlign == Qt.AlignLeft) {
                return padding
            } else if (contentHAlign == Qt.AlignRight) {
                return tButton.width - width - padding
            }
            return (tButton.width - width) / 2
        }
    }

    backgroundComponent: TRectangle {
        enabled: false
        theme.parent: tButtonTheme
        theme.childName: "background"
        theme.filterPropertyName: ["width", "height"]

        color: tButton.background.color
        radius: tButton.background.radius
        visible: tButton.background.visible
        opacity: tButton.background.opacity

        border.color: tButton.border.color
        border.width: tButton.border.width

        scale: tButtonTheme.scale
    }

    contentComponent: TLabel {
        enabled: false
        anchors.centerIn: parent
        theme.parent: tButtonTheme
        theme.childName: "label"

        text: tButton.label.text
        color: tButton.label.color
        font: tButton.label.font

        opacity: tButton.background.opacity

        scale: tButtonTheme.scale
    }

    TGadgetLabel {
        id: mGadgetLabel
        color: "#2D2D2D"
        text: "TButton"
    }

    TGadgetBorder {
        id: mGadgetBorder
        width: 1
        color: "#DCDCDC"
    }

    TGadgetBackground {
        id: mGadgetBackground
        color: "#FCFCFC"
        radius: 2
    }

    TThemeBinder {
        id: tButtonTheme
        className: "TButton"
        state: tButton.state

        property double scale: 1

        Component.onCompleted: initialize()
    }
}
