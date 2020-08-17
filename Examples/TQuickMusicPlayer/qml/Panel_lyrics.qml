import QtQuick 2.0
import TQuick 1.2
import QtQuick.Controls 2.2
import "../database/parserLrc.js" as LRC
Item{
    width: parent.width / 2 - 20
    height: parent.height

    property alias interactive: listview.interactive

    Row{
        id:titleName
        height: name.height
        spacing: 20
        TLabel{
            id:name
            font.pixelSize: 25
            text: "Rolling In The Deep - Adele"
        }

        TImage{
            theme.enabled: false
            source: "qrc:/res/sq_play.png"
            width:  30
            height: 16
            anchors.verticalCenter: parent.verticalCenter
        }

        TImage{
            theme.enabled: false
            source: "qrc:/res/cell_mv.png"
            width:  30
            height: 16
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ListView{
        id:listview
        width: parent.width 
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleName.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        clip: true
        property int currentHoldIndex: -1
        model:ListModel{}

        delegate: Item{
            width: parent.width
            height: 30
            TLabel {
                text: value
                property bool ishold: listview.currentHoldIndex == index
                anchors.verticalCenter: parent.verticalCenter
                color: ishold ? "#000" : "#5D5D5D"
                font.pixelSize: ishold ? 14 : 13
                font.bold: ishold
                theme.groupName: "lyrics"
                theme.state: ishold ? "hold" : "none"
            }
        }

        onCurrentHoldIndexChanged: {
            if(currentHoldIndex * 30 >= height / 2){
                contentY =  currentHoldIndex * 30 - height / 2
            }
        }
    }

    TScrollbarV{
        anchors.top: listview.top
        anchors.right: listview.right
        height: listview.height
        target: listview
    }

    //-------------------
    function loadlrc(file){
        LRC.openFile(file,createlrcItem)
    }

    function createlrcItem(data){
        var list = LRC.parser(data)

        for(var i in list){
            list[i].index = i
            listview.model.append(list[i])
        }
    }

    Timer{
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            var len = listview.model.count
            for(var r = len - 1; r >= 0; r--){
                if(root.player.position / 1000 > listview.model.get(r).time){
                    listview.currentHoldIndex = r
                    break
                }
            }
        }
    }

    Component.onCompleted: {
        loadlrc("qrc:/res/music/Adele_Rolling_in the_Deep.lrc")
    }

}
