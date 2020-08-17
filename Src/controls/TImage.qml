import QtQuick 2.6
import TQuick 1.2

Image {
    id: tImage

    property alias theme: tImageTeme

    TThemeBinder {
        id: tImageTeme
        className: "TImage"
        state: tImage.state

        property alias source: tImage.source
        property alias width: tImage.width
        property alias height: tImage.height

        Component.onCompleted: initialize()
    }
}
