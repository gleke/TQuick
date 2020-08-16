import QtQuick 2.0
import TQuick 1.1

Column{
    spacing: 15

    TDividerLine{
        width: 350
        height: 1
    }

    Row{
        spacing: 10
        Repeater{
            model: 30

            delegate: TDividerLine{
                width: Math.random() * 2 + 1
                height: 40
                color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
            }
        }
    }


    TDividerLine{
        width: 350
        height: 1
    }

}
