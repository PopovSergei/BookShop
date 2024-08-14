import QtQuick
import QtQuick.Controls

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
        Item {
            width: 1
            height: 5
        }
        Label {
            text: "Cумма покупки: "  + shoppingSum
            font.pointSize: 11; font.bold: true
        }
        Item {
            width: 1
            height: 5
        }
        Rectangle {
            width: 150
            height: 50
            radius: 7
            color: "azure"
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "Корзина"
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
            height: parent.height/1.5
            model: shoppingModel

            delegate: Rectangle {
                width: parent.width/1.2
                height: 50
                radius: 7
                anchors.horizontalCenter: parent.horizontalCenter
                Row {
                    anchors.centerIn:parent
                    Text {
                        text: title + ' ' + price + ' '

                        font.pointSize: 10; font.bold: true
                    }
                    Button {
                        text: "Убрать"
                        onClicked: {
                            shoppingSum -= parseFloat(model.price)
                            shoppingModel.remove(model.index)
                        }
                    }
                }
            }
        }
    }
}