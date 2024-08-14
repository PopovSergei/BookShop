import QtQuick
import QtQuick.Controls
import "../db/Database.js" as JS

Page {
    id: myPage
    width: parent.width
    height: parent.height

    function isCorrect() {
        return (titleField.length != 0 && priceField.length != 0 && amountField.length != 0)
    }

    Column {
        anchors.fill: parent
        TextField {
            id: titleField
            width: parent.width
            placeholderText: qsTr("Введите название")
            maximumLength: 15
        }
        TextField {
            id: priceField
            width: parent.width
            placeholderText: qsTr("Введите цену")
            validator: IntValidator{bottom: 1; top: 99999999;}
            maximumLength: 10
        }
        TextField {
            id: amountField
            width: parent.width
            placeholderText: qsTr("Введите количество")
            validator: IntValidator{bottom: 1; top: 99999999;}
            maximumLength: 10
        }
        Row {
            Button {
                enabled: isCorrect()
                text: "Добавить"
                onClicked: {
                    JS.dbInsertStationery(titleField.text, priceField.text, amountField.text)
                    myPage.destroy()
                }
            }
            Button {
                text: "Отмена"
                onClicked: myPage.destroy()
            }
        }
    }
}