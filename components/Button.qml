import QtQuick 2.15
import QtQuick.Controls 2.15

import "../texts" as Texts

Rectangle {
    id: root
    property int _width: 297
    property int _height: 45
    property string _text: "DefText1"
    property string _color: "#A7FB1F"
    property string _textColor: "#353536"
    property string _borderColor: "#353536"

    signal clicked()
    
    
    width: _width
    height: _height
    radius: 9 
    color: _color
    border.color: _borderColor
    border.width: 1

    Texts.ButtonText {
        id: buttonText
        _text: root._text
        _color: _textColor
        anchors.centerIn: parent
    }

    state: "default"

    states: [
        State {
            name: "default"
            PropertyChanges { target: root; radius: 9; color: _color; scale: 1.0 }
        },
        State {
            name: "hover"
            PropertyChanges { target: root; radius: 0; color: Qt.lighter(_color, 1.1); scale: 1.02 }
        },
        State {
            name: "pressed"
            PropertyChanges { target: root; radius: 0; color: Qt.darker(_color, 1.1); scale: 0.98 }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "*"
            PropertyAnimation { properties: "radius,color,scale"; duration: 200; easing.type: Easing.InOutQuad }
        }
    ]

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.state = "hover"
        onExited: root.state = "default"
        onPressed: root.state = "pressed"
        onReleased: {
            if (containsMouse)
                root.state = "hover"
            else
                root.state = "default"
            root.clicked()  
        }
    }
}
