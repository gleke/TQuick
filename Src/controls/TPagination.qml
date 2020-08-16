import QtQuick 2.6
import TQuick 1.1

//分页、页导航*/
Item {
    id: tPagination
    width: content.width
    height: content.height

    signal triggered(var index)

    property int currentIndex: 0
    property int count: 3
    property int spacing: 2

    property alias itemBackground: mItemGadgetBackground
    property alias itemActiveBg: mItemActiveGadgetBackground
    property alias itemBorder: mItemGadgetBorder
    property alias itemActiveBorder:mItemActiveGadgetBorder
    property alias theme: tPaginationTheme

    property Component contentComponent

    contentComponent: TButton {
        theme.enabled: false
        backgroundComponent: null
        padding: 12
        opacity: mItemGadgetBackground.opacity
        contentComponent: TRectangle {
            property bool active: currentIndex === index
            width: active ? mItemActiveGadgetBackground.width : mItemGadgetBackground.width
            height: active ? mItemActiveGadgetBackground.height : mItemGadgetBackground.height
            radius: active ? mItemActiveGadgetBackground.radius : mItemGadgetBackground.radius
            color: {
                TThemeManager.appThemeInvalid
                return active ? mItemActiveGadgetBackground.color : mItemGadgetBackground.color
            }

            border.width: active ? mItemActiveGadgetBorder.width : mItemGadgetBorder.width
            border.color: active ? mItemActiveGadgetBorder.color : mItemGadgetBorder.color
            theme.enabled: false
        }

        onClicked: {
            tPagination.triggered(index)
        }
    }

    Row {
        id: content
        spacing: tPagination.spacing

        Repeater {
            model: tPagination.count
            delegate: contentComponent
        }
    }

    TGadgetBackground {
        id: mItemGadgetBackground
        color: "#ECECEC"
        radius: 2
        width: 25
        height: 4
    }

    TGadgetBackground {
        id: mItemActiveGadgetBackground
        color: "#FC6A21"
        radius: 2
        width: 25
        height: 4
    }

    TGadgetBorder {
        id: mItemGadgetBorder
    }

    TGadgetBorder {
        id: mItemActiveGadgetBorder
    }

    TThemeBinder {
        id: tPaginationTheme
        className: "TPagination"

        property alias spacing: tPagination.spacing

        TThemeBinder {
            childName: "item"

            property alias opacity: mItemGadgetBackground.opacity
            property alias width: mItemGadgetBackground.width
            property alias height: mItemGadgetBackground.height
            property alias radius: mItemGadgetBackground.radius
            property alias color: mItemGadgetBackground.color
        }

        TThemeBinder {
            childName: "item.active"

            property alias opacity: mItemActiveGadgetBackground.opacity
            property alias width: mItemActiveGadgetBackground.width
            property alias height: mItemActiveGadgetBackground.height
            property alias radius: mItemActiveGadgetBackground.radius
            property alias color: mItemActiveGadgetBackground.color
        }

        TThemeBinder {
            childName: "item.border"

            property alias width: mItemGadgetBorder.width
            property alias color: mItemGadgetBorder.color
        }

        TThemeBinder {
            childName: "item.active.border"

            property alias width: mItemActiveGadgetBorder.width
            property alias color: mItemActiveGadgetBorder.color
        }

        Component.onCompleted: initialize()
    }

}
