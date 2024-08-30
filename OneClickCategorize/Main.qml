import QtQuick
import "./screens/" as Screens



Window{
    width: 750
    height: 500
    color: "transparent"


    visible: true
    title: qsTr("Folder/Desktop Categorizer")
    flags: Qt.Window


    FontLoader {
        id: poppinsRegular
        source: "./assets/fonts/Poppins-Regular.ttf"
    }

    FontLoader {
        id: poppinsMedium
        source: "./assets/fonts/Poppins-Medium.ttf"
    }

    FontLoader {
        id: poppinsBold
        source: "./assets/fonts/Poppins-Bold.ttf"
    }

    FontLoader {
        id: poppinsItalic
        source: "./assets/fonts/Poppins-Italic.ttf"
    }

    FontLoader {
        id: poppinsSemiBold
        source: "./assets/fonts/Poppins-SemiBold.ttf"
    }

    FontLoader {
        id: poppinsThin
        source: "./assets/fonts/Poppins-Thin.ttf"
    }

    FontLoader {
        id: poppinsBlack
        source: "./assets/fonts/Poppins-Black.ttf"
    }

    Rectangle {
        color: "#141414"
        anchors.fill: parent
        Screens.Dashboard{
            anchors.fill: parent
            anchors.centerIn: parent
        }
    }
}
