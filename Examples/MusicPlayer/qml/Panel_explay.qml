import QtQuick 2.6
import TQuick 1.1
import "../database/parserLrc.js" as LRC

Item {

    TRectangle{
        anchors.fill: parent
        opacity: 0.98
        color: "#F7F7F7"
        MouseArea{
            anchors.fill: parent
            onWheel: {

            }
        }
    }


    Row{
        width: 920
        height: 500
        anchors.centerIn: parent
        spacing: 30
        Item{
            width: parent.width / 2 - 20
            height: parent.height


            TAvatar {
                id:cd
                radius: width / 2
                source: "qrc:/res/cb_bg.png"
                border.width: 10
                border.color: "#dcdcdc"
                anchors.centerIn: parent
                theme.groupName: "cdbg"
                anchors.verticalCenterOffset:  -30


                TAvatar{
                    asynchronous: true
                    source: "qrc:/res/h1.png"
                    width: 200
                    height: 200
                    radius: 100
                    anchors.centerIn: parent
                }
            }

            Row{
                height: 45
                anchors.top:cd.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30

                TIconButton{
                    background.radius: width/2
                    icon.type: TIconType.SVG
                    icon.position: TPosition.Only
                    icon.source: "qrc:/res/zan.svg"
                    icon.width: 25
                    icon.height: 25
                    background.color: "#FAFAFA"
                }

                TIconButton{
                    background.radius: width/2
                    icon.type: TIconType.SVG
                    icon.position: TPosition.Only
                    icon.source: "qrc:/res/xz.svg"
                    icon.width: 25
                    icon.height: 25
                    background.color: "#FAFAFA"
                }

                TIconButton{
                    background.radius: width/2
                    icon.type: TIconType.SVG
                    icon.position: TPosition.Only
                    icon.source: "qrc:/res/fx.svg"
                    icon.width: 25
                    icon.height: 25
                    background.color: "#FAFAFA"
                }

                TIconButton{
                    background.radius: width/2
                    icon.type: TIconType.SVG
                    icon.position: TPosition.Only
                    icon.source: "qrc:/res/pl.svg"
                    icon.width: 23
                    icon.height: 23
                    background.color: "#FAFAFA"
                }
            }
        }

        Panel_lyrics{

        }

    }

}
