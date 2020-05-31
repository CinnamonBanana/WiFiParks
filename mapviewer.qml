import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.6
import QtPositioning 5.5
import "map"
import "menus"

ApplicationWindow {
    id: appWindow
    property variant map
    property variant minimap
    property variant parameters
    property variant lastX
    property variant lastY

    function createMap()
    {

        if (minimap) {
            minimap.destroy()
            minimap = null
        }

        var zoomLevel = null
        var center = null
        if (map) {
            zoomLevel = map.zoomLevel
            center = map.center
            map.destroy()
        }

        map = mapComponent.createObject(page);
        map.plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin{ name:"osm"}', appWindow);

        var data=JSON.parse(file);
        setmarkers(data);
    }


        function setmarkers(data){
            var a=data.length
            for(var i=0;i<a;i++){
                var dolgota=data[i].Longitude_WGS84
                var d=parseFloat(dolgota)
                var shirota=data[i].Latitude_WGS84
                var sh=parseFloat(shirota)
                var jsid =data[i].ID
                map.addMarker(jsid, sh,d);
            }
        }
        function getdata(id){
            var data=JSON.parse(file);
            var a=data.length
            for(var i=0;i<a;i++){
                if(id==data[i].ID)return data[i];
            }
            return;

    }

    function getPlugins()
    {
        var plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {}', appWindow)
        var myArray = new Array()
        for (var i = 0; i<plugin.availableServiceProviders.length; i++) {
            var tempPlugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {name: "' + plugin.availableServiceProviders[i]+ '"}', appWindow)
            if (tempPlugin.supportsMapping())
                myArray.push(tempPlugin.name)
        }
        myArray.sort()
        return myArray
    }

    function initializeProviders(pluginParameters)
    {
        var parameters = new Array()
        for (var prop in pluginParameters){
            var parameter = Qt.createQmlObject('import QtLocation 5.6; PluginParameter{ name: "'+ prop + '"; value: "' + pluginParameters[prop]+'"}',appWindow)
            parameters.push(parameter)
        }
        appWindow.parameters = parameters
        var plugins = getPlugins()
        mainMenu.providerMenu.createMenu(plugins)
        for (var i = 0; i<plugins.length; i++) {
            if (plugins[i] === "osm")
                mainMenu.selectProvider(plugins[i])
        }
    }

    title: qsTr("Парки WiFi")
    height: 720
    width: 1280
    visible: true

    MainMenu {
        id: mainMenu
        onSelectProvider: {
            stackView.pop()
            createMap()
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        initialItem: Item {
            id: page
        }
        function showMessage(title,message,backPage, longitude, latitude)
        {
            push({ item: Qt.resolvedUrl("forms/Message.qml") ,
                               properties: {
                                   "title" : title,
                                   "message" : message,
                                   "backPage" : backPage,
                                   "longitude" : longitude,
                                   "latitude" : latitude
                               }})
            currentItem.closeForm.connect(closeMessage)
        }

        function closeMessage(backPage)
        {
            pop(backPage)
        }
    }

    PositionSource {
    id: srcc
    updateInterval: 1000
    active: Qt.application.state
    onPositionChanged: {
            var coord = srcc.position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
    }
}
    Component {
        id: mapComponent

        MapComponent{
            width: page.width
            height: page.height
        }
    }
}
