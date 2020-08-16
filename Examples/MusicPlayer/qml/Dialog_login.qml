import QtQuick 2.6
import TQuick 1.1

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
                    placeholderLabel.text: "手机号码或用户名"
                    placeholderIcon.source: TAwesomeType.FA_user_o
                    theme.enabled: false
                }

                TInputField {
                    id: inputcode
                    anchors.horizontalCenter: inputcol.horizontalCenter
                    width: parent.width * 0.8
                    background.radius: 4
                    placeholderPosition: TPosition.Left
                    placeholderLabel.text: "验证码"
                    placeholderIcon.source: TAwesomeType.FA_keyboard_o
                    theme.enabled: false

                    TButton {
                        label.text: "获取验证码"
                        anchors.right: inputcode.right
                        anchors.rightMargin: 5
                        height: inputcode.height - 10
                        background.radius: 4
                        anchors.verticalCenter: inputcode.verticalCenter
                        theme.enabled: false
                        onClicked: {
                            if (!user.text) {
                                TToast.showError("请输入手机号码")
                            } else {
                                inputcode.text = "666"
                                label.text = "正在发送中.."
                            }
                        }
                    }
                }
            }

            TButton {
                anchors.horizontalCenter: contentcol.horizontalCenter
                width: parent.width * 0.8
                height: 40
                label.text: "登  陆"
                background.color: "#C93935"
                background.radius: 5
                label.color: "#fff"
                label.font.pixelSize: 16
                theme.enabled: false
                onClicked: {
                    if(!user.text){
                        TToast.showError("请输入手机号码")
                    }else if(!inputcode.text){
                        TToast.showError("请输入短信验证码")
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
                    text: "其它方式登陆"
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
