import QtQuick 2.6
import TQuick 1.1

TDialogBasic {
    id: tDialog

    signal triggered(var button,var item)

    property string titleText: "Hello TQuick"
    property string contentText: "This is the default message"
    property bool closeable: true
    property bool contentCenter: true
    property int buttonSpacing: 15
    property list<TDialogButton> buttons

    property alias theme: tDialogTheme

    property Component headerComponent
    property Component footerComponent
    default property Component contentComponent

    TObject {
        id: mPrivate

        property var usercontentComponent
        property list<TDialogButton> default_buttons:[
            TDialogButton {
                lighter: true
                label.text: "Enter"
                label.font.bold: true
                label.color: "#409EFF"
            }
        ]
    }

    contentComponent: Item {
        id: tDialogContent
        width: 240
        height: 30

        TLabel {
            text: contentText
            anchors.centerIn: parent
            theme.parent: tDialogTheme
            theme.childName: "contentLabel"
        }
    }

    bodyComponent: TRectangle {
        id: tDialogBody
        theme.parent: tDialogTheme
        width: tDialogBodyColumnlayout.width + 10
        height: tDialogBodyColumnlayout.height + 10
        border.width: 1
        border.color: "#DCDCDC"
        color: "#FFF"
        radius: 4

        Column {
            id: tDialogBodyColumnlayout
            anchors.centerIn: parent
            spacing: 8
            Loader {
                id: headerloader
                sourceComponent: headerComponent
            }

            Loader {
                id: contentloader
                clip: true
                sourceComponent: contentComponent
                onLoaded: mPrivate.usercontentComponent = item
            }

            Loader {
                id: footerloader
                sourceComponent: footerComponent

                TDividerLine {
                    width: parent.width
                    height: 1
                    visible: footerComponent != null
                    anchors.top: parent.top
                    color: "#EFEFEF"

                    theme.parent: tDialogTheme
                    theme.childName: "line"
                }
            }
            Component.onCompleted: {
                var maxwidth = Math.max(headerloader.width,contentloader.width,footerloader.width)
                headerloader.width = maxwidth
                contentloader.width = maxwidth
                footerloader.width = maxwidth
            }
        }
    }

    headerComponent: Item {
        id: tDialogHeader
        width: 260
        height: label.height < 30 ? 30 : label.height

        TLabel {
            id: label
            text: titleText
            x: tDialog.contentCenter ? (parent.width - width) / 2 : 20
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pixelSize: TPixelSizePreset.PH5

            theme.parent: tDialogTheme
            theme.childName: "titleLabel"
        }

        TIconButton {
            padding: 10
            backgroundComponent: null
            visible: tDialog.closeable
            icon.type: TIconType.SVG
            icon.source: "qrc:/TQuick/resource/svg/close-px.svg"
            icon.position: TPosition.Only
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                tDialog.hideAndClose()
                closed()
            }

            theme.parent: tDialogTheme
            theme.childName: "closeButton"
        }
    }

    footerComponent: Item {
        id: tDialogFooter
        width: layout.width
        height: layout.height + 6
        property var md: buttons.length > 0 ? buttons : mPrivate.default_buttons

        Row {
            id: layout
            spacing: tDialog.contentCenter ? 1 : buttonSpacing
            x: tDialog.contentCenter ? (parent.width - width) / 2 : parent.width - 10 - width
            anchors.verticalCenter: parent.verticalCenter
            Repeater {
                model: md
                delegate: TIconButton {
                    width: tDialog.contentCenter ? tDialogFooter.width / md.length : 80
                    padding: 20
                    anchors.verticalCenter: parent.verticalCenter
                    backgroundComponent: null
                    theme.state: modelData.lighter ? "buttonLighter" : "" //parent state? mtheme.state ?
                    theme.className: "TDialog"
                    theme.childName: "button"

                    label.text: modelData.label.text
                    label.font: modelData.label.font
                    label.color: modelData.label.color

                    icon.type: modelData.icon.type
                    icon.source: modelData.icon.source
                    icon.width: modelData.icon.width
                    icon.height: modelData.icon.height
                    icon.color: modelData.icon.color

                    onClicked: triggered(modelData, mPrivate.usercontentComponent)
                }
            }
        }

        Repeater {
            model: md.length - 1
            delegate: TDividerLine {
                anchors.verticalCenter: parent.verticalCenter
                height: tDialogFooter.height * 0.8
                width: 1
                color: "#EFEFEF"
                x: (index + 1) * (tDialogFooter.width / md.length)
                visible: tDialog.contentCenter

                theme.parent: tDialogTheme
                theme.childName: "line"
            }
        }
    }

    TThemeBinder {
        id: tDialogTheme
        className: "TDialog"

        Component.onCompleted: initialize()
    }
}
