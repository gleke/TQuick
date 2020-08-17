import QtQuick 2.0
import TQuick 1.2

TDialog {

    bodyComponent: TRectangle{
        width:  layout.width  + 80
        height: layout.height + 80
        radius: 5

        Column{
            id:layout
            spacing: 5
            anchors.centerIn: parent

            TLabel{
                text: "TQuick"
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TLabel{
                text: TQuick.version()
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item{
                width: 10
                height: 20
            }

            TLabel{
                text: "基于Qt(Quick)跨平台技术和github开源项目Toou-2d开发的QML框架"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

}
