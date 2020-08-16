import QtQuick 2.6
import TQuick 1.1

Item{
    id: tInputField
    width: 160
    height: 38

    signal cleared()

    property bool clearable: true
    property int verticalMargin: 5
    property int horizontalMargin : verticalMargin + (background.radius >= height / 2 ? 10 : 5)
    property int placeholderPosition: TPosition.Center
    property int placeholderSpacing: 10
    property color cursorColor: "#000000"

    property alias placeholderLabel: mGadgetPlaceholderLabel
    property alias placeholderIcon:  mGadgetIcon
    property alias inputing: textInput.focus
    property alias clearIcon: mGadgetClearIcon
    property alias background: mGadgetBackground
    property alias border: mGadgetBorder
    property alias label: mGadgetLabel
    property alias theme: tInputFieldTheme
    property alias acceptableInput: textInput.acceptableInput
    property alias activeFocusOnPress: textInput.activeFocusOnPress
    property alias canPaste: textInput.canPaste
    property alias canRedo: textInput.canRedo
    property alias canUndo: textInput.canUndo
    property alias echoMode: textInput.echoMode
    property alias inputMask: textInput.inputMask
    property alias inputMethodComposing: textInput.inputMethodComposing
    property alias inputMethodHints: textInput.inputMethodHints
    property alias length: textInput.length
    property alias maximumLength: textInput.maximumLength
    property alias selectByMouse: textInput.selectByMouse
    property alias selectedText: textInput.selectedText
    property alias selectionEnd: textInput.selectionEnd
    property alias selectionStart: textInput.selectionStart
    property alias text: textInput.text
    property alias qtInput: textInput

    property Component cursorDelegate

    state: inputing ? "inputing" : ""

    clip: true
    TGadgetBackground {
        id: mGadgetBackground
        color: "#FCFCFC"
        radius: 2
    }

    TGadgetLabel {
        id: mGadgetPlaceholderLabel
        text: "TInputField"
        color: "#9D9D9D"
    }

    TGadgetLabel {
        id: mGadgetLabel
    }

    TGadgetIcon {
        id: mGadgetIcon
        color: "#9D9D9D"
    }

    TGadgetIcon {
        id: mGadgetClearIcon
        color: border.color
        width: 12
        height:12
        source: "qrc:/TQuick/resource/svg/close-px.svg"
    }

    TGadgetBorder {
        id: mGadgetBorder
        width: 1
        color: "#9D9D9D"
    }

    TRectangle {
        anchors.fill: parent
        border.width: mGadgetBorder.width
        border.color: mGadgetBorder.color
        color: mGadgetBackground.color
        radius: mGadgetBackground.radius
        opacity: mGadgetBackground.opacity

        theme.parent: tInputFieldTheme
        theme.childName: "background"
    }

    TObject {
        id: mPrivate
        property bool hold: textInput.focus || textInput.length > 0 || placeholderPosition === TPosition.Left
    }

    cursorDelegate:TDividerLine {
        id: cursor
        color: tInputField.cursorColor
        width: 1
        height: textInput.contentHeight
        visible: false
        Timer {
            interval: 500
            running: textInput.focus
            repeat: true
            onTriggered: cursor.visible = !cursor.visible
            onRunningChanged: !running ? cursor.visible = false : false
        }

        theme.parent: tInputFieldTheme
        theme.childName: "cursor"
    }

    TextInput {
        id: textInput
        clip: true
        anchors.fill: parent
        color: mGadgetLabel.color
        verticalAlignment: TextInput.AlignVCenter
        cursorDelegate: tInputField.cursorDelegate
        anchors.topMargin: tInputField.verticalMargin
        anchors.bottomMargin: tInputField.verticalMargin
        anchors.rightMargin: {
            if (clearable && clearIconButton.visible) {
                return clearIconButton.width
            }
            return tInputField.horizontalMargin
        }

        anchors.leftMargin: {
            if (mPrivate.hold) {
                return placeholder.leftPadding
            }
            return tInputField.horizontalMargin
        }

        Keys.onReleased: {
            textInput.focus = event.key !== Qt.Key_Escape
        }
    }

    Row {
        id: placeholder
        spacing: 4
        opacity: 0.7
        x: textInput.focus || textInput.length > 0 ? holdX : startX
        anchors.verticalCenter: parent.verticalCenter
        property int holdX: tInputField.horizontalMargin
        property int leftPadding: {
            if (!iconloader.visible && background.radius >= tInputField.height / 2) {
                return horizontalMargin
            }
            return iconloader.width + spacing / 2 + x
        }

        property int startX: {
            if (placeholderPosition !== TPosition.Left) {
                return (parent.width - width) / 2
            }
            return holdX
        }

        Loader {
            id: iconloader
            visible: sourceComponent !== null
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: {
                if (!mGadgetIcon.source) {
                    return null
                } else if (mGadgetIcon.type === TIconType.SVG || mGadgetIcon.source.indexOf(".svg") != -1) {
                    return svgComponent
                }
                return awesomeiconComponent
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: 100
                onRunningChanged: ptext.vout = running
            }
        }

        TLabel {
            id: ptext
            text: mGadgetPlaceholderLabel.text
            color: mGadgetPlaceholderLabel.color
            font.pixelSize: mGadgetPlaceholderLabel.font.pixelSize
            font.bold: mGadgetPlaceholderLabel.font.bold

            theme.parent: tInputFieldTheme
            theme.childName: "placeholder.label"

            property bool vout
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: {
                vout
                if (!vout && textInput.focus || textInput.length > 0) {
                    return -50
                }
                return 0
            }

            Behavior on anchors.verticalCenterOffset {
                NumberAnimation {
                    duration: 200
                }
            }
        }
    }

    TIconButton {
        id: clearIconButton
        backgroundComponent: null
        padding: 15
        takeFocus: false
        icon.position: TPosition.Only
        icon.width: mGadgetClearIcon.width
        icon.height: mGadgetClearIcon.height
        icon.color: mGadgetClearIcon.color
        icon.source: mGadgetClearIcon.source
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: clearable && textInput.length > 0

        theme.parent: tInputFieldTheme
        theme.childName: "clearButton"

        onClicked: {
            textInput.text = ""
        }
    }

    Component {
        id: awesomeiconComponent
        TAwesomeIcon {
            enabled: false
            theme.childName: "placeholder.icon"
            theme.parent: tInputFieldTheme

            source: mGadgetIcon.source
            color: mGadgetIcon.color
            width: mGadgetIcon.width
            height: mGadgetIcon.height
        }
    }

    Component {
        id: svgComponent
        TSVGIcon {
            enabled: false
            theme.childName: "placeholder.icon"
            theme.parent: tInputFieldTheme

            source: mGadgetIcon.source
            color: mGadgetIcon.color
            width: mGadgetIcon.width
            height: mGadgetIcon.height
        }
    }

    TThemeBinder {
        id: tInputFieldTheme
        className: "TInputField"
        state: tInputField.state

        property alias inputTextColor: textInput.color
        property alias width: tInputField.width
        property alias height: tInputField.height

        Component.onCompleted: initialize()
    }
}
