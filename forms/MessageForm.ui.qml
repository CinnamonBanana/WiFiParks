import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: root
    property alias messageText: messageText
    property alias messageTitle: messageTitle
    property alias button: button
    property alias button1: button1

    Rectangle {
        id: tabRectangle
        y: 0
        height: messageTitle.height * 2
        color: "#702ade"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Label {
            id: messageTitle
            color: "#ffffff"
            text: qsTr("type")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 19
        anchors.topMargin: 21
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabRectangle.bottom

        ColumnLayout {
            id: columnLayout1
            spacing: 20
            anchors.fill: parent


            Label {
                id: messageText
                text: qsTr("message")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
            }

            Button {
                id: button
                text: qsTr("OK")
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }



            Button {
                id: button1
                text: qsTr("Открыть точку в приложении Карты")
                Layout.fillWidth: true
            }

            Item {
                Layout.fillHeight: true
            }

        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
