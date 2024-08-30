import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import Qt.labs.platform 1.1 // For FolderDialog and StandardPaths

import "../texts/" as Texts
import "./" as Components


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
            topMargin: 10
        }
    }

    Rectangle{//Step 1 Container
        id: stepOneContainerRectangle
        width: parent.width - 40
        height: 100

        color: "transparent"
        radius: 10

        border{
            width: 1
            color: "#353536"
        }

        state: "initial"

        states: [
            State {
                name: "initial"
                PropertyChanges { target: stepOneContainerRectangle; border.color: "#353536"; height: 100 }
                PropertyChanges { target: buttonRow; visible: true }
                PropertyChanges { target: selectedPathText; visible: false }
            },
            State {
                name: "completed"
                PropertyChanges { target: stepOneContainerRectangle; border.color: "#A7FB1F"; height: 70 }
                PropertyChanges { target: buttonRow; visible: false }
                PropertyChanges { target: selectedPathText; visible: true }
            }
        ]

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        anchors{
            top: stateHasRecentRun.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 20
        }

        Texts.SubheadingText{
            id: stepOneQuestionText
            _text: "<b>Step 1:</b> Which folder you want to categorize?"
            _color: "#EAEAEA"

            anchors{
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }


        RowLayout{
            id: buttonRow
            spacing: 30

            anchors{
                bottom: parent.bottom
                bottomMargin: 15
                horizontalCenter: parent.horizontalCenter
            }

            Components.Button{
                _text: "Categorize Desktop"
                _width: 200
                onClicked: {
                    selectedFolderPath = StandardPaths.standardLocations(StandardPaths.DesktopLocation)[0]
                    selectedFolderPath = selectedFolderPath.replace(/^(file:\/{3})/,"")
                    console.log("Desktop folder selected:", selectedFolderPath)
                    stepOneContainerRectangle.state = "completed"
                    // You can add additional logic here to handle the desktop folder selection
                }
            }

            Texts.SubheadingText{
                _text: "or"
            }

            Components.Button{
                _text: "Choose Another Folder"
                _width: 220
                _color: "#0B0C0E"
                _textColor: "#A9A9A9"
                onClicked: folderDialog.open() // Add this onClicked handler
            }
        }

        Texts.SubheadingText{
            id: selectedPathText
            _text: "You chose the path: <b>" + selectedFolderPath + "</b>"
            _color: "#FFFFFF"
            visible: false
            wrapMode: Text.WordWrap

            anchors{
                bottom: parent.bottom
                bottomMargin: 15
                horizontalCenter: parent.horizontalCenter
            }

        }
    }

    Rectangle{//Step 2 Container
        id: stepTwoContainerRectangle
        width: parent.width - 40
        height: 230

        color: "transparent"
        radius: 10

        border{
            width: 1
            color: "#353536"
        }

        anchors{
            top: stepOneContainerRectangle.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 20
        }

        ListModel {
            id: foldersModel
            ListElement { folderName: "TODO1" }
            ListElement { folderName: "TODO2" }
            ListElement { folderName: "TODO3" }
        }

        Components.Button {
            _text: "+ Add Folder"
            _width: 100
            _height: 25

            anchors {
                right: parent.right
                rightMargin: 10
                top: parent.top
                topMargin: 10
            }

            onClicked: {
                foldersModel.append({ folderName: "New Folder " + (foldersModel.count + 1) })
            }
        }

        Texts.SubheadingText{
            id: stepTwoQuestionText
            _text: "<b>Step 2:</b> Which file type goes which folder?"
            _color: "#EAEAEA"

            anchors{
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }
        Texts.SubheadingText{
            id: stepTwoSubQuestionText
            _text: "Drag and Drop the file types into the folder you want to categorize."
            _width: 400

            anchors{
                top: stepTwoQuestionText.bottom
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle{
            id: foldersRowLayoutFrame
            width: parent.width * 0.675
            height: parent.height * 0.675 + 30 //30 -> Horizontal Scrollbar
            color: "transparent"
            clip: true

            anchors{
                top: stepTwoSubQuestionText.bottom
                topMargin: 6
                left: parent.left
                leftMargin: 12
            }

            ListView {
                id: foldersRowLayout

                orientation: ListView.Horizontal
                spacing: 10

                width: parent.width
                height: parent.height - 40 // -30 -> Horizontal Scrollbar

                model: foldersModel

                delegate: Folder {
                    _folderName: folderName
                    Layout.alignment: Qt.AlignLeft
                    Layout.fillWidth: true
                }

                ScrollBar.horizontal: ScrollBar {
                    height: 15


                    anchors{
                        top: foldersRowLayout.bottom
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }

                    // Custom background for the scrollbar
                    background: Rectangle {
                        color: "#141414"
                        radius: 0
                    }

                    // Custom handle for the scrollbar
                    contentItem: Rectangle {
                        height: parent.height - 4

                        anchors.verticalCenter: parent.verticalCenter
                        color: "#1E1E1E"  // Handle color
                        radius: 0

                        border{
                            width: 1
                            color: "#A7FB1F"
                        }
                    }

                }
            }
        }


        Rectangle{
            width: parent.width * 0.282
            height: foldersRowLayout.height

            color: "transparent"
            radius: 8

            border{
                width: 1
                color: "#FF0000"
            }

            anchors{
                right: parent.right
                rightMargin: 10
                top: stepTwoSubQuestionText.bottom
                topMargin: 6
            }
        }
    }

    property string selectedFolderPath: ""

    FolderDialog {
        id: folderDialog
        title: "Please choose a folder"
        folder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        onAccepted: {
            selectedFolderPath = folderDialog.folder.toString()
            // Remove the "file://" prefix if present
            selectedFolderPath = selectedFolderPath.replace(/^(file:\/{3})/,"")
            selectedFolderPath = decodeURIComponent(selectedFolderPath)
            console.log("Selected folder:", selectedFolderPath)
            stepOneContainerRectangle.state = "completed"
            // You can add additional logic here to handle the selected folder
        }
    }
}


