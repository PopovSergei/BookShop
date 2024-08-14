import QtQuick
import QtQuick.Window
import QtQuick.LocalStorage
import QtQuick.Controls
import "../db/Database.js" as JS

/*
14. Написать программу, моделирующую работу книжного магазина. Сведения о
каждой книге содержат:
~фамилию автора, название, жанр, цену, количество книг в магазине.
Кроме книг, в магазине продаются канцелярские товары.
Информация о каждом товаре следующая:
~название, цена, количество единиц товара в магазине.
Программа должна сообщать о товарах в магазине и создавать список покупок.
Хранение данных осуществляется в базе. С помощью меню необходимо обеспечить следующие функции:
a) добавление книги или канцелярской принадлежности;
b) удаление книги или канцелярской принадлежности;
c) поиск книги по заданному жанру или названию;
d) поиск товара по названию;
e) вывод списка всех книг и товаров, каждый список упорядочен по названию;
f) выбор товара для покупки;
g) вывод списка покупок с информацией о цене каждого товара и об итоговой стоимости покупки.
*/

ApplicationWindow {
    id: window
    visible: true
    width: 480
    height: 640
    title: qsTr("Книжный магазин")

    ListModel { id: booksModel }
    ListModel { id: stationeryModel }
    ListModel { id: shoppingModel }
    property double shoppingSum: 0

    menuBar: MenuBar {
        Menu {
            title: qsTr("Добавить")
            MenuItem {
                text: qsTr("Добавить книгу")
                onTriggered: {
                    var component = Qt.createComponent("InsertBook.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
            MenuItem {
                text: qsTr("Добавить канцелярию")
                onTriggered: {
                    var component = Qt.createComponent("InsertStationery.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
        }
        Menu {
            title: qsTr("Удалить")
            MenuItem {
                text: qsTr("Удалить книгу")
                onTriggered: {
                    var component = Qt.createComponent("DeleteBook.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
            MenuItem {
                text: qsTr("Удалить канцелярию")
                onTriggered: {
                    var component = Qt.createComponent("DeleteStationery.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
        }
        Menu {
            title: qsTr("Поиск")
            MenuItem {
                text: qsTr("Поиск книг")
                onTriggered: {
                    var component = Qt.createComponent("SearchBook.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
            MenuItem {
                text: qsTr("Поиск канцелярии")
                onTriggered: {
                    var component = Qt.createComponent("SearchStationery.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
        }
        Menu {
            title: qsTr("Список")
            MenuItem {
                text: qsTr("Список товаров")
                onTriggered: {
                    var component = Qt.createComponent("ProductList.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
            MenuItem {
                text: qsTr("Корзина")
                onTriggered: {
                    var component = Qt.createComponent("ShoppingList.qml");
                    console.log("Component Status:", component.status, component.errorString());
                    component.createObject(window);
                }
            }
        }
    }

    Item {
        anchors.fill: parent

        Image {
            anchors.centerIn: parent
            width: parent.width
            fillMode: Image.PreserveAspectFit
            source: "../assets/main.png"
        }

        Component.onCompleted: {
            JS.dbDropBooks()
            JS.dbDropStationery()
            JS.dbInit()
            JS.dbInitBooks()
            JS.dbInitStationery()

            //JS.dbReadAllBooks()
            //JS.dbReadAllStationery()
        }
    }
}
