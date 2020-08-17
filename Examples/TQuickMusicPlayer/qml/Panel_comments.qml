import QtQuick 2.6
import TQuick 1.2
import "../database/mdata.js" as DATA

Column{
    spacing: 10
    width: parent.width

    property int topMargen: 0

    Item {
        width: height
        height: topMargen
        visible: topMargen != 0
    }

    Item{
        width: parent.width
        height: 40

        TInputField{
            id: tif
            theme.groupName: "comment"
            placeholderIcon.source: TAwesomeType.FA_pencil
            placeholderLabel.text: qsTr("Speak freely and look forward to your God's comments")
            placeholderPosition: TPosition.Left
            width: parent.width - 70
            height: 40
        }

        TButton {
            theme.groupName: "submitcomments"
            label.text: qsTr("Submit")
            anchors.right: parent.right
            height: parent.height
            onClicked: {
                if (!root.global.userName) {
                    TToast.showError(qsTr("Leave a name"), TTimePreset.LongTime4s, qsTr("Where did the eminent monk come from?"))
                    root.loginDialog.open()
                } else {
                    TToast.showMessage(qsTr("Published successfully"), TToast.shortTime)
                    listview.add({user:root.global.userName, date:"2020-01-01", ctext:tif.text}, true)
                }
            }
        }
    }

    Item{
        width: height
        height: 10
    }

    TLabel{
        font.bold: true
        text: qsTr("Wonderful comments")
    }

    ListView{
        id: listview
        enabled: false
        boundsBehavior:Flickable.OvershootBounds
        width: parent.width
        height: contentHeight
        model: ListModel{}

        delegate: Item {
            width: parent.width
            height: 80

            TAvatar{
                id: pic
                width: 40
                height: 40
                radius: 20
                anchors.top: parent.top
                anchors.topMargin: 20
                source: "qrc:/res/portrait/" + Math.ceil(Math.random() * 40) + ".jpg"
            }

            Item {
                id: content
                width: parent.width - pic.width - 10
                anchors.left: pic.right
                anchors.leftMargin: 10
                height: parent.height

                TLabel{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset:  - 5
                    text:"<b>" + user + ":  </b>" + ctext
                }

                Item {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    width: parent.width
                    height: 30

                    TLabel{
                        text: date
                        color: "#ADADAD"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TIconButton{
                        width: 80
                        backgroundComponent: null
                        icon.position: TPosition.Left
                        label.text:"(" + Math.floor(Math.random() * 999) + ")"
                        icon.type: TIconType.SVG
                        icon.source: "qrc:/res/zan.svg"
                        anchors.right: shareicon.left
                        anchors.rightMargin: 20
                        height: parent.height
                        contentHAlign: Qt.AlignLeft
                        label.color: "#ADADAD"
                    }

                    TIconButton{
                        id: shareicon
                        backgroundComponent: null
                        icon.type: TIconType.SVG
                        icon.position: TPosition.Only
                        icon.source: "qrc:/res/fx.svg"
                        anchors.right: parent.right
                        height: parent.height
                        label.color: "#ADADAD"
                    }
                }
            }

            TDividerLine {
                id: line
                width: parent.width
                anchors.bottom: parent.bottom
                height: 1
                color: "#ececec"
            }

        }

        function add(obj,insert) {
            obj.icon = ""
            if (insert) {
                listview.model.insert(0, obj)
            }else{
                listview.model.append(obj)
            }
        }

        Component.onCompleted: {
            for (var i in DATA.comments) {
                if (Math.random() > 0.8) {
                    add(DATA.comments[i])
                }
            }
        }
    }
}
