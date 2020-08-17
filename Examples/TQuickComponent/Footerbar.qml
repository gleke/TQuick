import QtQuick 2.6
import TQuick 1.2

TRectangle{
    anchors.bottom: parent.bottom
    color: "#43CEE6"
    theme.groupName: "footerbar"
    Row{
        spacing: 10
        anchors.centerIn: parent
        TAwesomeIcon{
            source: TAwesomeType.FA_github
            theme.groupName: "homt-bottom"
            color: "#FFF"
            width: 20
            height: 20
        }

        TLabel{
            text: "Powered by TQuick"
            color: "#FFF"
            font.bold: true
            font.pixelSize: 15
            theme.groupName: "bottom"
        }

    }
}
