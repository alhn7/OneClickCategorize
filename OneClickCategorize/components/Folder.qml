import QtQuick 2.15

Rectangle{
    property string _folderName: "Default"
    property string _folderColor: "#353536"

    width: 190
    height: parent.height


    color: "transparent"
    radius: 8

    border{
        width: 1
        color: _folderColor
    }
}
