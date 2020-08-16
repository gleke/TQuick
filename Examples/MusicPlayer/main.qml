import QtQuick 2.6
import QtQuick.Window 2.3
import TQuick 1.1
import "./database/mdata.js" as D
import "./qml" as Q

Window {
    id: root
    visible: true
    title: "Music player by TQuick - FPS:" + fps.fpsAvg + "," + fps.fps
    width: 990
    height: 630 + 30
    minimumWidth: 990
    minimumHeight: 630 + 30

    TQuickWorld {
        generateThemeTemplateEnable: true
        mouseAreaCursorShape: Qt.PointingHandCursor
    }

    TFpsMonitor{
        id: fps
        contentItem: null
    }

    property alias loginDialog: loginDialog
    property alias player: player

    //存储Demo全局变量，与TQuick配置无关。
    property TObject global: TObject {
        property string openGroupName
        property string userName
        property string openmvName
        property string openAlbumName
        property string openSignerName

        property var explayPanel: null
    }

    Q.MediaPlayer {
        id: player
    }

    TRectangle {
        id: topbar
        width: parent.width
        height: 50
        color: "#D54F4A"
        theme.groupName: "topbar"

        TMouseArea {
            anchors.fill: parent
            cursorShape: Qt.ArrowCursor
            hoverEnabled: false
        }

        TIconButton{
            id: logo
            theme.groupName: "logo"
            icon.position: TPosition.Left
            icon.source: TAwesomeType.FA_meetup
            icon.width: icon.height
            icon.height: 25
            icon.color: label.color

            label.text: "TQuick 音乐"
            label.color: "#FFF"
            label.font.pixelSize: 16
            label.font.bold: true

            backgroundComponent: null

            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            anchors.left: parent.left
        }


        TNavigationBar {
            id: nbar
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:logo.right
            anchors.leftMargin: 30
            spacing: 18
            height: parent.height

            label.color: "#FFF"
            activeLabel.color: "#FFF"

            TNavigationElement {
                text: "个性推荐"
                otherData: "c_0"
            }

            TNavigationElement {
                id: hot
                text: "排行榜"
                otherData: "c_2"
            }

            TNavigationElement {
                text: "电台"
                otherData: "c_3"
            }

            TNavigationElement {
                text: "歌手"
                otherData: ""
            }

            onTriggered: {
                switch(modelData.text){
                case "个性推荐": contentPageLoader.openHomPage()
                    break
                case "歌手": contentPageLoader.openSingerPage()
                    break
                case "排行榜": contentPageLoader.openHotPage()
                    break
                case "电台": contentPageLoader.openFmPage()
                    break
                case "歌手": contentPageLoader.openSingerPage()
                    break
                }
                leftbar.curActiveTag = modelData.otherData
            }

        }

        Row{
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            TInputField{
                background.radius: 15
                width: 180
                placeholderIcon.source: TAwesomeType.FA_search
                placeholderLabel.text: "搜索"
                placeholderLabel.color: "#FAFAFA"
                placeholderIcon.color: "#FAFAFA"
                background.color: "#DB6965"
                label.color: "#FFF"
                cursorColor:label.color
                border.width: 0
                height: 28
            }

            Item{
                width: 25
            }

            TIconButton{
                padding: 12
                hoverEnabled: true
                theme.groupName: "topicon"
                icon.position: TPosition.Only
                icon.source: TAwesomeType.FA_envelope_o
                icon.width: icon.height
                icon.height: 18
                icon.color: "#FFF"
                border.width: 0
                background.radius: width / 2
                background.color: "#C84A46"
                background.visible: state === "hovering" || state === "pressed"
                scale: state === "pressed" ? 1.1 : 1
                onClicked: messagebar.open()
            }

            TIconButton{
                id: skinbtn
                padding: 12
                theme.groupName: "topicon"
                hoverEnabled: true
                icon.position: TPosition.Only
                icon.type: TIconType.SVG
                icon.source: "qrc:/res/skin.svg"
                icon.width: icon.height
                icon.height: 18
                icon.color: "#FFF"
                border.width: 0
                background.radius: width / 2
                background.color: "#C84A46"
                background.visible: state === "hovering" || state === "pressed"
                scale: state === "pressed" ? 1.1 : 1
                onClicked: themePopover.openToGlobal(skinbtn,0,50)
            }

            TIconButton{
                padding: 12
                theme.groupName: "topicon"
                hoverEnabled: true
                icon.position: TPosition.Only
                icon.source: TAwesomeType.FA_question_circle_o
                icon.width: icon.height
                icon.height: 18
                icon.color: "#FFF"
                border.width: 0
                background.radius: width / 2
                background.color: "#C84A46"
                background.visible: state === "hovering" || state === "pressed"
                scale: state === "pressed" ? 1.1 : 1
                onClicked: dialog_about.open()
            }
        }
    }

    TRectangle{
        id: leftbar
        anchors.top: topbar.bottom
        width: 200
        height: parent.height
        color: "#ededed"
        theme.groupName: "leftbar"
        property string curActiveTag: "c_0"

        property ListModel groupModel: ListModel{
            ListElement{
                labeltxt:"我喜欢的音乐"
            }
            ListElement{
                labeltxt:"抖音最火大全"
            }
            ListElement{
                labeltxt:"KTV必唱"
            }
        }

        Column{
            id: btns
            width: parent.width
            TIconButton{
                spacing: 16
                icon.position: TPosition.Top
                anchors.horizontalCenter: parent.horizontalCenter
                backgroundComponent : null
                iconComponent : TRectangle{
                    id: iconcontent
                    width: 50
                    height: 50
                    radius: 25
                    color: "#E0E0E0"
                    border.width: 1
                    border.color: "#BCBCBC"
                    TSVGIcon {
                        width: parent.width - 20
                        height: parent.height - 20
                        anchors.centerIn: parent
                        source: "qrc:/res/icportrait.svg"
                        color: "#FFF"
                    }

                    TAvatar {
                        width: parent.width
                        height: parent.height
                        radius: width / 2
                        source: "qrc:/res/portrait/35.jpg"
                        border.width: 1
                        border.color: "#BCBCBC"
                        visible: global.userName
                    }
                }
                theme.filterPropertyName: ["label.text"]
                label.text: root.global.userName ? root.global.userName : "登陆TQuick音乐"
                onClicked: loginDialog.open()
            }

            TDividerLine{
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#dfdfdf"
                width: parent.width * 0.9
                height: 1
            }

            Item {
                width: parent.width
                height: 15
            }

            Column{
                width: parent.width * 0.9
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Repeater{
                    id: rep
                    model:  [
                        {label:"发现音乐",icon:TAwesomeType.FA_music/*,fun:function*/},
                        {label:"视频",icon:TAwesomeType.FA_file_video_o},
                        {label:"排行",icon:TAwesomeType.FA_bar_chart_o},
                        {label:"私人FM",icon:TAwesomeType.FA_podcast},
                        {label:"本地歌曲",icon:TAwesomeType.FA_download}
                    ]

                    delegate: TIconButton{
                        theme.groupName:  "leftbutton"
                        property string tag: "c_" + index
                        icon.position: TPosition.Left
                        label.text: modelData.label
                        width: parent.width
                        icon.source: modelData.icon
                        contentHAlign: Qt.AlignLeft
                        height: 32
                        background.visible:  leftbar.curActiveTag === tag
                        stateEnabled: false
                        state: leftbar.curActiveTag === tag ? "active" : "normal"
                        onClicked:{
                            leftbar.curActiveTag = tag
                            switch(index){
                            case 0: contentPageLoader.openHomPage()
                                break
                            case 1: contentPageLoader.openMvPage("今日推荐：一场游戏一场梦 - 王杰")
                                break
                            case 2: contentPageLoader.openHotPage()
                                break
                            case 3: contentPageLoader.openFmPage()
                                break
                            case 4: contentPageLoader.openDownloadPage()
                                break
                            case 5: contentPageLoader.openSingerPage()
                                break
                            }

                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 10
            }

            Item{

                width: parent.width
                height: 30
                TLabel{
                    text: "我的歌单"
                    x:20
                    anchors.verticalCenter: parent.verticalCenter
                }

                TIconButton{
                    padding: 5
                    icon.position: TPosition.Only
                    icon.source: TAwesomeType.FA_plus_square_o
                    backgroundComponent: null
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: newGroupDialog.open({"title":"取一个名字很难吗？"})
                }
            }

        }

        ListView{
            id: lv
            anchors.top: btns.bottom
            anchors.bottom: parent.bottom
            width: parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            model: leftbar.groupModel

            delegate:TIconButton{
                property string tag: "g_" + labeltxt
                theme.groupName: "leftbutton"
                icon.position: TPosition.Left
                label.text: labeltxt
                width: lv.width
                icon.source: TAwesomeType.FA_circle
                icon.width: 5
                icon.height: 5
                contentHAlign: Qt.AlignLeft
                background.visible:  leftbar.curActiveTag === tag
                state: leftbar.curActiveTag === tag ? "active" : "normal"
                stateEnabled: false
                height: 32
                onClicked:{
                    leftbar.curActiveTag = tag
                    contentPageLoader.openMusicgroupPage(labeltxt)
                }
            }
        }

    }

    TRectangle{
        anchors.left: leftbar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
        color: "#FFF"
        Loader{
            id:contentPageLoader
            anchors.fill: parent
            asynchronous: true
            source: "qrc:/qml/Page_home.qml"

            TRectangle{
                id: mask
                color: "#FFF"
                anchors.fill: parent
                visible: contentPageLoader.status != Loader.Ready
                z: 1
            }

            function openHomPage(){
                source = "qrc:/qml/Page_home.qml"
            }

            function openMvPage(param){
                root.global.openmvName = param
                source = "qrc:/qml/Page_mvplay.qml"
            }

            function openMusicgroupPage(param){
                root.global.openGroupName = param
                source = "qrc:/qml/Page_musicgroup.qml"
            }

            function openDownloadPage(){
                source = "qrc:/qml/Page_download.qml"
            }

            function openMusicAlbumPage(param){
                root.global.openAlbumName = param
                source = "qrc:/qml/Page_album.qml"
            }

            function openFriendPage(){
                source = "qrc:/qml/Page_friend.qml"
            }

            function openHotPage(){
                source = "qrc:/qml/Page_hot.qml"
            }

            function openFmPage(){
                source = "qrc:/qml/Page_fm.qml"
            }

            function openSingerPage(){
                source = "qrc:/qml/Page_singer.qml"
            }

            function gotoSingerDatailPage(name) {
                root.global.openSignerName = name
                source = "qrc:/qml/Page_singerdetailed.qml"
            }

            function reload(url) {
                if(source + "" === url){
                    source = ""
                }

                source = url
            }
        }

    }

    TRectangle {
        id: bottombar
        z: 1
        anchors.bottom: parent.bottom
        width: parent.width
        height: 60
        color: "#FFF"

        TProgressBar {
            width: parent.width
            height: 2
            maxValue: player.duration
            value: player.position
            background.color: "#f5f5f5"
            foreground.color: "#D13C37"
            anchors.top: parent.top
        }

        Row {
            spacing: 15
            anchors.left: parent.left
            anchors.leftMargin: 20
            height: parent.height
            TAvatar {
                radius: 5
                border.width: 1
                border.color: "#d5d5d5"
                width: 45
                height: 45
                anchors.verticalCenter: parent.verticalCenter
                source: D.music[8].pic
                asynchronous: true

                TMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(!global.explayPanel) {
                            global.explayPanel = exppanelComponent.createObject(root)
                            global.explayPanel.isshow = true
                        }else{
                            global.explayPanel.isshow = false
                        }
                    }
                }
            }

            Column{
                anchors.verticalCenter: parent.verticalCenter
                spacing: 3
                TLabel{
                    text: D.music[8].name + " - " + D.music[8].singer
                }

                TLabel{
                    text:_format(player.position) + " / " + _format(player.duration)

                    function _format(time){
                        var mi = Math.floor(time / 1000)
                        var s = mi % 60
                        var ms = Math.floor( mi / 60)

                        var sStr = s < 10 ? ("0" + s) : s
                        var msStr = ms < 10 ? ("0" + ms) : ms

                        var format = msStr + ":" + sStr
                        return format
                    }
                }
            }
        }



        Row{
            id: playControlbar
            anchors.centerIn: parent
            spacing: 30

            property bool playing: false

            TIconButton{
                icon.position: TPosition.Only
                //theme.childName: "playcontrol"
                icon.type: TIconType.SVG
                icon.source: "qrc:/res/heart.svg"
                backgroundComponent: null
                icon.color: "#5D5D5D"
                icon.width: 20
                icon.height: 20
                onClicked: {
                    icon.source = "qrc:/res/heart-fill.svg"
                }
            }

            TIconButton{
                hoverEnabled: true
                theme.childName: "playcontrol"
                icon.position: TPosition.Only
                icon.source: TAwesomeType.FA_step_backward
                icon.color: "#d13c37"
                icon.width: 18
                icon.height: 18
                backgroundComponent:  null
                padding: 13
            }


            TIconButton {
                id: playorpauseBtn
                padding: 4
                theme.childName: "play"
                icon.position: TPosition.Only
                icon.width: 36
                icon.height: 36
                icon.source: playControlbar.playing ? TAwesomeType.FA_pause_circle : TAwesomeType.FA_play_circle //TAwesomeType.FA_play_circle  //TAwesomeType.FA_pause_circle
                icon.color: "#FFF"
                background.color: "#d5504b"
                background.radius: width / 2

                onClicked: {
                    playControlbar.playing = ! playControlbar.playing
                    if(playControlbar.playing){
                        player.mplay("https://toou.oss-cn-hangzhou.aliyuncs.com/github-resources/other/Adele_Rolling_inthe_Deep.mp3")
                    }else{
                        player.pause()
                    }
                }
            }

            TIconButton{
                hoverEnabled: true
                theme.childName: "playcontrol"
                icon.position: TPosition.Only
                icon.source: TAwesomeType.FA_step_forward
                icon.color: "#d13c37"
                icon.width: 18
                icon.height: 18
                backgroundComponent:  null
                padding: 13
            }

            TIconButton{
                backgroundComponent: null
                icon.position: TPosition.Only
                //theme.childName: "playcontrol"
                icon.source:"qrc:/res/audio.svg"
                icon.type: TIconType.SVG
                icon.width: 20
                icon.height: 20
            }
        }


        Row{
            spacing: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20

            TIconButton{
                icon.position: TPosition.Only
                icon.type: TIconType.SVG
                icon.source: "qrc:/res/m1.svg"
                backgroundComponent: null
            }

            TIconButton{
                icon.position: TPosition.Only
                icon.type: TIconType.SVG
                icon.source: "qrc:/res/mlist.svg"
                backgroundComponent: null
            }
        }

    }

    Q.Dialog_login{
        id:loginDialog
        onLogin: {
            root.global.userName = username
            TToast.showSuccess("欢迎使用TQuick音乐",TToast.longTime)

            hideAndClose()
        }
    }

    Q.Dialog_creategroup{
        id:newGroupDialog

        onTriggered: {
            if(item.text){
                TToast.showSuccess("创建成功",TTimePreset.ShortTime2s)
                leftbar.groupModel.append({labeltxt:item.text})
            }else{
                TToast.showWarning("亲，想好名字再来哟~",TTimePreset.ShortTime2s)
            }


            hideAndClose()
        }
    }
    Q.Dialog_about{
        id:dialog_about
        onTriggered: {
            hideAndClose()
        }
    }

    Component{
        id:exppanelComponent
        Q.Panel_explay{
            id:exppanel
            height: parent.height - bottombar.height
            width: parent.width
            y: isshow ? 0 : bottombar.y + 100

            property bool isshow: false

            Behavior on y {
                NumberAnimation {
                    duration: 300
                    onRunningChanged: {
                        if(!running && !isshow){
                            exppanel.destroy()
                        }
                    }
                }
            }
        }
    }


    TPopoverMenu{
        id:themePopover

        TPopoverElement{
            text: "默认"
            otherData: ""
            iconSource: TThemeManager.appThemeInvalid ? TAwesomeType.FA_check_circle_o : TAwesomeType.FA_circle_o
        }

        TPopoverElement{
            text: "宁静"
            otherData: "Solarized"
            iconSource: TThemeManager.appTheme === otherData ? TAwesomeType.FA_check_circle_o : TAwesomeType.FA_circle_o
        }

        TPopoverElement{
            text: "炫黑"
            otherData: "Dark"
            iconSource: TThemeManager.appTheme === otherData ? TAwesomeType.FA_check_circle_o : TAwesomeType.FA_circle_o
        }

        onTriggered: TThemeManager.appTheme = modelData.otherData
    }


    Q.Panel_message{
        id:messagebar
        width: 300
        height: contentPageLoader.height
        x:root.width - width
        y:topbar.height
    }


}
