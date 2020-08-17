import QtQuick 2.6
import TQuick 1.2
import "../database/mdata.js" as DATA

TFlickable{
    scrollBar.horizontal: false
    scrollBar.autoHide: false
    contentWidth:width
    contentHeight: col.height
    Column{
        id:col
        width: parent.width
        Repeater{
            id:rep
            model: ListModel{}

            Component.onCompleted: {
                var titleobj = {}
                titleobj.istitle = true
                titleobj.name = "歌曲名称"
                titleobj.singer = "歌手"
                titleobj.album = "专辑"
                titleobj.duration = "时长"
                model.append(titleobj)

                var d = DATA.music
                for(var x in d){
                    var itemobj =  d[x]
                    itemobj.index = x + 1
                    itemobj.istitle = false
                    model.append(itemobj)
                }
            }


            delegate:  Item{
                width: col.width
                height: 35

                TRectangle{
                    theme.groupName: "musiclistbg"
                    anchors.fill: parent
                    color:  index %2 === 0 ? "#F8F8F8":"#FEFEFE"
                    state:  index %2 === 0 ? "none":"highlight"
                }

                Row{
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height
                    Item{
                        width: parent.width * 0.06
                        height: parent.height
                        TLabel {
                            visible: index !=0
                            text: index
                            anchors.centerIn: parent
                        }
                    }

                    Item{
                        width: parent.width * 0.06
                        height:  parent.height

                        TIconButton{
                            height: parent.height
                            theme.groupName: "musiclistheart"
                            anchors.centerIn: parent
                            property bool islike: Math.random() > 0.5 ? true :  false
                            visible: index !=0
                            backgroundComponent: null
                            icon.width: 10
                            icon.height: 10
                            icon.position: TPosition.Only
                            icon.source: islike ? TAwesomeType.FA_heart_o :  TAwesomeType.FA_heart
                            onClicked: islike = !islike
                            enabled: !istitle
                        }
                    }

                    Item{
                        width: parent.width * 0.35
                        height:  parent.height

                        TButton{
                            id:nametxt
                            height: parent.height
                            label.text: name
                            label.font.bold: istitle
                            contentHAlign: Qt.AlignLeft
                            backgroundComponent: null
                        }

                        TImage{
                            anchors.verticalCenter: parent.verticalCenter
                            source: "qrc:/res/sq_play.png"
                            anchors.left:nametxt.right
                            anchors.leftMargin: 15
                            theme.enabled: false
                            width: 22
                            height: 10
                            visible: Math.random() > 0.40 && index !== 0
                        }
                    }

                    Item{
                        width: parent.width * 0.17
                        height: parent.height
                        TButton{
                            height: parent.height
                            label.text: singer
                            contentHAlign:Qt.AlignLeft
                            backgroundComponent:null
                            label.font.bold: istitle
                            enabled: !istitle
                            onClicked: contentPageLoader.gotoSingerDatailPage(singer)
                        }
                    }

                    Item{
                        width: parent.width * 0.27
                        height: parent.height
                        TButton{
                            height: parent.height
                            label.text: album
                            label.font.bold: istitle
                            contentHAlign: Qt.AlignLeft
                            backgroundComponent: null
                            enabled: !istitle
                            onClicked: contentPageLoader.openMusicAlbumPage(album)
                        }
                    }
                    Item{
                        width: parent.width * 0.05
                        height: parent.height
                        TLabel {
                            anchors.centerIn: parent
                            font.bold: istitle
                            text:  duration
                        }
                    }
                }
            }
        }
    }
}
