import QtQuick 2.15
import "../components/" as Components

Item {

    Image{
        source: "../assets/logo/logo_placeholder.png"

        anchors{
            left: parent.left
            leftMargin: 20
            top: parent.top
            topMargin: 20
        }
    }



    Components.DashboardState_NoRecentRun{
        anchors.centerIn: parent
    }

}
