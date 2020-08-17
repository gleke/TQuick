import QtQuick 2.6
import TQuick 1.2

// 定点弹出框
//    与Dialog 不同的时他的小窗是指定位置的。
//    重新实现bodyComponent ，可完成高级扩展，请参考 TPopoverMenu
TPopup {
    id: tPopover

    property int padding: 2
    property int bodyWidth: 150

    property alias bodyBackground: mBodyGadgetBackground
    property alias bodyBorder: mBodyGadgetBorder
    property alias theme: tPopoverTheme

    property Component bodyComponent: defaultDodyComponent

    backgroundComponent: null
    onTriggeredBackground: close()
    onBodyWidthChanged: resetLayout()

    function open(pos_x,pos_y) {
        bodyLoader.show()
        privatec.create()
        bodyLoader.x = pos_x
        bodyLoader.y = pos_y

        resetLayout()
        opened()
    }

    function openToGlobal(item, off_x, off_y) {
        bodyLoader.show()
        privatec.create()
        var ox = off_x ? off_x + 2 : 0
        var oy = off_y ? off_y + 2 : 0
        var p = item.parent.mapToGlobal(item.x + ox , item.y + oy)

        bodyLoader.x = p.x - rootWindow.x
        bodyLoader.y = p.y - rootWindow.y

        resetLayout()
        opened()
    }

    function resetLayout() {
        if (bodyLoader.width + bodyLoader.x > rootWindow.width) {
            bodyLoader.x = rootWindow.width - bodyLoader.width - 5
        } else if (bodyLoader.x <= 0) {
            bodyLoader.x = 5
        }

        if (bodyLoader.height + bodyLoader.y > rootWindow.height) {
            bodyLoader.y = rootWindow.height - bodyLoader.height - 5
        } else if (bodyLoader.y <= 0) {
            bodyLoader.y = 5
        }
    }

    function close() {
        privatec.close()
        bodyLoader.hide()
        closeed()
    }

    Connections {
        target: rootWindow
        onWidthChanged:close()
        onHeightChanged:close()
    }

    TGadgetBackground {
        id: mBodyGadgetBackground
        radius: 2
        color: "#FCFCFC"
    }

    TGadgetBorder {
        id: mBodyGadgetBorder
        width: 1
        color: Qt.darker(mBodyGadgetBackground.color,1.2)
    }

    Loader {
        id: bodyLoader
        MouseArea {
            anchors.fill: parent
            z: -1
        }

        function show() {
            sourceComponent = bodyComponent
        }

        function hide() {
            sourceComponent = null
        }
    }

    Component {
        id: defaultDodyComponent
        TRectangle {
            width: bodyWidth + border.width * 4
            height: clayout.height + 20
            color: mBodyGadgetBackground.color
            radius: mBodyGadgetBackground.radius
            border.width: mBodyGadgetBorder.width
            border.color: mBodyGadgetBorder.color

            Column {
                id: clayout
                width: parent.width
                spacing: 10
                anchors.top: parent.top
                anchors.topMargin: tPopover.padding

                TRectangle {
                    width: parent.width - 2
                    anchors.horizontalCenter: parent.horizontalCenter

                    height: 28
                    TLabel {
                        text: "TPopover测试"
                        font.pixelSize: TPixelSizePreset.PH5
                        anchors.centerIn: parent
                    }
                }

                TLabel {
                    width: parent.width - 10
                    text: "重新实现bodyComponent ，可完成高级扩展!请参考 TPopoverMenu"
                    font.pixelSize: TPixelSizePreset.PH6
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            theme.className: tPopover.theme.className
            theme.groupName: tPopover.theme.groupName
            theme.state: tPopover.theme.state
            theme.childName: "body"
        }
    }

    TThemeBinder {
        id: tPopoverTheme
        className: "TPopover"

        property alias padding: tPopover.padding
        property alias bodyWidth: tPopover.bodyWidth

        Component.onCompleted: initialize()
    }
}
