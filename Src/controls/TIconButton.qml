import QtQuick 2.6
import TQuick 1.2

TButton {
    id: tIconButton
    theme.className: "TIconButton"

    /*!设置图标样式 iconComponent 自定义后该属性设置将无效*/
    property alias icon: mGadgetIcon

    /*!设置图标与文本间隙*/
    property int spacing: 5

    /*!根据不同需求得新定义Icon，icon可能是一个图标，SVG图标，一个意想不到?什么鬼? :)*/
    property Component iconComponent

    /*!不建议重新赋值，否则此控件将失去意义*/
    contentComponent: {
        if (mGadgetIcon.position === TPosition.Only) {
            return contentOnlyiconItem
        } else if(mGadgetIcon.position === TPosition.Left || icon.position === TPosition.Reght) {
            return contentRowLayoutItem
        } else if(mGadgetIcon.position === TPosition.Top) {
            return contentColumnLayoutItem
        }
        return null
    }

    iconComponent: {
        if (!mGadgetIcon.source) {
            return null
        } else if(mGadgetIcon.type === TIconType.SVG || mGadgetIcon.source.indexOf(".svg") != -1) {
            return svgComponent
        }
        return awesomeiconComponent
    }

    TGadgetIcon {
        id: mGadgetIcon
        color: "#2D2D2D"
        width: 18
        height: 18

        position: TPosition.Left
    }

    Component {
        id: contentOnlyiconItem
        Loader {
            scale: tIconButton.theme.scale
            sourceComponent: iconComponent
        }
    }

    Component {
        id: contentRowLayoutItem
        Row {
            id: row
            spacing: tIconButton.spacing
            scale: tIconButton.theme.scale
            layoutDirection: tIconButton.icon.position === TPosition.Left ? Qt.LeftToRight : Qt.RightToLeft

            Loader {
                id: icon
                sourceComponent: iconComponent
                enabled: false
                visible: iconComponent
                anchors.verticalCenter: row.verticalCenter
            }

            TLabel {
                id: label
                enabled: false
                theme.parent: tIconButton.theme
                theme.childName: "label"

                text: tIconButton.label.text
                font: tIconButton.label.font
                color: tIconButton.label.color

                anchors.verticalCenter: row.verticalCenter
            }
        }
    }

    Component {
        id: contentColumnLayoutItem
        Column {
            spacing: tIconButton.spacing
            scale: tIconButton.theme.scale

            Loader {
                enabled: false
                sourceComponent: iconComponent
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TLabel {
                id: label
                enabled: false
                theme.parent: tIconButton.theme
                theme.childName: "label"

                text: tIconButton.label.text
                font: tIconButton.label.font
                color: tIconButton.label.color

                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Component {
        id: awesomeiconComponent
        TAwesomeIcon {
            enabled: false
            theme.childName: "icon"
            theme.parent: tIconButton.theme

            source: mGadgetIcon.source
            color:  mGadgetIcon.color
            width:  mGadgetIcon.width
            height: mGadgetIcon.height
        }
    }

    Component {
        id: svgComponent
        TSVGIcon {
            enabled: false
            theme.parent: tIconButton.theme
            theme.childName: "icon"

            source: mGadgetIcon.source
            color: mGadgetIcon.color
            width: mGadgetIcon.width
            height: mGadgetIcon.height
        }
    }
}
