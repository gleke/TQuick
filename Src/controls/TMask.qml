import QtQuick 2.0
import TQuick 1.1

Item {
    id: tMask

    property bool smooth: true
    property bool hideSource: true
    property bool live: true

    property alias sourceItem: mSource.sourceItem
    property alias maskItem: mMask.sourceItem

    ShaderEffectSource {
        id: mSource
        live: tMask.live
        visible: false
        hideSource: tMask.hideSource
        smooth: tMask.smooth
        sourceItem: sourceItem
    }

    ShaderEffectSource {
        id: mMask
        live: tMask.live
        visible: false
        hideSource: tMask.hideSource
        smooth: tMask.smooth
        sourceItem: maskItem
    }

    ShaderEffect {
        id: shaderItem
        anchors.fill: parent
        fragmentShader: "qrc:/TQuick/resource/font/mask.cso"

        property variant source: mSource
        property variant maskSource: mMask
    }

}
