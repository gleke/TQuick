import QtQuick 2.6
import TQuick 1.2
import "../database/mdata.js" as DATA

TRectangle {
    id:page

    property string groupName: root.global.openGroupName

    property bool isGroupEmpty: groupName !== qsTr("My favorite music")

    property alias subcontentLoader: subcontentLoader

    onIsGroupEmptyChanged: subcontentLoader.reload()

    Item{
        id:topbar
        width: parent.width
        height: 250

        TRectangle{
            id:cdicon
            radius: 10
            color: "#D9D9D9"
            width:  200
            height: 200
            border.width: 1
            border.color: Qt.darker(color,1.1)
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: y
            theme.groupName: "cdbg"

            TAvatar {
                source: "qrc:/res/mlike.png"
                anchors.fill: parent
                radius:  parent.radius
                visible: !isGroupEmpty
            }

            TSVGIcon{
                source: "qrc:/res/cd.svg"
                asynchronous: true
                color: "#FDFDFD"
                width: parent.width   - 50
                height: parent.height - 50
                anchors.centerIn: parent
                visible: isGroupEmpty
                theme.groupName: "cd"
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
                    background.radius: height / 2
                    anchors.verticalCenter: parent.verticalCenter
                    label.text: qsTr("song sheet")
                }

                TLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    text: page.groupName
                    font.pixelSize: 20
                    font.bold:true
                }

                TIconButton{
                    icon.position: TPosition.Only
                    icon.source: TAwesomeType.FA_edit
                    backgroundComponent: null
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: TToast.showWarning(qsTr("Unable to modify song list information temporarily"), TToast.longTime)
                }
            }

            TLabel{
                text: qsTr("Created on December 10, 2019")
            }

            Row{
                height:lt.height
                spacing: 20
                TLabel{
                    id:lt
                    text: qsTr("Total number of Songs:") + (isGroupEmpty ? "0" : DATA.music.length)
                }
                TLabel{
                    text: qsTr("Total playback times:") + (isGroupEmpty ? "0" : Math.round( Math.random()*10000))
                }
            }

            Row{
                width: parent.width
                height: 35
                spacing: 20

                Repeater{
                    model: [
                        {labeltxt: qsTr("Play all"), icon:TAwesomeType.FA_play_circle_o,prominent:true},
                        {labeltxt: qsTr("Collection"), icon:TAwesomeType.FA_folder_o,prominent:false},
                        {labeltxt: qsTr("Share"), icon:TAwesomeType.FA_share_square_o,prominent:false},
                        {labeltxt: qsTr("Download all"), icon:TAwesomeType.FA_download,prominent:false},
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
                        background.color: modelData.prominent ? "#d54f4a" : "#DCDCDC"
                    }
                }

            }
        }

    }

    //---

    TDividerLine {
        id: line
        anchors.top: navigationBar.bottom
        width: parent.width
        height: 1
        color: "#DCDCDC"
    }

    TNavigationBar {
        id: navigationBar
        anchors.top: topbar.bottom
        anchors.left: parent.left
        anchors.leftMargin: 30
        spacing: 20

        TNavigationElement {
            text: qsTr("Song list")
        }
        TNavigationElement {
            id:hot
            text: qsTr("comment")
        }
        TNavigationElement {
            text: qsTr("Collectors")
        }

        children: [
            TRectangle {
                id: swimbar
                x: navigationBar.currentItem.x
                width: navigationBar.currentItem.width
                height: 2
                anchors.top: navigationBar.bottom
                color: "#D13C37"
                theme.enabled: false

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

        onTriggered: {}
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
                return isGroupEmpty ? musicListviewComponentEmpty : musicListviewComponent
            }

            if(element === 1){
                return isGroupEmpty ? commentListComponent : commentListComponent
            }

            if(element === 2){
                return isGroupEmpty ? supporterListComponent : supporterListComponent
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
                text: qsTr("Go and collect your favorite music")
                font.pixelSize: 20
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -25
            }

            TLabel {
                text: qsTr("Busy modern people need to relax, and listening to music has become one of their preferred ways")
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
                text: qsTr("No collectors")
            }
        }
    }

}
