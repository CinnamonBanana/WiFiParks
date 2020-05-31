import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.6
import QtPositioning 5.5

Rectangle{
    function clamp(num, min, max)
    {
      return num < min ? min : num > max ? max : num;
    }

    function minimumScaleFactor()
    {
        var hscalefactor = (400.0 / Math.max(Math.min(map.width, 1000), 400)) * 0.5
        var vscalefactor = (400.0 / Math.max(Math.min(map.height, 1000), 400)) * 0.5
        return Math.min(hscalefactor,vscalefactor)
    }

    function avgScaleFactor()
    {
        var hscalefactor = (400.0 / Math.max(Math.min(map.width, 1000), 400)) * 0.5
        var vscalefactor = (400.0 / Math.max(Math.min(map.height, 1000), 400)) * 0.5
        return (hscalefactor+vscalefactor) * 0.5
    }

    id: miniMapRect
    width: Math.floor(map.width * avgScaleFactor()) + 2
    height: Math.floor(map.height * avgScaleFactor()) + 2
    anchors.right: (parent) ? parent.right : undefined
    anchors.rightMargin: 10
    anchors.top: (parent) ? parent.top : undefined
    anchors.topMargin: 10
    color: "#242424"

    Map {
        id: miniMap
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 1
        width: Math.floor(map.width * avgScaleFactor())
        height: Math.floor(map.height * avgScaleFactor())
        zoomLevel: clamp(map.zoomLevel - 4.5, 2.0, 5.0)
        center: map.center
        plugin: map.provider
        gesture.enabled: false
        copyrightsVisible: false
        property double mapZoomLevel : map.zoomLevel

        onCenterChanged: miniMapRectangle.updateCoordinates()
        onMapZoomLevelChanged: miniMapRectangle.updateCoordinates()
        onWidthChanged: miniMapRectangle.updateCoordinates()
        onHeightChanged: miniMapRectangle.updateCoordinates()

        MapRectangle {
            id: miniMapRectangle
            color: "#44ff0000"
            border.width: 1
            border.color: "red"

            function getMapVisibleRegion()
            {
                return QtPositioning.shapeToRectangle(map.visibleRegion)
            }

            function updateCoordinates()
            {
                topLeft.latitude =  getMapVisibleRegion().topLeft.latitude
                topLeft.longitude=  getMapVisibleRegion().topLeft.longitude
                bottomRight.latitude =  getMapVisibleRegion().bottomRight.latitude
                bottomRight.longitude=  getMapVisibleRegion().bottomRight.longitude
                console.log("TopLeft: " + topLeft)
                console.log("BotRigh: " + bottomRight)
            }
        }
    }
}
