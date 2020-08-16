import QtQuick 2.6
import TQuick 1.1

/* 单选按钮组
    在组内的单选按钮选择是唯一的
*/
TObject {
    id: tRadioBoxGroup

    property Item parent
    property list<TRadioBox> mchilds

    readonly property alias currentIndex: mPrivate.currentIndex
    readonly property Item currentItem: {
        if (currentIndex  !== -1) {
            return children[currentIndex]
        }
        return null
    }

    default property alias children: tRadioBoxGroup.mchilds

    TObject {
        id: mPrivate
        property int currentIndex: -1
    }

    onChildrenChanged: {
        var i = children.length - 1
        var trb = children[i]
        trb.parent = parent
        trb.groupIndex = i

        if (mPrivate.currentIndex !== -1) {
            trb.checked = false
        } else if (trb.checked) {
            mPrivate.currentIndex = i
        }
        trb.checkedChanged.connect(function() {
            if (trb.checked) {
                mPrivate.currentIndex = trb.groupIndex
            }
        })
    }

    onCurrentIndexChanged: {
        for (var child in children) {
            var cobj = children[child]
            if (cobj.groupIndex !== mPrivate.currentIndex) {
                cobj.checked = false
            }
        }
    }

    Component.onCompleted: {
        if (mPrivate.currentIndex == -1) {
            var cobj = children[0]
            if (cobj) {
                cobj.checked = true
            }
        }
    }
}
