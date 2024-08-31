import QtQuick 2.15

Rectangle {
    id: root
    property string _folderName: "Default"
    property string _folderColor: "#353536"
    property var droppedExtensions: []
    property bool isFolder: true  // Add this property to identify as a folder

    signal extensionAdded()

    width: 190
    height: foldersRowLayout.height

    color: "transparent"
    radius: 8

    border {
        width: 1
        color: _folderColor
    }

    FolderTextInput {
        id: folderTextInput
        _folderText: _folderName

        anchors {
            top: parent.top
            topMargin: 5
            horizontalCenter: parent.horizontalCenter
        }
    }

    DropArea {
        id: dropArea
        anchors.fill: parent
        onEntered: {
            root.border.color = "#A7FB1F"
        }
        onExited: {
            root.border.color = _folderColor
        }
        onDropped: {
            root.border.color = _folderColor
            if (drag.source.objectName === "extensionChip") {
                root.addExtension(drag.source)
            }
        }
    }

    Flow {
        id: extensionsFlow
        width: parent.width - 20
        anchors {
            top: folderTextInput.bottom
            topMargin: 5
            bottom: parent.bottom
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 5
    }

    function addExtension(extension) {
        console.log("DEBUG: Adding extension to folder:", _folderName, "Extension:", extension)
        var extensionText = typeof extension === 'string' ? extension : extension._text
        var existingChip = null

        // Check if the extension already exists in this folder
        for (var i = 0; i < extensionsFlow.children.length; i++) {
            if (extensionsFlow.children[i]._text === extensionText) {
                existingChip = extensionsFlow.children[i]
                break
            }
        }

        if (existingChip) {
            console.log("DEBUG: Extension already exists in folder:", _folderName)
            if (typeof extension !== 'string' && extension !== existingChip) {
                // If it's a different ExtensionChip object, destroy the existing one and add the new one
                existingChip.destroy()
                extension.parent = extensionsFlow
                extension.x = 0
                extension.y = 0
            } else {
                // If it's the same object or a string, just ensure it's visible and positioned correctly
                existingChip.visible = true
                existingChip.x = 0
                existingChip.y = 0
            }
        } else {
            // If the extension doesn't exist in this folder, create a new chip or move the existing one
            if (typeof extension === 'string') {
                var component = Qt.createComponent("ExtensionChip.qml")
                if (component.status === Component.Ready) {
                    var chip = component.createObject(extensionsFlow, {
                        _text: extensionText,
                        originalParent: extensionsFlow,
                        isInFileTypesFolder: false
                    })
                    droppedExtensions.push(extensionText)
                    console.log("DEBUG: New ExtensionChip created in folder:", _folderName)
                } else {
                    console.error("DEBUG: Error creating ExtensionChip:", component.errorString())
                }
            } else {
                extension.parent = extensionsFlow
                extension.x = 0
                extension.y = 0
                droppedExtensions.push(extensionText)
                console.log("DEBUG: Existing ExtensionChip moved to folder:", _folderName)
            }
        }
        extensionAdded()
    }
}