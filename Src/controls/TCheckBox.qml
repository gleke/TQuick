import QtQuick 2.6
import TQuick 1.1

Item{
    id: tCheckBox
    width: contentLoader.width  + padding
    height: contentLoader.height + padding

    property int padding: 20
    property int spacing: 5
    property int iconPosition: TPosition.Left

    property alias icon: mIcon
    property alias iconChecked: mIconChecked
    property alias label: mLabel
    property alias theme: tCheckBoxTheme
    property alias background: mBackground
    property alias border: tRectangle.border
    property alias checked: tMouseArea.checked

    property Component iconComponent

    iconComponent: {
        if (!mIcon.source) {
            return null
        } else if(mIcon.type === TIconType.Awesome) {
            return awesomeiconComponent
        }
        return svgComponent
    }

    state: {
        if (!enabled) {
            return "disabled"
        } else if (checked) {
            return "checked"
        }
        return ""
    }

    TRectangle {
        id: tRectangle
        anchors.fill: parent
        color: mBackground.color
        visible: mBackground.visible
        radius: mBackground.radius
        border.color: Qt.darker(tRectangle.color,1.1)

        theme.parent: tCheckBoxTheme
        theme.childName: "background"
    }

    TMouseArea {
        id: tMouseArea
        anchors.fill: parent
        checkable: true
        checked: false
    }

    TGadgetBackground {
        id: mBackground
        color: "#ECF5FF"
        radius: 4
        visible: false
    }

    TGadgetLabel {
        id: mLabel
        text: "TCheckBox"
        color: tCheckBox.enabled ? "#3D3D3D" : "#9D9D9D"
    }

    TGadgetIcon {
        id: mIcon
        width: 18
        height: 18
        type: TIconType.Awesome
        source: TAwesomeType.FA_square_o
        color: tCheckBox.enabled ? "#46A0FC" : "#9D9D9D"
    }

    TGadgetIcon {
        id: mIconChecked
        width: 18
        height: 18
        type: TIconType.Awesome
        source: TAwesomeType.FA_check_square
        color: tCheckBox.enabled ? "#46A0FC" : "#9D9D9D"
    }

    Loader {
        id: contentLoader
        sourceComponent: contentRowLayoutItem
        anchors.centerIn: parent
    }

    Component {
        id: contentRowLayoutItem
        Row {
            id: row
            spacing: tCheckBox.spacing
            layoutDirection: tCheckBox.icon.position === TPosition.Left ? Qt.LeftToRight : Qt.RightToLeft

            Loader {
                id: icon
                sourceComponent: iconComponent
                enabled: false
                anchors.verticalCenter: row.verticalCenter
            }

            TLabel {
                id: label
                enabled: false
                theme.parent: tCheckBoxTheme
                theme.childName: "label"

                text: tCheckBox.label.text
                font: tCheckBox.label.font
                color: tCheckBox.label.color
                anchors.verticalCenter: row.verticalCenter
            }
        }
    }

    Component {
        id: awesomeiconComponent
        TAwesomeIcon {
            enabled: false
            theme.enabled: false
            source: !checked ? mIcon.source : mIconChecked.source
            color: !checked ? mIcon.color : mIconChecked.color
            width: !checked ? mIcon.width : mIconChecked.width
            height: !checked ? mIcon.height : mIconChecked.height
        }
    }

    Component {
        id: svgComponent
        TSVGIcon {
            enabled: false
            theme.enabled: false
            source: !checked ? mIcon.source : mIconChecked.source
            color: !checked ? mIcon.color : mIconChecked.color
            width: !checked ? mIcon.width : mIconChecked.width
            height: !checked ? mIcon.height : mIconChecked.height
        }
    }


    TThemeBinder {
        id: tCheckBoxTheme
        className: "TCheckBox"
        state: tCheckBox.state

        TThemeBinder {
            childName: "icon"
            property alias color: mIcon.color
            property alias width: mIcon.width
            property alias height: mIcon.height
        }

        TThemeBinder {
            childName: "icon.checked"
            property alias color: mIconChecked.color
            property alias width: mIconChecked.width
            property alias height: mIconChecked.height
        }

        Component.onCompleted: initialize()
    }
}
