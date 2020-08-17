import QtQuick 2.0
import TQuick 1.2

// 固定导航横向的
//    分隔内容上有关联但属于不同类别的数据集合。
//    添加附属item需要使用 children:[Item... ]

//    自定义item 可使用的Loder属性
//    var  modelData
//    bool isActiveItem

//        TNavigationBar{
//            spacing: 5
//            color: "#FFF"

//            TNavigationElement{
//                label: "Hello"
//            }
//        }

/*! TODO */
Item {
    id: tNavigationBar
    width: contentLayout.width + padding
    height: contentLayout.height + padding

    /*! button被点击触发的信号，同时携带这个button*/
    signal triggered(var modelData)

    property int itemWidth: 0
    property int itemHeight: 0
    property int padding: 8
    property int spacing: 10
    property int currentIndex: -1

    property alias label: mGadgetLabel
    property alias activeLabel: mGadgetActiveLabel
    property alias icon: mGadgetIcon
    property alias activeIcon: mGadgetActiveIcon
    property alias theme: tNavigationBarTheme

    default property alias contentchild: mPrivate.elements

    readonly property Item currentItem: {
        if (currentIndex >= 0 && currentIndex < contentLayout.children.length) {
            contentLayout.children[currentIndex].x
            return contentLayout.children[currentIndex]
        }
        return null
    }

    property Component itemComponent

    itemComponent: TIconButton {
        padding: 10
        backgroundComponent: null
        theme.enabled: false

        label.text: modelData.text ?  modelData.text : modelData.index
        label.color: isActiveItem ? mGadgetActiveLabel.color : mGadgetLabel.color
        label.font: isActiveItem ? mGadgetActiveLabel.font  : mGadgetLabel.font

        icon.source: modelData.iconSource
        icon.color: isActiveItem  ? mGadgetActiveIcon.color  : mGadgetIcon.color
        icon.width: isActiveItem  ? mGadgetActiveIcon.width  : mGadgetIcon.width
        icon.height: isActiveItem  ? mGadgetActiveIcon.height : mGadgetIcon.height

        onClicked: {
            tNavigationBar.currentIndex = modelData.index
            triggered(modelData)
        }

        Timer {
            interval: 10
            running: true
            onTriggered: {
                width = itemWidth   > 0 ? itemWidth  : contentWidth + padding
                height = itemHeight > 0 ? itemHeight : contentHeight + padding
            }
        }
    }

    TGadgetLabel {
        id: mGadgetLabel
        color: "#303133"
    }

    TGadgetLabel {
        id: mGadgetActiveLabel
        color: "#000"
        font.bold: true
        font.pixelSize: 16
    }

    TGadgetIcon {
        id: mGadgetIcon
        color: "#303133"
    }

    TGadgetIcon {
        id: mGadgetActiveIcon
        color: "#000"
        width: 20
        height: 20
    }

    TObject {
        id: mPrivate
        property list<TNavigationElement> elements
    }

    Row {
        id: contentLayout
        anchors.verticalCenter: parent.verticalCenter
        spacing: tNavigationBar.spacing
        Repeater {
            id: repeater
            model: ListModel { }
            delegate: Loader {
                property var modelData: model
                property bool isActiveItem: tNavigationBar.currentIndex === index

                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: itemComponent
            }
        }
    }

    Component.onCompleted: {
        for (var i in mPrivate.elements) {
            repeater.model.append(mPrivate.elements[i])
        }
        if (mPrivate.elements.length > 0 && currentIndex === -1) {
            currentIndex = 0
        }
    }

    TThemeBinder {
        id: tNavigationBarTheme
        className: "TNavigationBar"

        TThemeBinder {
            target: mGadgetLabel
            childName: "label"

            property color color: mGadgetLabel.color
            property bool bold: mGadgetLabel.font.bold
            property int pixelSize: mGadgetLabel.font.pixelSize
            property string family: mGadgetLabel.font.family
        }

        TThemeBinder {
            target: mGadgetActiveLabel
            childName: "active.label"

            property color color: mGadgetActiveLabel.color
            property bool bold: mGadgetActiveLabel.font.bold
            property int pixelSize: mGadgetActiveLabel.font.pixelSize
            property string family: mGadgetActiveLabel.font.family
        }

        TThemeBinder {
            target: mGadgetIcon
            childName: "icon"

            property color color: mGadgetIcon.color
            property int width: mGadgetIcon.width
            property int height:mGadgetIcon.height
        }

        TThemeBinder {
            target: mGadgetActiveIcon
            childName: "active.icon"

            property color color: mGadgetActiveIcon.color
            property int width: mGadgetActiveIcon.width
            property int height: mGadgetActiveIcon.height
        }

        Component.onCompleted: initialize()
    }
}
