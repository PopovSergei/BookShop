import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Dialog {
    property string name
    property string cost
    standardButtons: Dialog.Cancel | Dialog.Ok
    modal: true
    Column {
        id: layout
        objectName: "layout"
        anchors.fill: parent
        TextField {
            id: nameField
            width: parent.width
            placeholderText: qsTr("Введите название")
        }
        TextField {
            id: costField
            width: parent.width
            placeholderText: qsTr("Введите цену")
        }
    }
    onAccepted: {
        name = nameField.text
        cost = costField.text
    }
}
