import QtQuick 2.6
import TQuick 1.1

// 定点弹出框
//    与Dialog 不同的时他的小窗是指定位置的。
//    自带bodyLoaderItem逻辑过于简单，复杂类型还需要重新定义bodyLoaderItem
//    自定义 bodyLoaderItem, 当自定义以后Element将无效。如果自定义的是ListView那么需要自行绑定model

//    TPopoverMenu{
//        TPopoverElement{

//        }
//    }
TPopover{
    id: tPopoverMenu
    padding: 8
    bodyWidth: 150
    bodyComponent: menubodyComponent
    theme.className: "TPopoverMenu"

    signal triggered(var modelData)

    default property list<QtObject> elementlist

    property alias groupBackground: mGadgetBackground
    property alias groupLabel: mGadgetLabel
    property alias itemLabel: mItemGadgetLabel
    property alias itemBackground: mItemGadgetBackground
    property alias activeItemLabel: mActiveItemGadgetLabel
    property alias itemIcon: mItemGadgetIcon
    property alias activeItemIcon: mActiveItemGadgetIcon

    property Component groupComponent: defaultGroupComponent
    property Component itemComponent: defaultItemComponent

    function addElement(obj) {
        mPrivate.dynamicList.push(obj)
    }

    TGadgetBackground {
        id: mGadgetBackground
        color: bodyBackground.color
    }

    TGadgetLabel {
        id: mGadgetLabel
        font.pixelSize: TPixelSizePreset.PH7
    }

    TGadgetLabel {
        id: mItemGadgetLabel
        color: "#2D2D2D"
        property bool bold: font.bold
        property int pixelSize: font.pixelSize
    }

    TGadgetBackground {
        id: mItemGadgetBackground
        color: "#409EFF"
    }

    TGadgetLabel {
        id: mActiveItemGadgetLabel
        color: "#FFF"
        property bool bold: font.bold
        property int pixelSize: font.pixelSize
    }

    TGadgetIcon {
        id: mItemGadgetIcon
    }

    TGadgetIcon {
        id: mActiveItemGadgetIcon
        color: "#FFF"
    }


    Component {
        id: menubodyComponent
        TRectangle {
            width: bodyWidth  + border.width * 4
            height: crowlayout.height + padding
            color: bodyBackground.color
            radius: bodyBackground.radius
            border.width: bodyBorder.width
            border.color: bodyBorder.color

            theme.parent: tPopoverMenu.theme
            theme.childName: "body"

            ListModel {
                id: listmodel
            }

            Column {
                id: crowlayout
                anchors.centerIn: parent

                Repeater {
                    objectName: "repeater"
                    id: repeater
                    model: {
                        for (var i in elementlist) {
                            if (elementlist[i].type === "item" || elementlist[i].type === "group") {
                                listmodel.append(elementlist[i])
                            }
                        }

                        for (var l in mPrivate.dynamicList) {
                            if (mPrivate.dynamicList[l].type === "item" || mPrivate.dynamicList[l].type === "group") {
                                listmodel.append(mPrivate.dynamicList[l])
                            }
                        }

                        return listmodel
                    }

                    delegate: Loader {
                        id: load
                        width: tPopoverMenu.bodyWidth
                        sourceComponent: {
                            if (model.type === "item") {
                                return itemComponent
                            }
                            return groupComponent
                        }

                        property int modelIndex: index
                        property var modelData: model
                    }
                }
            }
        }
    }

    Component {
        id: defaultGroupComponent
        Item {
            id: group
            height: 20
            TRectangle {
                anchors.fill: parent
                color: mGadgetBackground.color
                radius: mGadgetBackground.radius
                visible: mGadgetBackground.visible

                theme.parent: tPopoverMenu.theme
                theme.childName: "group.background"
            }

            TLabel {
                anchors.verticalCenter: group.verticalCenter
                anchors.left: group.left
                anchors.leftMargin: 15
                text: modelData.text
                color: mGadgetLabel.color
                font.bold: mGadgetLabel.font.bold
                font.pixelSize: mGadgetLabel.font.pixelSize

                theme.parent: tPopoverMenu.theme
                theme.childName: "group.label"
            }
        }
    }

    Component {
        id: defaultItemComponent
        Item {
            property bool active: mPrivate.actieIndex === modelIndex
            height: 26
            TRectangle {
                anchors.fill: parent
                color: mItemGadgetBackground.color
                radius: mItemGadgetBackground.radius
                visible: active
                z: -1

                theme.parent: tPopoverMenu.theme
                theme.childName: "item.background"
            }

            TIconButton {
                id: btn
                width: parent.width
                height: parent.height
                spacing: 10
                padding: 15
                hoverEnabled: true
                contentHAlign: Qt.AlignLeft
                backgroundComponent: null

                icon.source: modelData.iconSource
                icon.color: active ? mActiveItemGadgetIcon.color : mItemGadgetIcon.color
                icon.width: active ? mActiveItemGadgetIcon.width : mItemGadgetIcon.width
                icon.height: active ? mActiveItemGadgetIcon.height: mItemGadgetIcon.height

                label.text: modelData.text
                label.color: active ? mActiveItemGadgetLabel.color : mItemGadgetLabel.color
                label.font.pixelSize: active ? mActiveItemGadgetLabel.pixelSize : mItemGadgetLabel.pixelSize
                label.font.bold: active ? mActiveItemGadgetLabel.bold : mItemGadgetLabel.bold

                onStateChanged: {
                    mPrivate.actieIndex = (state === "hovering" || state === "pressed") ?  modelIndex : -1
                }
                onClicked: {
                    triggered(modelData)
                    tPopoverMenu.close()
                }

                theme.enabled: false
            }
        }
    }

    TObject {
        id: mPrivate

        property int actieIndex: -1
        property var dynamicList: []

        TThemeBinder {
            parent: tPopoverMenu.theme

            TThemeBinder {
                target: mActiveItemGadgetLabel
                childName: "active.item.label"

                property color color: mActiveItemGadgetLabel.color
                property bool bold: mActiveItemGadgetLabel.bold
                property int pixelSize: mActiveItemGadgetLabel.pixelSize
            }

            TThemeBinder {
                target: mActiveItemGadgetIcon
                childName: "active.item.icon"

                property color color: mActiveItemGadgetIcon.color
                property int width: mActiveItemGadgetIcon.width
                property int height: mActiveItemGadgetIcon.height
            }

            TThemeBinder {
                target: mItemGadgetLabel
                childName: "item.label"

                property color color: mItemGadgetLabel.color
                property bool bold: mItemGadgetLabel.bold
                property int pixelSize: mItemGadgetLabel.pixelSize
            }

            TThemeBinder {
                target: mItemGadgetIcon
                childName: "item.icon"

                property color color: mItemGadgetIcon.color
                property int width: mItemGadgetIcon.width
                property int height: mItemGadgetIcon.height
            }

            Component.onCompleted: initialize()
        }
    }
}
