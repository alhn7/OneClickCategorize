import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    objectName: "extensionChip"
    property string _text: ""
    property bool isDragging: false
    property Item originalParent: parent
    property bool isInFileTypesFolder: true

    width: chipRect.width + 4
    height: chipRect.height + 4

    Rectangle {
        id: glowRect
        anchors.centerIn: parent
        width: chipRect.width + 4
        height: chipRect.height + 4
        color: "#A7FB1F"
        radius: chipRect.radius + 1
        opacity: mouseArea.containsMouse ? 0.2 : 0
        scale: mouseArea.containsMouse ? 1.1 : 1

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
        Behavior on scale {
            NumberAnimation { duration: 150 }
        }
    }

    Rectangle {
        id: chipRect
        anchors.centerIn: parent
        width: extensionText.width + 16
        height: 22
        color: "#353536"
        radius: 4
        scale: mouseArea.containsMouse ? 1.25 : 1

        Text {
            id: extensionText
            text: "." + _text
            color: "#A9A9A9"
            anchors.centerIn: parent
            font.pixelSize: 12
        }

        border {
            width: mouseArea.containsMouse ? 1 : 0
            color: "#A7FB1F"
        }

        Behavior on border.width {
            NumberAnimation { duration: 150 }
        }
        Behavior on scale {
            NumberAnimation { duration: 150 }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        drag.target: root

        onEntered: {
            if (isInFileTypesFolder) {
                tooltipTimer.start()
            }
        }
        onExited: {
            tooltipTimer.stop()
            tooltip.visible = false
        }

        onPressed: {
            root.isDragging = true
            root.z = 1000
            tooltip.visible = false
        }
        onReleased: {
            root.isDragging = false
            root.z = 0
            var dropTarget = root.Drag.target
            console.log("DEBUG: Drop target:", dropTarget)
            
            if (dropTarget && dropTarget.parent && dropTarget.parent.isFolder === true) {
                console.log("DEBUG: Drop target is a folder, adding extension:", root._text)
                dropTarget.parent.addExtension(root)
                // Don't destroy the chip here, let the folder handle it
            } else {
                console.log("DEBUG: Drop target is not a folder, resetting position.")
                root.x = 0
                root.y = 0
                root.parent = root.originalParent
                isInFileTypesFolder = true
            }
        }
    }

    Timer {
        id: tooltipTimer
        interval: 500 // Show tooltip after 500ms of hovering
        onTriggered: tooltip.visible = true
    }

    Rectangle {
        id: tooltip
        visible: false
        color: "#FFE0E0"
        border.color: "#FF0000"
        radius: 4
        height: tooltipText.height + 8
        width: tooltipText.width + 16

        anchors {
            bottom: parent.top
            bottomMargin: 4
            horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: tooltipText
            text: "Move extension to a folder"
            color: "#FF0000"
            anchors.centerIn: parent
            font.pixelSize: 14
        }
    }

    Drag.active: mouseArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2

    states: [
        State {
            when: root.isDragging
            ParentChange { target: root; parent: root.Window.contentItem }
            AnchorChanges { target: root; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
        }
    ]
}
