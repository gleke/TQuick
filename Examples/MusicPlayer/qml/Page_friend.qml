import QtQuick 2.6
import TQuick 1.1

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
            text: "网友动态"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 22
        }

        TIconButton{
            anchors.right: parent.right
            anchors.rightMargin: 22
            anchors.verticalCenter: parent.verticalCenter
            height: 32
            icon.source: TAwesomeType.FA_edit
            label.text: "发表说说"
            icon.position: TPosition.Left
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
