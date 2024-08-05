import QtQuick 2.15
import QtQuick.Layouts
import "../texts/" as Texts


Rectangle{
    width: 710
    height: 400

    color: "#1E1E1E"
    radius: 15

    Texts.HeadingText{
        id: stateHasRecentRun
        _text: "Categorize a Folder"
        _color: "#A9A9A9"

        anchors{
            left: parent.left
            leftMargin: 20
            top: parent.top
            topMargin: 20
        }
    }

    Rectangle{//Step 1 Container
        width: parent.width - 40
        height: 100

        color: "transparent"
        radius: 10

        border{
            width: 1
            color: "#353536"
        }

        anchors{
            top: stateHasRecentRun.bottom
            topMargin: 20
            left: parent.left
            leftMargin: 20
        }

        Texts.SubheadingText{
            id: stepOneQuestionText
            _text: "<b>Step 1:</b> Which folder you want to categorize?"

            anchors{
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }


        RowLayout{
            spacing: 30

            anchors{
                bottom: parent.bottom
                bottomMargin: 15
                horizontalCenter: parent.horizontalCenter
            }

            Button{
                _text: "Categorize Desktop"
                _width: 200
            }

            Texts.SubheadingText{
                _text: "or"
            }

            Button{
                _text: "Choose Another Folder"
                _width: 220
                _color: "#0B0C0E"
                _textColor: "#A9A9A9"
            }

        }
    }

}
