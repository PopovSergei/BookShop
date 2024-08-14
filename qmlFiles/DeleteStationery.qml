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
            model: stationeryModel
            delegate: Label {
                text: id + '_' + title + '_' + price + '_' + amount
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        JS.dbDeleteStationery(model.id)
                        stationeryModel.remove(model.index)
                    }
                }
            }
        }
    }
}