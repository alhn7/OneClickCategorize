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
            bottom: parent.bottom
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 5
    }

    function addExtension(extension) {
        if (typeof extension === 'string') {
            // If extension is a string, create a new ExtensionChip
            var component = Qt.createComponent("ExtensionChip.qml")
            if (component.status === Component.Ready) {
                var chip = component.createObject(extensionsFlow, {
                    _text: extension,
                    originalParent: extensionsFlow,
                    isInFileTypesFolder: false
                })
                droppedExtensions.push(extension)
            }
        } else {
            // If extension is an object (existing ExtensionChip), move it
            droppedExtensions.push(extension._text)
            extension.parent = extensionsFlow
            extension.anchors.fill = undefined
            extension.x = 0
            extension.y = 0
            extension.isInFileTypesFolder = false
        }
        console.log("Extension added to folder:", _folderName)
        extensionAdded()
    }
}