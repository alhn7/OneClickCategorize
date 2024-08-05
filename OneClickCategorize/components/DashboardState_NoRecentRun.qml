import QtQuick 2.15
import QtQuick.Layouts

import "../texts" as Texts
import "./" as Components

Rectangle{
    width: 230
    height: 55
    color: "transparent"

    ColumnLayout{
        anchors.fill: parent
        spacing: 5

        Texts.SubheadingText{
            _text: "No recents run..."

            anchors.horizontalCenter: parent.horizontalCenter
        }

        Components.Button{
            _text: "Categorize a Folder"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
