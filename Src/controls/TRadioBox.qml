import QtQuick 2.6
import TQuick 1.1

/* 单选框
    在一组备选项中进行单选 (需要放入 TRadioBoxGroup)
    不在组中的RadioBox无法改变状态
*/
Item {
    id: tRadioBox
    objectName: Math.random()
    width: contentLoader.width + padding
    height: contentLoader.height + padding

    property bool checked
    property int padding: 20
    property int spacing: 5
    property int iconPosition: TPosition.Left
    property int groupIndex: -1

    property alias icon: mGadgetIcon
    property alias iconChecked: mCheckedGadgetIcon
    property alias label: mGadgetLabel
    property alias theme: tRadioBoxTheme
    property alias background: mGadgetBackground
    property alias border: tBackground.border

    property Component iconComponent

    iconComponent: {
        if (!mGadgetIcon.source) {
            return null
        } else if (mGadgetIcon.type === TIconType.Awesome) {
            return awesomeiconComponent
        }
        return svgComponent
    }

    state: {
        if (!enabled) {
            return "disabled"
        } else if(checked) {
            return "checked"
        }
        return ""
    }

    TGadgetBackground {
        id: mGadgetBackground
        color: "#ECF5FF"
        radius: 4
        visible: false
    }

    TGadgetLabel {
        id: mGadgetLabel
        text: "TRadioBox"
        color: tRadioBox.enabled ? "#3D3D3D" : "#9D9D9D"
    }

    TGadgetIcon {
        id: mGadgetIcon
        width: 18
        height: 18
        type: TIconType.Awesome
        source: TAwesomeType.FA_circle_o
        color: tRadioBox.enabled ? "#46A0FC" : "#9D9D9D"
    }

    TGadgetIcon {
        id: mCheckedGadgetIcon
        width: 18
        height: 18
        type: TIconType.Awesome
        source: TAwesomeType.FA_dot_circle_o
        color: tRadioBox.enabled ? "#46A0FC" : "#9D9D9D"
    }

    TRectangle {
        id: tBackground
        anchors.fill: parent
        color: mGadgetBackground.color
        visible: mGadgetBackground.visible
        radius: mGadgetBackground.radius
        border.color: Qt.darker(tBackground.color, 1.1)

        theme.parent: tRadioBoxTheme
        theme.childName: "background"
    }

    TMouseArea {
        id: tMouseArea
        anchors.fill: parent
        onClicked: tRadioBox.checked = true
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
            spacing: tRadioBox.spacing
            layoutDirection: tRadioBox.iconPosition === TPosition.Left ? Qt.LeftToRight : Qt.RightToLeft

            Loader {
                id: icon
                sourceComponent: iconComponent
                enabled: false
                anchors.verticalCenter: row.verticalCenter
            }

            TLabel {
                id: label
                enabled: false
                theme.parent: tRadioBoxTheme
                theme.childName: "label"

                text: tRadioBox.label.text
                font: tRadioBox.label.font
                color: tRadioBox.label.color
                anchors.verticalCenter: row.verticalCenter
            }
        }
    }

    Component {
        id: awesomeiconComponent
        TAwesomeIcon {
            enabled: false
            theme.enabled: false
            source: !checked ? mGadgetIcon.source : mCheckedGadgetIcon.source
            color: !checked ? mGadgetIcon.color : mCheckedGadgetIcon.color
            width: !checked ? mGadgetIcon.width : mCheckedGadgetIcon.width
            height: !checked ? mGadgetIcon.height : mCheckedGadgetIcon.height
        }
    }

    Component {
        id: svgComponent
        TSVGIcon {
            enabled: false
            theme.enabled: false
            source: !checked ? mGadgetIcon.source : mCheckedGadgetIcon.source
            color: !checked ? mGadgetIcon.color : mCheckedGadgetIcon.color
            width: !checked ? mGadgetIcon.width : mCheckedGadgetIcon.width
            height: !checked ? mGadgetIcon.height : mCheckedGadgetIcon.height
        }
    }

    TThemeBinder {
        id: tRadioBoxTheme
        className: "TRadioBox"
        state: tRadioBox.state

        TThemeBinder {
            childName: "icon"

            property alias color: mGadgetIcon.color
            property alias width: mGadgetIcon.width
            property alias height: mGadgetIcon.height
        }

        TThemeBinder {
            childName: "icon.checked"

            property alias color: mCheckedGadgetIcon.color
            property alias width: mCheckedGadgetIcon.width
            property alias height: mCheckedGadgetIcon.height
        }

        Component.onCompleted: initialize()
    }
}
