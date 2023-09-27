import QtQuick 6.5
import QtQuick.Layouts 6.5
import QtQuick.Dialogs 6.5
import QtQuick.Controls 6.5

import "./qml"

Item {
    property alias tableView: tableView

    SplitView {
        id: splitView
        anchors.fill: parent
        orientation: Qt.Horizontal

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            implicitWidth: parent.width / 2
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent

                Rectangle {
                    color: "transparent"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Layout.margins: 24

                    HorizontalHeaderView {
                        id: horizontalHeader
                        anchors.left: verticalHeader.right
                        anchors.leftMargin: 1
                        clip: true
                        syncView: tableView
                    }

                    VerticalHeaderView {
                        id: verticalHeader
                        anchors.top: horizontalHeader.bottom
                        anchors.topMargin: 1
                        clip: true
                        syncView: tableView
                    }

                    TableView {
                        id: tableView

                        signal selectionChanged(int row)

                        clip: true
                        anchors.left: verticalHeader.right
                        anchors.top: horizontalHeader.bottom
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 1
                        anchors.leftMargin: 1

                        columnSpacing: 1
                        rowSpacing: 1

                        property int selectedRow: 0

                        model: tb

                        // tableView has 3 childrens
                        // tableView.children[0].children contains only ui visible elems (ui cells)
                        // tableView.leftColumn = > the visible left column index
                        // tableView.rightColumn => the visible right column index
                        // tableView.topRow => the visible top row index
                        // tableView.bottomRow => the visible bottom row index
                        // tableView.contentY => distance from the top when scroll.  tableView.contentY = num => it scrolls
                        delegate: ItemDelegate { // tableView.children[0]
                            objectName: `tableitem_${row}_${column}`
                            highlighted: row === tableView.selectedRow
                            onClicked: {
                                tableView.selectedRow = row
                                tableView.focus = true  // Required to get called tableView keys handler
                            }
                            text: value
                            padding: 16
                        }

                        ScrollBar.horizontal: ScrollBar {  // tableView.children[1]
                            objectName: "tableViewHScroll"
                            height: 14

                            // When scroll shown, avoid automatic hiding
                            policy: tableView.contentWidth > tableView.width ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                        }

                        ScrollBar.vertical: ScrollBar {  // tableView.children[2]
                            objectName: "tableViewVScroll"
                            width: 14

                            // When scroll shown, avoid automatic hiding
                            policy: tableView.contentHeight > tableView.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                        }

                        Component.onCompleted: this.focus = true
                    }
                }

                Item { Layout.fillHeight: true }
            }
        }

        Rectangle {
            SplitView.minimumWidth: 200
            SplitView.fillWidth: true

            color: "transparent"

            TabBar {
                id: bar
                width: parent.width
                implicitHeight: 60

                TabButton {
                    text: qsTr("Customer Settings")
                    implicitHeight: parent.height
                }
                TabButton {
                    text: qsTr("Customer Notes")
                    implicitHeight: parent.height
                }
                TabButton {
                    text: qsTr("Customer History")
                    implicitHeight: parent.height
                }
            }
            StackLayout {
                anchors {
                    top: bar.bottom
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }

                currentIndex: bar.currentIndex
                Settings {
                    id: settingsTab
                }
                Notes {
                    id: notesTab
                }
                History {
                    id: historyTab
                }
            }
        }
    }
}
