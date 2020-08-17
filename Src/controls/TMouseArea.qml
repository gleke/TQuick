import QtQuick 2.6
import TQuick 1.2

MouseArea {
    id: tMousearea
    cursorShape: enabled ? TQuick.mouseAreaCursorShape() : Qt.ArrowCursor
    state: {
        if (checkable && checked) {
            setState(TStateType.Hover)
        }
        return setState(TStateType.Normal)
    }

    property bool stateEnabled: true
    property bool checkable: false
    property bool checked: false
    property bool takeFocus: true
    property int stateenum: 0

    onEntered: {
        if (hoverEnabled) {
            setState(containsPress ? TStateType.Pressed : TStateType.Hover)
        }
    }

    onExited: {
        if (checkable && checked) {
            setState(TStateType.Checked)
        } else {
            setState(TStateType.Normal)
        }
    }

    onPressed: {
        setState(TStateType.Pressed)
        if (takeFocus) {
            focus = true
        }
    }

    onReleased: {
        if (checkable) {
            checked = !checked
            setState(checked ? TStateType.Checked : TStateType.Normal)
        } else {
            setState(hoverEnabled && containsMouse ? TStateType.Hover : TStateType.Normal)
        }
    }

    function setState(val) {
        if (!stateEnabled) {
            return
        }
        stateenum = val
        state = statetoString(val)
    }

    function statetoString(value) {
        switch(value) {
        case TStateType.Normal:
            return ""
        case TStateType.Hover:
            return "hovering"
        case TStateType.Checked:
            return "checked"
        case TStateType.Pressed:
            return "pressed"
        }
        return ""
    }

}
