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

        ListView {
            width: parent.width
            height: parent.height
            model: booksModel

            delegate: Label {
                text: id + '_' + title + '_' + surname + '_' + genre + '_' + price + '_' + amount
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        JS.dbDeleteBook(model.id)
                        booksModel.remove(model.index)
                    }
                }
            }
        }
    }
}