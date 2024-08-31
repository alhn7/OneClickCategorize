import QtQuick 2.15
import QtQuick.Controls 2.15

import "../texts" as Texts


Rectangle{
    property int _width: 297
    property string _text: "DefText"
    property string _iconFileName: "icon_default"
    property bool _isPassword: false
    property bool showPassword: false

    width: _width
    height: 45

    radius: 9
    color: "#0B0C0E"

    border{
        color: "#353536"
        width: 1
    }

    Image{
        id: iconImage
        source: "../assets/icons/" + _iconFileName +".png"
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 15
        }
    }

    TextField {
        id: nameField

        width: parent.width * 0.75

        placeholderText: qsTr(_text)
        placeholderTextColor: "#353536"
        color: "#EAEAEA"
        echoMode: _isPassword ? TextInput.Password : TextInput.Normal


        background: Rectangle {
            color: "transparent" // Make the background transparent
        }

        font{
            family: poppinsMedium.name
            pixelSize: 14
        }

        anchors{
            verticalCenter: parent.verticalCenter
            left: iconImage.right
            leftMargin: 5
        }
    }

    Image{
        id: showPasswordIconImage
        visible: _isPassword
        source: showPassword ? "../assets/icons/icon_password_visible.png" : "../assets/icons/icon_password_hidden.png"
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 15
        }


        MouseArea{
            anchors.fill: parent

            onClicked: {
                showPassword = !showPassword

                if(showPassword){
                    nameField.echoMode = TextInput.Normal
                }else{
                    nameField.echoMode = TextInput.Password
                }
            }
        }
    }
}
