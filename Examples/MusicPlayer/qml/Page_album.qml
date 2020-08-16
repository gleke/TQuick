import QtQuick 2.6
import TQuick 1.1
import "../database/mdata.js" as DATA

TRectangle {
    id:page

    property string albumName: root.global.openAlbumName

    property bool isEmpty: false

    property string a_date

    property string a_singer

    property string a_pic

    property alias subcontentLoader: subcontentLoader

    onIsEmptyChanged: subcontentLoader.reload()

    onAlbumNameChanged: {
        var alist = DATA.album
        for (var x in alist){
            var obj = alist[x]
            if(obj.title === albumName){
                a_date   = obj.date
                a_singer = obj.singer
                a_pic    = obj.pic
                isEmpty = false
                return
            }
        }

        isEmpty = true
        return
    }


    Item{
        id:topbar
        width: parent.width
        height: 250

        TRectangle{
            id:cdicon
            theme.enabled: false
            radius: 10
            color: "#D9D9D9"
            width: 200
            height: 200
            border.width: 1
            border.color: Qt.darker(color,1.1)
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: y

            TAvatar{
                source: a_pic
                anchors.fill: parent
                radius: parent.radius
                visible: !isEmpty
            }

            TSVGIcon{
                source: "qrc:/res/cd.svg"
                asynchronous: true
                color: "#FFF"
                width: parent.width - 50
                height: parent.height - 50
                anchors.centerIn: parent
                visible: isEmpty
            }
        }

        Column{
            anchors.left: cdicon.right
            anchors.right: parent.right
            anchors.top: cdicon.top
            anchors.bottom: cdicon.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 15
            anchors.bottomMargin: 5
            spacing: 15

            Row{
                width: parent.width
                height: 40
                spacing: 20
                TTag{
                    width: 40
                    height: 22
                    background.color: "#FEF0F0"
                    border.color: "#F56C6C"
                    label.color: "#F56C6C"
                    background.radius: height / 2
                    anchors.verticalCenter: parent.verticalCenter
                    label.text: "专辑"
                }

                TLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    text: page.albumName
                    font.pixelSize: 20
                    font.bold:true
                }

            }

            TLabel {
                text: "歌手：" + a_singer
            }
            TLabel {
                text: "时间：" + a_date
            }

            Row{
                width: parent.width
                height: 35
                spacing: 20

                Repeater{
                    model: [
                        {labeltxt:"播放全部",icon:TAwesomeType.FA_play_circle_o,prominent:true},
                        {labeltxt:"收藏", icon:TAwesomeType.FA_folder_o,prominent:false},
                        {labeltxt:"分享",icon:TAwesomeType.FA_share_square_o,prominent:false},
                        {labeltxt:"下载全部",icon:TAwesomeType.FA_cloud_download,prominent:false},
                    ]
                    delegate: TIconButton{
                        height: 35
                        padding: 50
                        icon.position: TPosition.Left
                        icon.source: modelData.icon
                        background.radius: height / 2
                        label.text: modelData.labeltxt
                        icon.color: label.color
                        label.color: modelData.prominent ? "#FFF" : "BLACK"
                        background.color: modelData.prominent ? "#d54f4a" : "#F3F3F3"
                    }
                }

            }
        }

    }

    //---

    TDividerLine{
        id:line
        anchors.top: navigationBar.bottom
        width: parent.width
        height: 1
        color: "#DCDCDC"
    }

    TNavigationBar{
        id:navigationBar
        anchors.top: topbar.bottom
        anchors.left:  parent.left
        anchors.right: parent.right
        anchors.leftMargin: 30
        anchors.rightMargin: 20

        spacing: 20
        height: 35

        TNavigationElement{
            text: "歌曲列表"
        }

        TNavigationElement{
            id:hot
            text: "评论"
        }

        TNavigationElement{
            text: "专辑详情"
        }

        children: [
            TRectangle{
                id:swimbar
                theme.enabled: false
                anchors.top: navigationBar.bottom
                width: navigationBar.currentItem.width
                x:navigationBar.currentItem.x
                height: 2
                color: "#D13C37"

                Behavior on x {
                    NumberAnimation {
                        easing.type: Easing.OutBack
                        duration: 100
                    }
                }

                Behavior on width {
                    NumberAnimation {
                        easing.type: Easing.OutBack
                        duration: 100
                    }
                }
            }
        ]

        onTriggered: {

        }
    }

    Loader{
        id:subcontentLoader
        anchors.top: line.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        clip: true

        property int element: navigationBar.currentIndex

        onElementChanged:reload()

        function reload(){
            sourceComponent = element > -1 ? show() : null
        }

        function show(){
            if(element === 0){
                return isEmpty ? musicListviewComponentEmpty : musicListviewComponent
            }

            if(element === 1){
                return isEmpty ? commentListComponent : commentListComponent
            }

            if(element === 2){
                return isEmpty ? supporterListComponent : supporterListComponent
            }

            return musicListviewComponentEmpty
        }
    }

    Component{
        id:musicListviewComponent

        Panel_musiclist{

        }
    }

    Component{
        id:musicListviewComponentEmpty
        Item{
            TLabel {
                id:info
                text: qsTr("该专辑没有收录任何曲目")
                font.pixelSize: 20
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -25
            }

            TLabel {
                text: qsTr("忙碌的现代人需要放松而听音乐就成了他们的首选方式之一")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: info.bottom
                anchors.topMargin: 12
            }
        }
    }


    Component{
        id:commentListComponent
        Item {
            TFlickable{
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                contentWidth: width
                contentHeight: commentsPanel.height
                scrollBar.horizontal: false

                Panel_comments{
                    id:commentsPanel
                    topMargen: 20
                    width: parent.width * 0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Component{
        id:supporterListComponent
        Item {

            TLabel {
                anchors.centerIn: parent
                text: qsTr("作者很懒，什么都没有写。")
            }
        }
    }

}
