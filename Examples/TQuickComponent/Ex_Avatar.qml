import QtQuick 2.0
import TQuick 1.2

Column{
    spacing: 15

    Row{
        id:layout
        spacing: 20

        TAvatar{
            width: 60
            height: 60
            source: "qrc:/images/0.jpg"
            radius: 5
        }

        TAvatar{
            width: 60
            height: 60
            source: "qrc:/images/1.jpg"
            radius: 20
        }

        TAvatar{
            width: 60
            height: 60
            source: "qrc:/images/2.jpg"
            radius: height / 2
            border.width: 1
            border.color: "#F56C6C"
        }

        TAvatar{
            width: 60
            height: 60
            source: "qrc:/images/3.jpg"
            radius: 20
        }

        TAvatar{
            width: 60
            height: 60
            source: "qrc:/images/4.jpg"
            radius: 5
        }

    }

}
