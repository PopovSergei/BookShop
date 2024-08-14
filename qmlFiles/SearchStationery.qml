import QtQuick
import QtQuick.Controls
import "../db/Database.js" as JS

Page {
    id: myPage
    width: parent.width
    height: parent.height

    ListModel { id: stationerySearchModel }

    Column {
        anchors.fill: parent

        Button {
            text: "Назад"
            onClicked: myPage.destroy()
        }
        Item {
            width: 1
            height: 5
        }
        TextField {
            id: searchField
            width: parent.width/4
            placeholderText: qsTr("Введите название")
            maximumLength: 15
        }
        Item {
            width: 1
            height: 5
        }
        Button {
            text: "Поиск"
            onClicked: {stationerySearchModel.clear(), JS.dbSearchStationery(searchField.text)}
        }

        Item {
            width: 1
            height: 51
        }

        ListView {
            width: parent.width
            height: parent.height/1.5
            model: stationerySearchModel
            delegate: Rectangle {
                width: parent.width/1.2
                height: 50
                radius: 7
                anchors.horizontalCenter: parent.horizontalCenter
                Row {
                    anchors.centerIn:parent
                    Text {
                        text: title + '_' + price + '_' + amount + ' '

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