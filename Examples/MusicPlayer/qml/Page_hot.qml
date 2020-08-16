import QtQuick 2.0
import TQuick 1.1
import "../database/mdata.js" as DATA

TFlickable {
    clip: true
    contentHeight:layout.implicitHeight
    scrollBar.horizontal: false

    Column {
        id: layout
        spacing: 20
        width: parent.width* 0.93
        anchors.horizontalCenter: parent.horizontalCenter
        Item {
            width: 10
            height: 10
        }

        TLabel {
            text: "官方榜"
            font.pixelSize: TPixelSizePreset.PH3
        }

        Repeater {
            model: 4

            delegate:Row {
                spacing: 30
                width: parent.width
                height: 180
                TAvatar {
                    id: pic
                    radius: 5
                    width: 168
                    height: 168
                    source: "qrc:/res/hot_" + modelData + ".png"
                }

                Column{
                    width: parent.width - pic.width - parent.spacing
                    Repeater {
                        model: {
                            var list = []
                            for(var i = 0; i < 5; i++){
                                var r = Math.floor(Math.random() * DATA.music.length)
                                list.push(DATA.music[r])
                            }
                            return list
                        }

                        TRectangle{
                            width: parent.width
                            height: 33
                            color: index % 2 === 0 ? "#FAFAFA" : "#FFF"
                            theme.groupName: "musiclistbg"
                            theme.state: index % 2 === 0 ? "highlight" : "none"
                            Row{
                                anchors.fill: parent
                                Item{
                                    width: 35
                                    height: parent.height
                                    TLabel {
                                        text: (index + 1)
                                        anchors.centerIn: parent
                                        font.bold: index < 3
                                    }
                                }
                                Item{
                                    width: 15
                                    height: parent.height
                                    TAwesomeIcon{
                                        anchors.centerIn: parent
                                        property bool isup: Math.random() > 0.4
                                        source: isup ? TAwesomeType.FA_long_arrow_up : TAwesomeType.FA_long_arrow_down
                                        color:  isup ? "RED" : "GREEN"
                                        width:  10
                                        height: 10
                                    }
                                }
                                Item{
                                    width: parent.width - 160
                                    height: parent.height
                                    TIconButton{
                                        height: parent.height
                                        label.text: modelData.name
                                        contentHAlign: Qt.AlignLeft
                                        backgroundComponent: null
                                    }
                                }
                                Item{
                                    width: 110
                                    height: parent.height
                                    TIconButton{
                                        backgroundComponent: null
                                        anchors.centerIn: parent
                                        height: parent.height
                                        label.text: modelData.singer
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }

    }
}
