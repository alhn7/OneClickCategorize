import QtQuick 2.15

Text{
    property string _color: "#353536"
    property string _text: "DefText"

    text: _text
    color: _color
    font{
        family: poppinsSemiBold.name
        pixelSize: 12

    }
}
