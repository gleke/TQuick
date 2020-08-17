import QtQuick 2.6
import TQuick 1.2

TDialog {
    id: dialog

    signal login(var username)

    bodyComponent: TRectangle {
        theme.enabled: false
        id: cItem
        color: "#FFF"
        width: 350
        height: 470
        radius: 5

        Column {
            id:contentcol
            spacing: 25
            width: parent.width

            Item {
                width: parent.width
                height: 12

                TIconButton {
                    icon.position: TPosition.Only
                    icon.source: TAwesomeType.FA_close
                    backgroundComponent: null
                    anchors.right: parent.right
                    onClicked: dialog.hideAndClose()
                }
            }

            Image {
                anchors.horizontalCenter: contentcol.horizontalCenter
                source: "qrc:/res/loading.png"
            }

            Column {
                id: inputcol
                width: parent.width
                spacing: 10
                TInputField {
                    id: user
                    anchors.horizontalCenter: inputcol.horizontalCenter
                    width: parent.width * 0.8
                    background.radius: 4
                    placeholderPosition: TPosition.Left
                    placeholderLabel.text: qsTr("Mobile phone number or user name")
                    placeholderIcon.source: TAwesomeType.FA_user_o
                    theme.enabled: false
                }

                TInputField {
                    id: inputcode
                    anchors.horizontalCenter: inputcol.horizontalCenter
                    width: parent.width * 0.8
                    background.radius: 4
                    placeholderPosition: TPosition.Left
                    placeholderLabel.text: qsTr("Verification Code")
                    placeholderIcon.source: TAwesomeType.FA_keyboard_o
                    theme.enabled: false

                    TButton {
                        height: inputcode.height - 10
                        anchors.right: inputcode.right
                        anchors.rightMargin: 5
                        anchors.verticalCenter: inputcode.verticalCenter
                        background.radius: 4
                        theme.enabled: false
                        label.text: qsTr("Get captcha")
                        onClicked: {
                            if (!user.text) {
                                TToast.showError(qsTr("Please enter your mobile phone number"))
                            } else {
                                inputcode.text = "666"
                                label.text = qsTr("Sending...")
                            }
                        }
                    }
                }
            }

            TButton {
                anchors.horizontalCenter: contentcol.horizontalCenter
                width: parent.width * 0.8
                height: 40
                label.text: "Login"
                background.color: "#C93935"
                background.radius: 5
                label.color: "#fff"
                label.font.pixelSize: 16
                theme.enabled: false
                onClicked: {
                    if(!user.text){
                        TToast.showError("Please enter your mobile phone number")
                    }else if(!inputcode.text){
                        TToast.showError("Please input SMS verification code")
                    }else{
                        dialog.login(user.text)
                    }
                }
            }


            Row{
                id:bottomrow
                anchors.horizontalCenter: contentcol.horizontalCenter
                spacing: 30
                Rectangle{
                    width: 80
                    height: 1
                    color: "#D5D5D5"
                    anchors.verticalCenter: bottomrow.verticalCenter
                }

                TLabel{
                    text: qsTr("Login in other ways")
                }

                Rectangle{
                    width: 80
                    height: 1
                    color: "#D5D5D5"
                    anchors.verticalCenter: bottomrow.verticalCenter
                }
            }

            Row{
                anchors.horizontalCenter: contentcol.horizontalCenter
                spacing: 70
                TIconButton{
                    icon.position: TPosition.Only
                    icon.color: "#FFF"
                    icon.source: TAwesomeType.FA_weixin
                    background.radius: width/2
                    border.color: Qt.darker(background.color,1.1)
                    background.color: "#1EB721"
                    theme.enabled: false
                }

                TIconButton{
                    icon.position: TPosition.Only
                    border.width: 1
                    border.color: Qt.darker(background.color,1.1)
                    icon.source: TAwesomeType.FA_qq
                    icon.color: "#FFF"
                    background.radius: width/2
                    background.color: "#6CBFF6"
                    theme.enabled: false
                }
            }
        }
    }
}
