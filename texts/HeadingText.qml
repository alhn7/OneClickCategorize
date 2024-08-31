import QtQuick 2.15

Text{
    property string _color: "#EAEAEA"
    property string _text: "DefText"

    text: _text
    color: _color
    font{
        family: poppinsBold.name
        pixelSize: 16
        bold:true
    }
}
