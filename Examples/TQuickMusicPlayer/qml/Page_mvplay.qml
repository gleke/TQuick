import QtQuick 2.6
import TQuick 1.2
import "../database/mdata.js" as DATA

TRectangle {
    id: page
    clip: true
    TFlickable{
        width: parent.width
        height: parent.height

        contentWidth: width
        contentHeight:collayout.height
        scrollBar.horizontal: false


        Column{
            id:collayout
            spacing: 13
            width: parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            Item{
                width: parent.width
                height: 20
            }

            TAvatar {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/res/mvbg.png"
                radius: 10

                TAwesomeIcon{
                    source: TAwesomeType.FA_circle_o_notch
                    width: 30
                    height: 30
                    color: "#DCDCDC"
                    anchors.centerIn: parent
                    NumberAnimation on rotation {
                        from:0
                        to: 360
                        duration: 800
                        loops: Animation.Infinite
                    }
                }


                Item {
                    width: parent.width - 30
                    height: 40
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    TRectangle{
                        theme.enabled: false
                        radius: 10
                        opacity: 0.2
                        width: parent.width
                        height: parent.height
                    }


                    TLabel{
                        theme.enabled: false
                        text: "00:00 / 03:12"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        color: "#fff"
                    }

                    TLabel{
                        theme.enabled: false
                        text: qsTr("超清")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right:  fullicon.left
                        anchors.rightMargin: 20
                        color: "#fff"
                    }

                    TAwesomeIcon{
                        id:fullicon
                        source: TAwesomeType.FA_arrows_alt
                        theme.enabled: false
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right:  parent.right
                        anchors.rightMargin: 30
                        color: "#fff"
                    }
                }

            }

            Item {
                width: 10
                height: 10
            }

            Item{
                width: parent.width
                height: 40
                TLabel{
                    text: root.global.openmvName
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 22
                    font.bold: true
                }

                TIconButton{
                    width: 120
                    icon.position: TPosition.Left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: TAwesomeType.FA_plus_square_o
                    label.text: qsTr("关注")
                    height: 35
                    background.color: "#FFF"
                    background.radius: width/2
                    border.width: 1
                    border.color: "#DCDCDC"
                }
            }

            TLabel{
                text: qsTr("Released on August 14, 2019 number of broadcasts: 230000")
            }

            Row{
                id: rowlayout
                spacing: 20
                height: 30
                property var allList: [
                    qsTr("Make complaints"),
                    qsTr("Life"),
                    qsTr("Shaking legs fresh"),
                    qsTr("Unlimited technology"),
                    qsTr("Dynamic"),
                    qsTr("Mysterious"),
                    qsTr("Polular science"),
                    qsTr("Small and fresh life"),
                    qsTr("DJ")
                ]
                Repeater {
                    model: {
                        var list = []
                        for(var i in rowlayout.allList){
                            if(Math.random() > 0.5){
                                list.push(rowlayout.allList[i])
                            }
                        }

                        return list
                    }

                    delegate: TTag{
                        theme.groupName: "mv"
                        height: 24
                        background.radius: height / 2
                        label.text: modelData
                        background.color: "#FCFCFC"
                        label.color: "#8d8d8d"
                    }
                }
            }

            Panel_comments {
                id: commentListview
            }

            Item{
                width: height
                height: 10
            }

        }
    }
}
