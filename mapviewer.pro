TARGET = qml_location_mapviewer
TEMPLATE = app

QT += qml network quick positioning location
SOURCES += main.cpp

# Workaround for QTBUG-38735
QT_FOR_CONFIG += location-private
qtConfig(geoservices_mapboxgl): QT += sql
qtConfig(geoservices_osm): QT += concurrent

RESOURCES += \
    mapviewer.qrc

OTHER_FILES +=mapviewer.qml \
    map/MapComponent.qml \
    map/Marker.qml \
    map/RectangleItem.qml \
    map/MiniMap.qml \
    menus/MainMenu.qml \
    menus/MarkerPopupMenu \
    forms/Message.qml \
    forms/MessageForm.ui.qml

target.path = $$[QT_INSTALL_EXAMPLES]/location/mapviewer
INSTALLS += target

DISTFILES +=
