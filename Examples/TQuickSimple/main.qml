import QtQuick 2.6
import QtQuick.Window 2.2
import TQuick 1.2

Window {
    id: root
    visible: true
    width: 550
    height: 700

    TQuickWorld {
//        generateThemeTemplateEnable: true
                        themeDirs: [
                            "./"
                        ]
                        startupTheme: "Test"
    }


    Component.onCompleted: {
        root.showMaximized()
        root.showNormal()
    }

    Column{
        spacing: 10
        Row{
            height: 40
            spacing: 10
            TButton{
                label.text: "Default"
            }

            TButton{
                label.text: "Primary"
                label.color: "#FFF"
                label.font.bold: true
                background.color: "#46A0FC"
                theme.groupName: "primary"
            }

            TButton{
                label.text: "Success"
                label.font.bold: true
                label.color: "#FFF"
                background.color: "#6AC044"
                theme.groupName: "success"
            }

            TButton{
                label.text: "Warning"
                label.font.bold: true
                label.color: "#FFF"
                background.color: "#E4A147"
                theme.groupName: "warning"
            }

            TButton{
                label.text: "Danger"
                label.font.bold: true
                label.color: "#FFF"
                background.color: "#F36D6F"
                theme.groupName: "danger"
            }
        }

        Row{
            height: 40
            spacing: 10
            TButton{
                label.text: "Default"
            }

            TButton{
                label.text: "Primary"
                label.color: "#46A0FC"
                label.font.bold: true
                background.color: "#ECF5FF"
                border.color: "#46A0FC"
                theme.enabled: false
            }

            TButton{
                label.text: "Success"
                label.font.bold: true
                label.color: "#6AC044"
                background.color: "#F0F9EB"
                border.color: "#6AC044"
                theme.enabled: false
            }

            TButton{
                label.text: "Warning"
                label.font.bold: true
                label.color: "#E4A147"
                background.color: "#FDF6ED"
                border.color: "#E4A147"
                theme.enabled: false
            }

            TButton{
                label.text: "Danger"
                label.font.bold: true
                label.color: "#F36D6F"
                background.color: "#FEF0F0"
                border.color: "#F36D6F"
                theme.enabled: false
            }
        }

    }
}
