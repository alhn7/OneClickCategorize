import QtQuick 2.15
import QtQuick.Layouts

import "./texts" as Texts
import "./components" as Components


Rectangle{

    color: "transparent"
    width: 199; height: 417;


    anchors{
        left: parent.left
        leftMargin: 30
        verticalCenter: parent.verticalCenter
    }

    Texts.HeadingText {
        id: headingText
        text: "Login to \nOne-Click Categorizer"

        anchors{
            top: parent.top
            left: parent.left
        }
    }

    Texts.SubheadingText{
        id: subheadingText
        text: qsTr("Within seconds categorize your desired folder by your choice.")

        anchors{
            top: headingText.bottom
            topMargin: 10
        }
    }

    Components.InputArea{
        id: emailInputArea

        _iconFileName: "icon_email"
        _text: "Email"

        anchors{
            top: subheadingText.bottom
            topMargin: 30
        }
    }

    Components.InputArea{
        id: passwordInputArea

        _iconFileName: "icon_password"
        _text: "Password"
        _isPassword: true

        anchors{
            top: emailInputArea.bottom
            topMargin: 15
        }
    }

    Components.Button{
        id: loginButton

        _text: "Login"

        anchors{
            top: passwordInputArea.bottom
            topMargin: 15
        }
    }

    RowLayout{ // Or authorize with row
        id: authorizeSeperatorRowLayout
        width: parent.width
        height: 20

        spacing: 7

        anchors{
            left: parent.left
            top: loginButton.bottom
            topMargin: 10
        }

        Rectangle{
            width: 95
            height: 1

            color: "#353536"
        }
        Texts.SubheadingText{
            _text: "Or authorize with"
        }

        Rectangle{
            width: 95
            height: 1

            color: "#353536"
        }
    }


    Image{
        id: authWithGoogleButton

        source: "./assets/buttons/button_auth_with_google.png"

        anchors{
            top: authorizeSeperatorRowLayout.bottom
            topMargin: 15
        }
    }


    Texts.InputText{
        id: forgotPasswordButton

        _text: "Forgot password?"
        _color: "#A9A9A9"


        anchors{
            top: authWithGoogleButton.bottom
            topMargin: 20
        }
    }


    RowLayout{
        spacing: 5

        anchors{
            top: forgotPasswordButton.bottom
            topMargin: 5
        }


        Texts.InputText{
            _text: "Don’t have an account?"
        }



        Texts.InputText{
            _text: "Sign up"
            _color: "#A9A9A9"
        }
    }
}
