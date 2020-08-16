import QtQuick 2.6
import TQuick 1.1

TObject {
    id: tDialogBasic

    signal opened()
    signal closed()

    property bool modalclose: true

    property Component bodyComponent

    function open() {
        mPrivate.create()
    }

    function hideAndClose() {
        mPrivate.hideAndClose()
    }

    function close() {
        mPrivate.close()
    }

    TObject {
        id: mPrivate
        property var popupbg

        function create() {
            popupbg = fullPopupComponent.createObject(rootWindow)
            popupbg.open()
            popupbg.show = true
        }

        function hideAndClose() {
            if (popupbg) {
                popupbg.show = false
                popupbg.hide(true)
            }
        }

        function close() {
            if (popupbg) {
                popupbg.close()
            }
        }

        Component {
            id: fullPopupComponent

            TPopup {
                property bool show: false

                Item {
                    id: fullPopupComponentBody
                    property double oy: show ? 0 : -80
                    width: windowLoader.width
                    height: windowLoader.height
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: oy
                    scale: show ? 1 : 0
                    opacity: show ? 1 : 0

                    Behavior on scale {
                        NumberAnimation {
                            easing.type: Easing.OutBack
                            duration: 300
                        }
                    }

                    Behavior on oy {
                        NumberAnimation {
                            easing.type: Easing.OutBack
                            duration: 500
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                    }

                    Loader {
                        id: windowLoader
                        sourceComponent: bodyComponent
                    }
                }

                onTriggeredBackground: {
                    if (modalclose) {
                        show = false
                        hide(true)
                        closed()
                    }
                }
            }
        }
    }

    bodyComponent: TRectangle {
        id: tDialogBasicBody
        theme.parent: tDialogBasicTheme
        width: 240
        height: tDialogBasicBodyColumn.height + 20
        border.width: 1
        border.color: "#DCDCDC"
        color: "#FFF"
        radius: 4

        Column {
            id: tDialogBasicBodyColumn
            width: parent.width - 10
            anchors.centerIn: parent
            TLabel {
                text: "Dialog 基础控件"
                theme.parent: tDialogBasicTheme
            }

            TLabel {
                width: parent.width - 10
                wrapMode: Text.WordWrap
                theme.parent: tDialogBasicTheme
                text: "重新定义bodyComponent，可实现更高级的扩展。请参考TDialog\n点击模态背景可关闭。"
            }
        }
    }

    TThemeBinder {
        id: tDialogBasicTheme
        className: "TDialogBasic"

        Component.onCompleted: initialize()
    }
}
