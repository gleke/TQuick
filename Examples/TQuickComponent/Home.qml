import QtQuick 2.6
import TQuick 1.2

Item {

    Column{
        spacing: 30
        anchors.centerIn: parent
        TLabel{
            text: "Hello TQuick"
            font.pixelSize: 30
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TButton{
            width: 150
            label.text: "Show time"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: begin()
        }
    }

}
