import QtQuick 2.6
import TQuick 1.1

Flickable {
    id: tFlickable

    /*! set default property*/
    flickableDirection: Flickable.AutoFlickDirection

    /*! set default property*/
    boundsBehavior: Flickable.StopAtBounds

    /*! 配置滚动条相关属性*/
    property alias scrollBar: scrollBar

    TGadgetScrollbar {
        id: scrollBar
        vertical: true
        horizontal: true
    }

    children: [
        TScrollbarV {
            id: scrllbarV
            target: tFlickable
            height: parent.height
            anchors.right: tFlickable.right
            visible: scrollBar.vertical
        },
        TScrollbarH {
            id: scrllbarH
            target: tFlickable
            width: parent.width
            anchors.bottom: tFlickable.bottom
            visible: scrollBar.horizontal
        }
    ]
}
