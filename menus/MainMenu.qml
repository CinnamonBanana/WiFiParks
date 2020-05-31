import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.6

MenuBar {
    property variant  providerMenu: providerMenu
    signal selectProvider(string providerName)
    signal selectMapType(variant mapType)
    signal toggleMapState(string state)

    Menu {
        id: providerMenu
        title: qsTr("Provider")

        function createMenu(plugins)
        {
            clear()
            for (var i = 0; i < plugins.length; i++) {
                createProviderMenuItem(plugins[i]);
            }
        }

        function createProviderMenuItem(provider)
        {
            var item = addItem(provider);
            item.checkable = true;
            item.triggered.connect(function(){selectProvider(provider)})
        }
    }


}
