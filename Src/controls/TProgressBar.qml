import QtQuick 2.0
import TQuick 1.2

/*!todo*/
Item {
    id: tProgressBar
    clip: true
    width: 300
    height: 10

    /**显示的文本，格式化通配符含义：
        $p 百分比数值  ，$max 最大值，$s   启始值，$v   当前值
        例如：loader $p%  即：loader 50%
        */
    property string format:"loading $p %"
    property double value : 0
    property double maxValue: 100
    property double startValue: 0

    readonly property double percentage: mPrivate.percentage()
    //获得格式化后的文本
    readonly property string formatText : mPrivate.format()

    property alias theme: tProgressBarTheme
    property alias background: mBackground
    property alias foreground: mForeground

    property Component maskComponent: null
    property Component backgroundComponent
    //通过percentage可以自定义动画行为
    property Component foregroundComponent

    Loader {
        id: backgroundComponentLoader
        anchors.fill: parent
        sourceComponent: backgroundComponent

        Loader {
            id: foregroundComponentLoader
            width: parent.width
            height: parent.height
            sourceComponent: foregroundComponent
            z: 1
        }
    }

    backgroundComponent: TRectangle {
        color: mBackground.color
        radius: mBackground.radius
        theme.filterPropertyName: ["width","height"]
        theme.childName: "background"
        theme.parent: tProgressBarTheme
    }

    foregroundComponent: TRectangle {
        theme.parent: tProgressBarTheme
        color: mForeground.color
        radius: mForeground.radius
        theme.filterPropertyName: ["width","height"]
        theme.childName: "foreground"

        x: width * (1 - tProgressBar.percentage) * -1

        Behavior on x {
            id: behavior
            enabled: false
            NumberAnimation {
                duration: 200
            }
        }
        Timer {
            interval: 20
            running: true
            onTriggered: behavior.enabled = true
        }
    }

    maskComponent: Rectangle {
        width: backgroundComponentLoader.width
        height: backgroundComponentLoader.height
        radius: mBackground.radius
    }

    Loader {
        id: mask
        sourceComponent: maskComponent
    }

    TMask {
        anchors.fill: parent
        sourceItem: backgroundComponentLoader
        maskItem: mask
    }

    TObject {
        id: mPrivate
        property bool moveing: false

        function percentage() {
            var cv = tProgressBar.value + tProgressBar.startValue
            if (tProgressBar.maxValue <= 0 || cv <= 0) {
                return 0
            } else if (cv >= tProgressBar.maxValue) {
                return 1
            }
            return cv / tProgressBar.maxValue
        }

        function format() {
            var str =  tProgressBar.format
            if (!str) {
                return ""
            }
            str = str.replace(/\$p/g, Math.floor(percentage() * 100))
            str = str.replace(/\$max/g, tProgressBar.maxValue)
            str = str.replace(/\$s/g, tProgressBar.startValue)
            str = str.replace(/\$v/g, tProgressBar.value)
            return str
        }
    }

    TGadgetBackground {
        id: mBackground
        color: "#EBEEF5"
        width: tProgressBar.width
        height: tProgressBar.height
        radius: height / 2
    }

    TGadgetBackground {
        id: mForeground
        color: "#46A0FC"
        width: tProgressBar.width
        height: tProgressBar.height
        radius: height / 2
    }

    TThemeBinder {
        id: tProgressBarTheme
        className: "TProgressBar"

        Component.onCompleted: initialize()
    }
}
