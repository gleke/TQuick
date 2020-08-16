import QtQuick 2.0
import TQuick 1.1
import "../database/mdata.js" as DATA

TFlickable{
    clip: true
    contentHeight:layout.implicitHeight
    scrollBar.horizontal: false

    Column{
        id:layout
        property int currItemIndexRowA: 0
        property int currItemIndexRowB: 0
        property int currItemIndexRowC: 0
        width: parent.width* 0.93
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 12
        Item{
            width: 10
            height: 10
        }

        Row{
            width: parent.width
            spacing: 10
            height: 25
            TLabel{
                text:"语种："
                anchors.verticalCenter: parent.verticalCenter
            }

            Repeater {
                model: ["全部","华语","港台","日本","韩国","欧美","其它"]
                delegate: TButton{
                    height: parent.height
                    background.radius: height / 2
                    background.visible: layout.currItemIndexRowA === index
                    label.text: modelData
                    onClicked: layout.currItemIndexRowA = index
                }
            }
        }

        Row{
            spacing: 10
            height: 25
            TLabel{
                text:"分类："
                anchors.verticalCenter: parent.verticalCenter
            }

            Repeater{
                model: ["全部","男歌手","女歌手","乐队组合"]
                delegate: TButton{
                    height: parent.height
                    background.radius: height / 2
                    background.visible: layout.currItemIndexRowB === index
                    label.text: modelData
                    onClicked: layout.currItemIndexRowB = index
                }
            }
        }

        Grid{
            spacing: 8
            width: parent.width
            columns: (parent.width - 140) / 28
            TLabel{
                text:"筛选："
            }

            Repeater{
                model: ["#","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
                delegate: TButton{
                    width:  25
                    height: 25
                    background.radius: height / 2
                    background.visible: layout.currItemIndexRowC === index
                    label.text: modelData
                    onClicked: layout.currItemIndexRowC= index
                }
            }
        }

        Item {
            width: 10
            height: 10
        }

        Grid{
            anchors.horizontalCenter: parent.horizontalCenter
            width: columns * (134 + spacing)
            columns: parent.width / (134 + spacing)
            spacing: 10
            Repeater{
                model: DATA.singer

                delegate: Column{
                    width: 134
                    spacing: 4
                    TIconButton{
                        padding: 2
                        backgroundComponent: null
                        icon.position: TPosition.Top
                        iconComponent: TAvatar{
                            radius: 5
                            width: 134
                            height: 134
                            source: modelData.pic
                        }
                        label.text: modelData.name
                        onClicked: gotoSingerDatailPage(modelData.name)
                    }
                }
            }
        }
    }

}
