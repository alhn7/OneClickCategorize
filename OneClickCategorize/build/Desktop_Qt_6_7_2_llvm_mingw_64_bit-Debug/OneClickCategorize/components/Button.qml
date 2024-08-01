import QtQuick 2.15
import QtQuick.Controls 2.15

import "../texts" as Texts


Rectangle{
    property int _width: 297
    property string _text: "DefText1"

    width: _width
    height: 45

    radius: 9
    color: "#A7FB1F"

    border{
        color: "#353536"
        width: 1
    }

    Component.onCompleted: {
        buttonText._text = _text
    }

    Texts.ButtonText{
        id: buttonText
        _text: ""

        anchors{
            centerIn: parent
        }
    }
}
