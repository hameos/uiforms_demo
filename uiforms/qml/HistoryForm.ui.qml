import QtQuick 6.5
import QtQuick.Controls 6.5
import Qt.labs.qmlmodels

Item {
    property alias tbhist: tbhist

    id: content
    width: 640
    height: 480

    Rectangle {
        anchors.fill: parent
        anchors.margins: 40
        color:  Qt.rgba(0, 0, 0, 0) // or "transparent"

        HorizontalHeaderView {
            //readonly property var columnNames: ["date", "type", "text"] // alternative 2, see delegate below

            id: horizontalHeader
            anchors.left: verticalHeader.right
            anchors.leftMargin: 1
            clip: true
            syncView: tableViewHist

            delegate: Rectangle {
                readonly property real cellPadding: 8

                implicitWidth: text.implicitWidth + (cellPadding * 2)
                implicitHeight: text.implicitHeight + (cellPadding * 2)
                color: "#f6f6f6"
                border.width: 0

                Label {
                    id: text
                    text: tbhist.columns[index].display
                    //text: parent.parent.model.columns[index].display  // alternative 1
                    //text: horizontalHeader.columnNames[index]  // alternative 2
                    width: parent.width
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#ff26282a"
                }
            }
        }

        VerticalHeaderView {
            id: verticalHeader
            anchors.top: horizontalHeader.bottom
            anchors.topMargin: 1
            clip: true
            syncView: tableViewHist
        }

        TableView {
            id: tableViewHist
            clip: true

            anchors.left: verticalHeader.right
            anchors.top: horizontalHeader.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            implicitHeight: parent.height / 2
            anchors.topMargin: 1
            anchors.leftMargin: 1

            columnSpacing: 1
            rowSpacing: 1
            boundsBehavior: Flickable.StopAtBounds

            model: TableModel {
                id: tbhist
                TableModelColumn { display: "date" }
                TableModelColumn { display: "type" }
                TableModelColumn { display: "text" }
            }

            delegate: ItemDelegate {
                text: model.display
                padding: 16
            }
        }
    }  
}
