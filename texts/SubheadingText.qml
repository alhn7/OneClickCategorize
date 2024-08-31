import QtQuick 2.15

Text{
    property string _text: "defText"
    property string _color: "#A9A9A9"
    property int _width: 274
    property bool _isCentered: false

    width: _width
    text: _text
    color: _color
    wrapMode: Text.WordWrap
    
    horizontalAlignment: _isCentered ? Text.AlignHCenter : Text.AlignLeft


    font{
        family: poppinsBold.name
        pixelSize: 12
    }
}
