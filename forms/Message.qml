import QtQuick 2.5

MessageForm {
    property string title
    property string message
    property variant backPage
    property double longitude
    property double latitude

    signal closeForm(variant backPage)

    button.onClicked: {
        closeForm(backPage)
    }
    button1.onClicked: {
        Qt.openUrlExternally("geo:"+longitude+","+latitude)
    }
    Component.onCompleted: {
        messageText.text = message
        messageTitle.text = title
    }
}
