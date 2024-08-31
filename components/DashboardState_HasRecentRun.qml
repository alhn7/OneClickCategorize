import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import Qt.labs.platform 1.1


import "../texts/" as Texts
import "./" as Components

import com.occ.FolderScanner 1.0


Rectangle{
    id: root
    width: 710
    height: 400

    color: "#1E1E1E"
    radius: 15

    property string selectedFolderPath: ""
    property var extensions: []  // Add this line to store the extensions

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
                PropertyChanges { target: selectedPathText; visible: true; color: "#A7FB1F" }
                StateChangeScript {
                    script: {
                        console.log("Scanning folder:", selectedFolderPath)
                        folderScanner.scanFolder(selectedFolderPath)
                    }
                }
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
                    onStep1Completed()
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
            _isCentered: true
            _width: parent.width - 20
            visible: false
            wrapMode: Text.WordWrap

            anchors{
                bottom: parent.bottom
                bottomMargin: 15
                left: parent.left
                leftMargin: (parent.width - width) / 2
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

        visible: stepOneContainerRectangle.state === "completed"
        opacity: visible ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        ListModel {
            id: foldersModel
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
                    onExtensionAdded: {
                        console.log("Extension added to folder:", _folderName)
                        // Add any additional logic you want to execute when an extension is added
                    }
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

                        Text {
                            text: "Scroll me"
                            color: "#A7FB1F"
                            font.pixelSize: 10
                            anchors.centerIn: parent
                        }
                    }

                }
            }
        }


        Rectangle{
            id: scanExtensionsFolder
            width: parent.width * 0.282
            height: foldersRowLayout.height

            color: "#1E1E1E"
            radius: 8

            border{
                width: 1
                color: "#353536"  // Default color
            }

            anchors{
                right: parent.right
                rightMargin: 10
                top: stepTwoSubQuestionText.bottom
                topMargin: 6
            }

            Texts.SubheadingText {
                id: fileTypesHeader
                _text: "File Types"
                _color: "#A9A9A9"
                _width: parent.width - 20
                _isCentered: true
                anchors {
                    top: parent.top
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Flow {
                id: extensionsFlow
                anchors {
                    top: fileTypesHeader.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: 10
                }
                spacing: 5

                // Extensions will be added here dynamically
            }

            Texts.SubheadingText {
                id: noFilesFoundText
                _text: "No files found"
                _color: "#A9A9A9"
                _isCentered: true
                width: 60
                visible: false
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Components.Button {
                id: addExtensionButton
                _text: "+"
                _width: 25
                _height: 25
                anchors {
                    top: parent.top
                    right: parent.right
                    margins: 5
                }
                onClicked: {
                    // Logic to add custom extension
                }
            }
        }
    }

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
            onStep1Completed()
        }
    }

    // Add this at the end of the file
    FolderScanner {
        id: folderScanner
        onScanCompleted: {
            if (stepOneContainerRectangle.state === "completed") {
                console.log("Scan completed. File extensions:", extensions)
                updateExtensionsDisplay(extensions)
            }
        }
    }

    function updateExtensionsDisplay(newExtensions) {
        if (stepOneContainerRectangle.state === "completed") {
            // Clear existing extensions
            for (var i = extensionsFlow.children.length; i > 0; i--) {
                extensionsFlow.children[i-1].destroy()
            }

            if (newExtensions.length === 0) {
                // Show "No files found" text
                noFilesFoundText.visible = true
                extensionsFlow.visible = false
            } else {
                // Hide "No files found" text and show extensions
                noFilesFoundText.visible = false
                extensionsFlow.visible = true

                newExtensions.forEach(function(ext) {
                    var component = Qt.createComponent("ExtensionChip.qml")
                    if (component.status === Component.Ready) {
                        var chip = component.createObject(extensionsFlow, {
                            _text: ext,
                            originalParent: extensionsFlow,
                            isInFileTypesFolder: true
                        })
                        chip.x = 0
                        chip.y = 0
                    }
                })
            }

            // Change border color here as well
            scanExtensionsFolder.border.color = "#A7FB1F"
        }
    }

    Repeater {
        model: root.extensions  // Use the extensions property from root
        delegate: ExtensionChip {
            objectName: "extensionChip"
            _text: modelData
            x: extensionsFlow.x + index * (width + extensionsFlow.spacing)
            y: extensionsFlow.y
            originalParent: extensionsFlow
        }
    }

    function createFolders() {
        if (stepOneContainerRectangle.state === "completed") {
            foldersModel.clear()  // Clear existing folders
            for (var i = 0; i < 3; i++) {
                foldersModel.append({ folderName: "TODO" + (i + 1) })
            }
        }
    }

    function onStep1Completed() {
        stepOneContainerRectangle.state = "completed"
        createFolders()
        folderScanner.scanFolder(selectedFolderPath)
    }

}


