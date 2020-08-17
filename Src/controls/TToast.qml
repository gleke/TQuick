pragma Singleton
import QtQuick 2.6
import TQuick 1.2

/*!
    TToast.showSuccess(text,duration,moremsg)
    TToast.showInfo(text,duration,moremsg)
    TToast.showWarning(text,duration,moremsg)
    TToast.showError(text,duration,moremsg)
    TToast.showCustom(itemcomponent,duration)

*/

TObject {
    id: tToast

    property int layoutY: 75

    /*! duration = TTimePreset */
    function showSuccess(text,duration,moremsg) {
        mControl.create(mControl.const_success,text,duration,moremsg ? moremsg : "")
    }

    function showInfo(text,duration,moremsg) {
        mControl.create(mControl.const_info,text,duration,moremsg ? moremsg : "")
    }

    function showWarning(text,duration,moremsg) {
        mControl.create(mControl.const_warning,text,duration,moremsg ? moremsg : "")
    }

    function showError(text,duration,moremsg) {
        mControl.create(mControl.const_error,text,duration,moremsg ? moremsg : "")
    }

    function showCustom(itemcomponent,duration) {
        mControl.createCustom(itemcomponent,duration)
    }

    TObject {
        id: mControl

        property var root_window: rootWindow
        property var screenLayout: null
        property string const_success: "success"
        property string const_info: "info"
        property string const_warning: "warning"
        property string const_error: "error"
        property int maxWidth: 300

        function create(type, text, duration, moremsg) {
            if(screenLayout) {
                var last = screenLayout.getLastloader()
                if (last.type === type && last.text === text && moremsg === last.moremsg) {
                    last.restart()
                    return
                }
            }

            initScreenLayout()
            contentComponent.createObject(screenLayout, {
                                              type:type,
                                              text:text,
                                              duration:duration,
                                              moremsg:moremsg,
                                          })
        }

        function createCustom(itemcomponent,duration) {
            initScreenLayout()
            if (itemcomponent) {
                contentComponent.createObject(screenLayout, {itemcomponent:itemcomponent, duration:duration})
            }
        }

        function initScreenLayout() {
            if (screenLayout == null) {
                screenLayout = screenlayoutComponent.createObject(root_window)
                screenLayout.y = tToast.layoutY
                screenLayout.z = 100000
            }
        }

        Component {
            id: screenlayoutComponent
            Column {
                spacing: 20
                width: parent.width
                move: Transition {
                    NumberAnimation {
                        properties: "y"
                        easing.type: Easing.OutBack
                        duration: 300
                    }
                }

                onChildrenChanged: {
                    if (children.length === 0)  {
                        destroy()
                    }
                }
                function getLastloader() {
                    if (children.length > 0) {
                        return children[children.length - 1]
                    }
                    return null
                }
            }
        }

        Component {
            id: contentComponent
            Item {
                id: content
                property int duration: TTimePreset.ShortTime2s
                property var itemComponent
                property string type
                property string text
                property string moreMsg

                width: parent.width
                height: loader.height

                function close() {
                    content.destroy()
                }

                function restart() {
                    delayTimer.restart()
                }

                Timer {
                    id: delayTimer
                    interval: duration
                    running: true
                    repeat: true
                    onTriggered: content.close()
                }

                Loader {
                    id: loader
                    x: (parent.width - width) / 2
                    property var _super: content

                    scale: item ? 1 : 0
                    asynchronous: true

                    Behavior on scale {
                        NumberAnimation {
                            easing.type: Easing.OutBack
                            duration: 100
                        }
                    }

                    sourceComponent: itemComponent ? itemComponent : mControl.tMessageSytle
                }

            }
        }

        // -- TQuick TMessage style
        property Component tMessageSytle: TRectangle {
            id: rect
            width: rowlayout.width  + (_super.moremsg ? 25 : 80)
            height: rowlayout.height + 20
            color: {
                switch(_super.type) {
                    case mControl.const_success:
                    return "#F0F9EB"
                    case mControl.const_warning:
                    return "#FDF6ED"
                    case mControl.const_info:
                    return "#EDF2FC"
                    case mControl.const_error:
                    return "#FEF0F0"
                }
                return "#FFFFFF"
            }
            radius: 4
            border.width: 1
            border.color: Qt.lighter(tSVGIcon.color, 1.2)

            theme.parent: mToastTheme
            theme.groupName: _super.type
            theme.childName: "background"

            Row {
                id: rowlayout
                x: 20
                y: (parent.height - height) / 2
                spacing: 10
                TSVGIcon {
                    id: tSVGIcon
                    theme.parent: mToastTheme
                    theme.groupName: rect.theme.groupName
                    theme.childName: "content"

                    anchors.verticalCenter: parent.verticalCenter
                    source: {
                        switch(_super.type) {
                            case mControl.const_success:
                            return "qrc:/TQuick/resource/svg/success.svg"
                            case mControl.const_warning:
                            return "qrc:/TQuick/resource/svg/warning.svg"
                            case mControl.const_info:
                            return "qrc:/TQuick/resource/svg/info.svg"
                            case mControl.const_error:
                            return "qrc:/TQuick/resource/svg/error.svg"
                        }
                        return "#FFFFFF"
                    }

                    width: more.visible ? 40 : 22
                    height: more.visible ? 40 : 22

                    color: {
                        switch(_super.type) {
                            case mControl.const_success:
                            return "#6AC044"
                            case mControl.const_warning:
                            return "#E4A147"
                            case mControl.const_info:
                            return "#909399"
                            case mControl.const_error:
                            return "#F36D6F"
                        }
                        return "#FFFFFF"
                    }
                }

                Column {
                    spacing: 5
                    TLabel {
                        theme.parent: mToastTheme
                        theme.groupName: rect.theme.groupName

                        font.bold: more.visible
                        font.pixelSize: 20
                        text: _super.text
                        color: tSVGIcon.color
                    }

                    TLabel {
                        id: more
                        theme.parent: mToastTheme
                        theme.groupName: rect.theme.groupName

                        color: tSVGIcon.color
                        text: _super.moreMsg
                        visible: _super.moreMsg
                        wrapMode: Text.WordWrap

                        onContentWidthChanged: {
                            width = contentWidth < mControl.maxWidth - 100 ? 220 : mControl.maxWidth
                        }
                    }
                }
            }

            TIconButton {
                theme.parent: mToastTheme
                theme.childName: "closeButton"
                icon.width: 12
                icon.height: 12
                y: 4
                x: parent.width - width
                icon.type: TIconType.SVG
                icon.position: TPosition.Only
                icon.source: "qrc:/TQuick/resource/svg/close-px.svg"
                icon.color:"#ADADAD"
                backgroundComponent: null
                onClicked: _super.close()
            }

        }
        //style....end
    }

    TThemeBinder {
        id: mToastTheme
        className: "TToast"

        Component.onCompleted: initialize()
    }

}
