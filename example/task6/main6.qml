import QtQuick
import QtQuick.Window
import QtQuick.LocalStorage
import QtQuick.Controls
import "ProductDB.js" as JS

Window {
    id: window
    visible: true
    width: Screen.width / 2
    height: Screen.height / 1.8
    title: qsTr("Продукты")

    property int prodId
    property double sum

    Column {
        anchors.fill: parent
        ListView {
            id: listView
            width: parent.width
            height: parent.height - button.height
            model: ListModel { id: productModel }

            Label {
                text: "Общая сумма: " + sum
            }

            delegate: Label {
                text: id + ' ' + name + ' ' + cost
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        JS.dbDelete(model.id)
                        sum -= parseFloat(model.cost)
                        productModel.remove(model.index)
                    }
                }
            }
        }
        Button {
            id: button
            text: qsTr("Добавить")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var component = Qt.createComponent("ProductDialog.qml");
                var productDialog = component.createObject(window, {x: 100, y: 100});
                productDialog.open()
                productDialog.accepted.connect(function() {
                    sum += parseFloat(productDialog.cost)
                    prodId = JS.dbInsert(productDialog.name, productDialog.cost)
                    productModel.append({"id": prodId, "name": productDialog.name, "cost": productDialog.cost })
                    productDialog.destroy()
                });
            }
        }
        Component.onCompleted: {
            JS.dbInit()
            JS.dbReadAll()
            sum = JS.dbSum()
        }
    }
}
