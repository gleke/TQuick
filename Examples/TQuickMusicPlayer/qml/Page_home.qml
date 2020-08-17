import QtQuick 2.6
import TQuick 1.2
import "../database/mdata.js" as D

TFlickable{
    clip: true
    id: page
    contentHeight:collayout.implicitHeight
    scrollBar.horizontal: false
    signal openMV()

    property var music_data: D.music
    property var album_data: D.album
    property var mv_data: D.mv

    Column{
        id: collayout
        anchors.fill: parent
        TCarousel{
            id: carousel
            width: parent.width
            height: 230

            itemWidth: 540
            itemHeight: 200

            TCarouselElement{
                imageSource: "qrc:/res/c0.png"
            }

            Component.onCompleted: {
                for (var i = 1; i < 6; i++) {
                    var obj = {}
                    obj.imageSource = "qrc:/res/c"+i+".png"
                    addElement(obj)
                }
            }

            onTriggered: {
                //console.log("circularIndex:",modelData.imageSource)
            }
        }


        TIconButton{
            icon.position: TPosition.Reght
            label.text: qsTr("Latest album")
            icon.source: TAwesomeType.FA_angle_right
            label.font.pixelSize: 16
            backgroundComponent: null
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            Repeater{
                model: 5
                Item{
                    id: rvitem
                    width:  page.width /5 - 20
                    height: width + 50
                    Column{
                        spacing: 8
                        TAvatar {
                            width: rvitem.width
                            height: rvitem.width
                            asynchronous: true
                            radius: 5
                            source: album_data[modelData].pic
                        }

                        TLabel{
                            id: labela
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: album_data[modelData].title
                        }
                    }

                    TMouseArea{
                        anchors.fill: parent
                        onClicked: contentPageLoader.openMusicAlbumPage(labela.text)
                    }
                }
            }
        }

        TIconButton {
            icon.position: TPosition.Left
            label.text: qsTr("Exclusive broadcast of MV")
            icon.source: TAwesomeType.FA_angle_right
            label.font.pixelSize: 16
            backgroundComponent: null
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            Repeater {
                model: 4
                Item {
                    id:rvitem3
                    width:  page.width /4 - 20
                    height: width - 20
                    Column {
                        spacing: 8
                        TAvatar {
                            width: rvitem3.width
                            height: rvitem3.width * 0.543
                            asynchronous: true
                            radius: 5
                            source: mv_data[modelData].pic
                        }

                        TLabel{
                            id: label
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: mv_data[modelData].title
                        }
                    }

                    TMouseArea{
                        anchors.fill: parent
                        onClicked: contentPageLoader.openMvPage(label.text)
                    }
                }
            }
        }

        Item{
            width: parent.width
            height: 40
            TIconButton{

                icon.position: TPosition.Reght
                label.text: qsTr("The latest single")
                label.font.pixelSize: 16
                icon.source: TAwesomeType.FA_angle_right
                backgroundComponent: null
            }

            TIconButton{
                anchors.rightMargin: 10
                anchors.right: parent.right
                icon.position: TPosition.Left
                label.text: qsTr("Play it all")
                icon.source: TAwesomeType.FA_music
                backgroundComponent: null
                onClicked: TToast.showMessage(qsTr("Music loading..."))
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12
            Column{
                spacing: 1

                Repeater{
                    model: 5
                    delegate: Loader{
                        sourceComponent: newSoundComponent
                        onItemChanged: item.index = modelData
                    }
                }

            }

            Column{
                spacing: 1

                Repeater{
                    model: 5
                    delegate: Loader{
                        sourceComponent: newSoundComponent
                        onItemChanged: item.index = modelData + 5
                    }
                }

            }
        }

        Item{
            width: parent.width
            height: 20
        }
    }



    Component{
        id: newSoundComponent
        Item{
            id: nsItem
            property int index: 0
            width: (page.width - 40) / 2
            height: 90

            TMouseArea{
                id: content
                width: nsItem.width - 6
                height: nsItem.height - 12
                anchors.centerIn: parent
                hoverEnabled: true
                TRectangle{
                    theme.groupName: "newsoundbg"
                    color: "#F5F5F5"
                    anchors.fill: parent
                    visible: content.state === "hovering"
                }

                TAvatar {
                    id: img
                    width: 60
                    height: 60
                    radius: 4
                    source: music_data[index].pic
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20

                    TIconButton{
                        anchors.centerIn: parent
                        icon.position:TPosition.Only
                        icon.color: "#FFF"
                        icon.source: TAwesomeType.FA_play
                        backgroundComponent: Rectangle {
                            color: "#5D5D5D"
                            opacity: 0.5
                            radius: width /2
                        }
                        visible: content.state === "hovering"
                    }
                }

                Column{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: img.right
                    anchors.leftMargin: 20
                    width: parent.width
                    spacing: 10
                    TLabel{
                        text: music_data[index].name + " - " + music_data[index].singer
                    }

                    TLabel{
                        text: music_data[index].intro
                        font.pixelSize: 12
                        opacity: 0.5
                    }
                }


                TImage{
                    source: "qrc:/res/sq_play.png"
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    theme.enabled: false
                    width: 30
                    height: 15
                    visible: Math.random() > 0.40
                }

            }

            TDividerLine{
                width: parent.width
                height: 1
                visible: index !== 4 && index !== 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -1
                color: "#E8E8E8"
            }
        }
    }

}


