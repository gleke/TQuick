import QtQuick 2.6
import TQuick 1.2

TRectangle {

    TRectangle{

        width: parent.width
        height: 50
        color: "#FDFDFD"

        TRectangle{
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
            color: "#EDEDED"
        }

        TLabel{
            text: qsTr("News of netizens")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 22
        }

        TIconButton{
            height: 32
            anchors.right: parent.right
            anchors.rightMargin: 22
            anchors.verticalCenter: parent.verticalCenter
            icon.source: TAwesomeType.FA_edit
            icon.position: TPosition.Left
            label.text: qsTr("Let's talk about it")
        }
    }

    ListView{
        id: listview
        anchors.fill: parent

        model: ListModel{

        }

        delegate: Item{

        }
    }


    TScrollbarV{
        target: listview
    }

}
