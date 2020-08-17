import QtQuick 2.6
import TQuick 1.2

/* https://www.iconfont.cn
    svg 是一种比较流行的icon 源。
    默认是异步加载的,可提高性能。
*/
Item {
    id: tSVGIcon
    width: 16
    height: 16

    property bool asynchronous: true
    property bool smooth: true
    property color color
    property string source

    property alias theme: tSVGIconTheme
    property alias status: image.status

    Image {
        id: image
        asynchronous: tSVGIcon.asynchronous
        anchors.fill: tSVGIcon
        source: tSVGIcon.source
        smooth: tSVGIcon.smooth
        visible: false
        enabled: false
    }

    ShaderEffect {
        id: shaderItem
        property variant source: image
        property color color: tSVGIcon.color
        enabled: false
        fragmentShader: "qrc:/TQuick/resource/font/svg.cso"
        anchors.fill: parent
        visible: tSVGIcon.status === Image.Ready
    }

    TThemeBinder {
        id: tSVGIconTheme
        className: "TSVGIcon"
        state: tSVGIcon.state

        property alias color: tSVGIcon.color
        property alias source: tSVGIcon.source
        property alias width: tSVGIcon.width
        property alias height: tSVGIcon.height

        Component.onCompleted: initialize()
    }
}
