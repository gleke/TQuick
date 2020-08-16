import QtQuick 2.0
import TQuick 1.1

TFlickable{
    id:page
    clip: true
    contentHeight:layout.implicitHeight
    scrollBar.horizontal: false

    Column{
        id:layout
        width: parent.width* 0.93
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 2
        Item{
            width: 20
            height: 20
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 400
            spacing: 20
            Column{
                width: 330
                spacing: 30
                TCarousel {
                    width: 330
                    height: 266

                    pathItemCount : 3
                    interval:  3000
                    itemWidth: 266
                    itemHeight: 266

                    TCarouselElement{
                        imageSource: "qrc:/res/fm0.png"
                    }

                    TCarouselElement{
                        imageSource: "qrc:/res/fm1.png"
                    }

                    TCarouselElement{
                        imageSource: "qrc:/res/fm2.png"
                    }

                    TCarouselElement{
                        imageSource: "qrc:/res/fm3.png"
                    }

                    TCarouselElement{
                        imageSource: "qrc:/res/fm4.png"
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    TIconButton{
                        background.radius: width/2
                        icon.type: TIconType.SVG
                        icon.position: TPosition.Only
                        icon.source: "qrc:/res/zan.svg"
                        icon.width:  25
                        icon.height: 25
                        background.color: "#FAFAFA"
                    }

                    TIconButton{
                        background.radius: width/2
                        icon.type: TIconType.SVG
                        icon.position: TPosition.Only
                        icon.source: "qrc:/res/xz.svg"
                        icon.width:  25
                        icon.height: 25
                        background.color: "#FAFAFA"
                    }

                    TIconButton{
                        background.radius: width/2
                        icon.type: TIconType.SVG
                        icon.position: TPosition.Only
                        icon.source: "qrc:/res/fx.svg"
                        icon.width:  25
                        icon.height: 25
                        background.color: "#FAFAFA"
                    }

                    TIconButton{
                        background.radius: width/2
                        icon.type: TIconType.SVG
                        icon.position: TPosition.Only
                        icon.source: "qrc:/res/pl.svg"
                        icon.width:  23
                        icon.height: 23
                        background.color: "#FAFAFA"
                    }
                }
            }

            Panel_lyrics{
                id:lyrics
                width: parent.width - 330 - parent.spacing
                //小伙伴们注意，这里非常重要防止滚动干扰上层滚动
                onInteractiveChanged: page.interactive = interactive
            }
        }

        TLabel{
            text: "听友评论"
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize:  TPixelSizePreset.PH5
            font.bold:true
        }



        Panel_comments{
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
        }

    }
}
