import QtQuick
import QtQuick.Controls
import "../db/Database.js" as JS

Page {
    id: myPage
    width: parent.width
    height: parent.height

    Column {
        anchors.fill: parent
        Button {
            text: "Назад"
            onClicked: myPage.destroy()
        }

        Rectangle {
            width: 150
            height: 50
            radius: 7
            color: "azure"
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "Книги"
                font.pointSize: 18; font.bold: true
                anchors.centerIn: parent
            }
        }

        Item {
            width: 1
            height: 51
        }

        ListView {
            width: parent.width
            height: 150
            model: booksModel

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

        Item {
            width: 1
            height: 55
        }

        Rectangle {
            width: 200
            height: 50
            radius: 7
            color: "azure"
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "Канцелярия"
                font.pointSize: 18; font.bold: true
                anchors.centerIn: parent
            }
        }

        Item {
            width: 1
            height: 51
        }

        ListView {
            width: parent.width
            height: 150
            model: stationeryModel

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