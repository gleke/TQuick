import QtQuick 2.6
import TQuick 1.2

TDialog {
    titleText: qsTr("Create song list")
    contentComponent: Item {
        width: 280
        height: 50
        property alias text: inputfield.text
        TInputField {
            id: inputfield
            width: parent.width - 20
            anchors.centerIn: parent
            placeholderPosition: TPosition.Left
            placeholderLabel.text: qsTr("Please enter the name of the song list")
        }
    }
}
