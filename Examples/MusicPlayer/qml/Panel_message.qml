import QtQuick 2.0
import TQuick 1.1
import "../database/mdata.js" as DATA

TPopup {
    id:popup
    property int width: 300
    property int height: 500
    property int x: 0
    property int y: 0
    backgroundComponent: null
    onTriggeredBackground: close()

    onOpened: {
        body.x = popup.x
    }

    onCloseed: {
        body.x = popup.x
    }

    TRectangle{
        id:body
        width:  popup.width
        height: popup.height
        y:popup.y
        x:popup.x + body.width
        clip: true
        onHeightChanged: close()

        TDividerLine {
            width: 1
            height: parent.height
            anchors.left: parent.left
        }

        TNavigationBar {
            id: nbar
            anchors.horizontalCenter: parent.horizontalCenter
            TNavigationElement {
                text: "私信"
            }
            TNavigationElement {
                text: "评论"
            }
            TNavigationElement {
                text: "@我"
            }
            TNavigationElement {
                text: "通知"
            }
        }

        Column{
            width: parent.width
            anchors.top: nbar.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            spacing: 20

            Repeater{
                id:rep
                model: ListModel{}
                delegate: Item{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width* 0.9
                    height:layout.height
                    TDividerLine{
                        anchors.bottom: parent.bottom
                        height: 1
                        width: parent.width
                    }

                    TAvatar{
                        id:pic
                        width: 40
                        height: 40
                        radius: 20
                        anchors.top: parent.top
                        source: "qrc:/res/portrait/" + Math.ceil(Math.random() * 40) + ".jpg"
                    }

                    Column{
                        id:layout
                        width: parent.width - pic.width - 10
                        anchors.right: parent.right
                        spacing: 5

                        TLabel{
                            width: parent.width
                            wrapMode: Text.WordWrap
                            text:"<b>" + user + ":  </b>" + ctext
                        }

                        Item{
                            width: parent.width
                            height: 35
                            TLabel{
                                text: "2020年12月1日"
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            TButton{
                                label.text: "回复"
                                backgroundComponent: null
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                            }
                        }
                    }
                }

                Component.onCompleted: {
                    for(var i in DATA.comments){
                        if(Math.random() > 0.8){
                            rep.model.append(DATA.comments[i])
                        }
                    }
                }
            }
        }

    }
}
