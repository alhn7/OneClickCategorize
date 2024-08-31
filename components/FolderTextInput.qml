import QtQuick 2.15


Item{
    id: root
    width: 140  // Set an explicit width for the root item
    height: 40  // Set an appropriate height

    property string _folderText: "Default"
    property int maxCharacters: 20

    Text {
        id: folderNameDisplay
        text: _folderText.length > maxCharacters ? _folderText.substring(0, maxCharacters) + "..." : _folderText
        color: "#A9A9A9"
        width: Math.min(implicitWidth, dotRow.width)
        horizontalAlignment: Text.AlignHCenter
        
        font {
            family: poppinsRegular.name
            pixelSize: 12
        }

        anchors {
            top: parent.top
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                folderNameDisplay.visible = false
                folderNameInput.visible = true
                folderNameInput.forceActiveFocus()
            }
        }
    }

    TextInput {
        id: folderNameInput
        text: _folderText
        color: "#A9A9A9"
        width: Math.min(implicitWidth, dotRow.width)
        horizontalAlignment: Text.AlignHCenter
        visible: false
        maximumLength: maxCharacters
        
        font {
            family: poppinsRegular.name
            pixelSize: 12
        }

        anchors {
            top: parent.top
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        onTextChanged: {
            if (text.length >= maxCharacters) {
                errorTooltip.visible = true
            } else {
                errorTooltip.visible = false
            }
        }

        onEditingFinished: {
            _folderText = text
            visible = false
            folderNameDisplay.visible = true
            errorTooltip.visible = false
        }

        Keys.onEscapePressed: {
            text = _folderText
            visible = false
            folderNameDisplay.visible = true
            errorTooltip.visible = false
        }
    }

    Rectangle {
        id: errorTooltip
        visible: false
        color: "#FFE0E0"
        border.color: "#FF0000"
        radius: 4
        height: errorText.height + 8
        width: errorText.width + 16
        
        anchors {
            top: folderNameInput.bottom
            topMargin: 4
            horizontalCenter: folderNameInput.horizontalCenter
        }
        
        Text {
            id: errorText
            text: "Max 20 characters!"
            color: "#FF0000"
            anchors.centerIn: parent
            font.pixelSize: 14
        }
    }

    Row {
        id: dotRow
        spacing: 2 // Space between the dots
        width: 35 * 4 // 35 dots * (2px width + 2px space)

        anchors {
            top: folderNameDisplay.bottom
            topMargin: 2
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: rowEditIndicator
            model: 35 // Number of dots

            Rectangle {
                width: 2 // Width of each dot
                height: 2 // Height of each dot
                radius: width / 2 // To make the dot circular
                color: "#CCCCCC" // Color of the dots
            }
        }
    }
}



