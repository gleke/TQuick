import QtQuick 2.0
import TQuick 1.2

TObject {
    property bool lighter: false
    property var otherData
    property alias icon: mGadgetIcon
    property alias label: mGadgetLabel
    TGadgetIcon{
        id: mGadgetIcon
    }
    TGadgetLabel{
        id: mGadgetLabel
    }
}
