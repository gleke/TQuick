import QtQuick 2.0
import TQuick 1.2

Column{
    spacing: 15

    Grid{
        id:layout
        columns: 6
        spacing: 20


        Repeater{
            model: [
                "#46A0FC",
                "#46A0FC",
                "#46A0FC",
                "#6AC044",
                "#6AC044",
                "#6AC044",
                "#E4A147",
                "#E4A147",
                "#E4A147",
                "#F36D6F",
                "#F36D6F",
                "#F36D6F",
            ]

            delegate: TSVGIcon{
                width: 40
                height: 40
                source: "qrc:/images/svg"+index+".svg"
                color: modelData
            }
        }
    }
}
