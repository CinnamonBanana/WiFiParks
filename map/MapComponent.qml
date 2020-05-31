import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.9
import QtPositioning 5.5

Map {
    id: map
    property variant markers
    property variant usermark
    property int markerCounter: 0


    function deleteMarkers()
    {
        var count = map.markers.length
        for (var i = 0; i<count; i++){
            map.removeMapItem(map.markers[i])
            map.markers[i].destroy()
        }
        map.markers = []
        markerCounter = 0
    }

    function deleteMapItems()
    {
        var count = map.mapItems.length
        for (var i = 0; i<count; i++){
            map.removeMapItem(map.mapItems[i])
            map.mapItems[i].destroy()
        }
        map.mapItems = []
    }


    function addMarker(onMapId=0, latitude=0, longitude=0, isUser=false)
    {
        var count = map.markers.length
        markerCounter++
        var marker = Qt.createQmlObject ('Marker {}', map)
        map.addMapItem(marker)
        marker.onMapId = onMapId
        marker.z = map.z+1
        marker.isUser = isUser
        marker.coordinate = QtPositioning.coordinate(latitude, longitude)

        var myArray = new Array()
        for (var i = 0; i<count; i++){
            myArray.push(markers[i])
        }
        myArray.push(marker)
        markers = myArray
    }

    function deleteMarker(index)
    {
        var myArray = new Array()
        var count = map.markers.length
        for (var i = 0; i<count; i++){
            if (index != i) myArray.push(map.markers[i])
        }

        map.removeMapItem(map.markers[index])
        map.markers[index].destroy()
        map.markers = myArray
        if (markers.length == 0) markerCounter = 0
    }






    zoomLevel: (maximumZoomLevel - minimumZoomLevel)/2
    center {
        latitude: 55.6567
        longitude: 37.6563
    }


    gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.FlickGesture | MapGestureArea.PinchGesture | MapGestureArea.RotationGesture | MapGestureArea.TiltGesture
    gesture.flickDeceleration: 3000
    gesture.enabled: true

    Component.onCompleted: {
        markers = new Array();
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Plus) {
            map.zoomLevel++;
        } else if (event.key === Qt.Key_Minus) {
            map.zoomLevel--;
        } else if (event.key === Qt.Key_Left || event.key === Qt.Key_Right ||
                   event.key === Qt.Key_Up   || event.key === Qt.Key_Down) {
            var dx = 0;
            var dy = 0;

            switch (event.key) {

            case Qt.Key_Left: dx = map.width / 4; break;
            case Qt.Key_Right: dx = -map.width / 4; break;
            case Qt.Key_Up: dy = map.height / 4; break;
            case Qt.Key_Down: dy = -map.height / 4; break;

            }

            var mapCenterPoint = Qt.point(map.width / 2.0 - dx, map.height / 2.0 - dy);
            map.center = map.toCoordinate(mapCenterPoint);
        }
    }

    MouseArea {
        id: mouseArea
        property variant lastCoordinate
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onPressed : lastCoordinate = map.toCoordinate(Qt.point(mouse.x, mouse.y))

        onDoubleClicked: {
            var mouseGeoPos = map.toCoordinate(Qt.point(mouse.x, mouse.y));
            var preZoomPoint = map.fromCoordinate(mouseGeoPos, false);
            if (mouse.button === Qt.LeftButton) {
                map.zoomLevel = Math.floor(map.zoomLevel + 1)
            } else if (mouse.button === Qt.RightButton) {
                map.zoomLevel = Math.floor(map.zoomLevel - 1)
            }
            var postZoomPoint = map.fromCoordinate(mouseGeoPos, false);
            var dx = postZoomPoint.x - preZoomPoint.x;
            var dy = postZoomPoint.y - preZoomPoint.y;

            var mapCenterPoint = Qt.point(map.width / 2.0 + dx, map.height / 2.0 + dy);
            map.center = map.toCoordinate(mapCenterPoint);

        }
    }
}
