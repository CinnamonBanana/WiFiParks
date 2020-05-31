import QtQuick 2.5;
import QtLocation 5.6


MapQuickItem {
    id: marker
    property int onMapId
    property bool isUser

    property alias lastMouseX: markerMouseArea.lastX
    property alias lastMouseY: markerMouseArea.lastY

    anchorPoint.x: image.width/4
    anchorPoint.y: image.height

    sourceItem: Image {
        id: image
        source:
            if (isUser) "../resources/user.png"
            else "../resources/marker.png"
        opacity: markerMouseArea.pressed ? 0.6 : 1.0
        MouseArea  {
            id: markerMouseArea
            property int lastX: -1
            property int lastY: -1
            anchors.fill: parent
            hoverEnabled : false
            preventStealing: true
            onPressed : {
                var smth = getdata(onMapId)
                stackView.showMessage(qsTr("Информация о сети"),"<b>" + qsTr("Широта: ") + "</b> " + coordinate.latitude +
                                      "<br><b>" + qsTr("Долгота: ") + "</b> " + coordinate.longitude +
                                      "<br><b>" + qsTr("Административная зона: ") + "</b> " + smth.AdmArea +
                                      "<br><b>" + qsTr("Район: ") + "</b> " + smth.District +
                                      "<br><b>" + qsTr("Название парка: ") + "</b> " + smth.ParkName +
                                      "<br><b>" + qsTr("Название сети: ") + "</b> " + smth.WiFiName +
                                      "<br><b>" + qsTr("Функционирование: ") + "</b> " + smth.FunctionFlag +
                                      "<br><b>" + qsTr("Тип сети: ") + "</b> " + smth.AccessFlag,0,coordinate.longitude, coordinate.latitude)
            }
        }
    }
}

