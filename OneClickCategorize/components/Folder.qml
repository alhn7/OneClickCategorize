import QtQuick 2.15

Rectangle{
    property string _folderName: "Default"
    property int _folderCounter: 0
    property string _folderColor: "#353536"

    width: Math.max(parent.width / _folderCounter - (10 * _folderCounter), 200)  // - (10 * _folderCounter) -> paddings
    height: parent.height

    color: "transparent"
    radius: 8

    border{
        width: 1
        color: _folderColor
    }

}
