import QtQuick 2.15


Item{
    property string _folderText: "Default"
    TextInput{
        id: folderNameTextInput
        text: _folderText
        color: "#A9A9A9"
        width: 140


        font{
            family: poppinsRegular
            pixelSize: 12

        }

        anchors{
            top: parent.top
            topMargin: 10
            left: parent.horizontalCenter
        }

    }

    Row {
        spacing: 2 // Space between the dots


        anchors{
            top: folderNameTextInput.bottom
            topMargin: 2
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: rowEditIndıcator
            model: 35 // Number of dots


            Rectangle {
                width: 2 // Width of each dot
                height: 2 // Height of each dot
                radius: width / 2 // To make the dot circular
                color: "#CCCCCC" // Color of the dots
            }
        }
    }




}


