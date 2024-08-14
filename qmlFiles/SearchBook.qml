import QtQuick
import QtQuick.Controls
import "../db/Database.js" as JS

Page {
    id: myPage
    width: parent.width
    height: parent.height

    property string radioButtonString: "1"

    function isGenre() {
        return radioButtonString == 1
    }

    ListModel { id: bookSearchModel }

    Column {
        anchors.fill: parent
        Button {
            text: "Назад"
            onClicked: myPage.destroy()
        }
        Item {
            width: 1
            height: 9
        }
        Row {
            RadioButton {
                checked: true
                text: qsTr("Жанр  ")
                onPressed: radioButtonString = "1"
            }
            RadioButton {
                text: qsTr("Название")
                onPressed: radioButtonString = "2"
            }
        }
        Item {
            width: 1
            height: 9
        }
        TextField {
            id: searchField
            width: parent.width/4
            placeholderText: qsTr("Введите запрос")
            maximumLength: 15
        }
        Item {
            width: 1
            height: 5
        }
        Button {
            text: "Поиск"
            onClicked: {bookSearchModel.clear(), isGenre() ? JS.dbSearchBookGenre(searchField.text) : JS.dbSearchBookTitle(searchField.text)}
        }

        Item {
            width: 1
            height: 51
        }

        ListView {
            width: parent.width
            height: parent.height/1.5
            model: bookSearchModel
            delegate: Rectangle {
                width: parent.width/1.2
                height: 50
                radius: 7
                anchors.horizontalCenter: parent.horizontalCenter
                Row {
                    anchors.centerIn:parent
                    Text {
                        text: title + '_' + surname + '_' + genre + '_' + price + '_' + amount + ' '
                        font.pointSize: 10; font.bold: true
                    }
                    Button {
                        text: "Купить"
                        onClicked: {
                            shoppingSum += parseFloat(model.price)
                            shoppingModel.append({"title": model.title, "price": model.price})
                        }
                    }
                }
            }
        }
    }
}