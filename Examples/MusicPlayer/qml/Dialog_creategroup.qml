import QtQuick 2.6
import TQuick 1.1

TDialog {
    titleText: "创建歌单"
    contentComponent: Item {
        width: 280
        height: 50
        property alias text: inputfield.text
        TInputField {
            id: inputfield
            width: parent.width - 20
            anchors.centerIn: parent
            placeholderLabel.text: "请输入歌单名称"
            placeholderPosition: TPosition.Left
        }
    }
}
