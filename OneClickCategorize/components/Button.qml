import QtQuick 2.15
import QtQuick.Controls 2.15

import "../texts" as Texts


Rectangle{
    property int _width: 297
    property int _height: 45
    property string _text: "DefText1"
    property string _color: "#A7FB1F"
    property string _textColor: "#353536"
    property string _borderColor: "#353536"

    width: _width
    height: _height

    radius: 9
    color: _color

    border{
        color: _borderColor
        width: 1
    }

    Component.onCompleted: {
        buttonText._text = _text
    }

    Texts.ButtonText{
        id: buttonText
        _text: ""
        _color: _textColor
        anchors{
            centerIn: parent
        }
    }
}
