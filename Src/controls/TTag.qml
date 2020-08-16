import QtQuick 2.6
import TQuick 1.1

/* 一个flags文本标签
    用于标记和选择。
    TTag{
       label.text: "TTag"
    }
*/
TMouseArea{
    id: tTag
    cursorShape: Qt.ArrowCursor
    width: contentLayout.width + padding
    height: contentLayout.height + padding

    /*! 关闭 Tag 时触发的事件 */
    signal closed()

    /*! 内边距 设置内容与外边框的间距*/
    property int padding: 14
    /*! 文本与关闭按钮间隔距离 */
    property int spacing: 8
    /*! 是否可关闭 */
    property bool closable: false

    /*! 是否可点击的 */
    property alias clickable: tTag.enabled
    property alias label: tGadgetLabel
    property alias border: tGadgetBorder
    property alias background: tGadgetBackground
    property alias theme: tTagTheme

    TGadgetLabel {
        id: tGadgetLabel
        text: "Hi TTag"
        color: "#409EFF"
    }

    TGadgetBorder {
        id: tGadgetBorder
        width: 1
        color: Qt.darker(tGadgetLabel.color,1.1)
    }

    TGadgetBackground {
        id: tGadgetBackground
        radius: 2
        color: "#ECF5FF"
    }

    TGadgetIcon {
        id: tGadgetIcon
        onSourceChanged: console.log("Warning: TTag The icon source cannot be set.")

        color: tGadgetLabel.color
    }

    TRectangle {
        id: bgItem
        anchors.fill: parent
        theme.parent: tTagTheme

        color: tGadgetBackground.color
        radius: tGadgetBackground.radius
        border.width: tGadgetBorder.width
        border.color: tGadgetBorder.color
    }

    Row {
        id: contentLayout
        anchors.centerIn: tTag
        spacing: tTag.spacing

        TLabel {
            id: contentLabel
            anchors.verticalCenter: parent.verticalCenter
            theme.childName: "label"
            theme.parent: tTagTheme

            text: tGadgetLabel.text
            color: tGadgetLabel.color
            font: tGadgetLabel.font
        }

        TIconButton {
            anchors.verticalCenter: parent.verticalCenter
            theme.childName: "closeButton"
            theme.parent: tTagTheme

            padding: 2
            visible: tTag.closable
            icon.width: 15
            icon.height: 15
            icon.color: tGadgetIcon.color
            icon.type: TIconType.SVG
            icon.position: TPosition.Only
            icon.source: "qrc:/TQuick/resource/svg/close-px.svg"
            backgroundComponent: null

            onClicked: tTag.closed()
        }
    }

    TThemeBinder {
        id: tTagTheme
        className: "TTag"

        Component.onCompleted: initialize()
    }
}
