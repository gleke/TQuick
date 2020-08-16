import QtQuick 2.6
import TQuick 1.1

TRectangle {

    Item{
        id:titlebar
        width: parent.width
        height: 66

        TDividerLine{
            id:line
            width: parent.width
            height: 1
            color: "#ECECEC"
            anchors.bottom: parent.bottom
        }

        TIconButton{
            padding: 40
            height: 36
            icon.position: TPosition.Reght
            icon.source: TAwesomeType.FA_play_circle_o
            icon.color: "#FFF"
            label.text: "全部播放"
            label.color: "#FFF"
            background.radius: height / 2
            background.color: "#DD423C"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 40
        }

        TButton{
            backgroundComponent: null
            anchors.right: parent.right
            anchors.rightMargin: 40
            label.color: "#0E59D8"
            label.text: "打开本地目录"
            anchors.verticalCenter: parent.verticalCenter
            theme.enabled: false
        }
    }


    Panel_musiclist{
        anchors.top: titlebar.bottom
        anchors.bottom: parent.bottom
        width: parent.width * 0.99
        anchors.horizontalCenter: parent.horizontalCenter
    }


}
