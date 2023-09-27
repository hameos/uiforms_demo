import QtQuick 6.5
import QtQuick.Dialogs 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

import "./qml"

ApplicationWindow {
    width: 1200
    height: 780
    visible: true
    title: qsTr("Qt Quick UI Forms")

    property var rowSelected

    MessageDialog {
        id: aboutDialog
        //icon: StandardIcon.Information
        title: qsTr("About")
        text: qsTr("Based on https://stuff.mit.edu/afs/athena/software/texmaker_v5.0.2/qt57/doc/qtquickcontrols/qtquickcontrols-uiforms-example.html\n\n\n")
        buttons: MessageDialog.Ok
    }

    Action {
        id: copyAction
        text: qsTr("&Copy")
        shortcut: StandardKey.Copy
        icon.name: "edit-copy";
        enabled: (!!activeFocusItem && !!activeFocusItem["copy"])
        onTriggered: activeFocusItem.copy()
    }

    Action {
        id: cutAction
        text: qsTr("Cu&t")
        shortcut: StandardKey.Cut
        icon.name: "edit-cut"
        icon.source: "icons/cut_icon.png"
        enabled: (!!activeFocusItem && !!activeFocusItem["cut"])
        onTriggered: activeFocusItem.cut()
    }

    Action {
        id: pasteAction
        text: qsTr("&Paste")
        shortcut: StandardKey.Paste
        icon.name: "edit-paste"
        enabled: (!!activeFocusItem && !!activeFocusItem["paste"])
        onTriggered: activeFocusItem.paste()
    }

    Action {
        id: quitAction
        text: qsTr("&Close")
        shortcut: StandardKey.Backspace
        //icon.name: "edit-paste"
        enabled: true
        onTriggered: Qt.quit()
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("E&xit")
                action: quitAction
            }
        }
        Menu {
            title: qsTr("&Edit")
            MenuItem {
                action: cutAction
            }
            MenuItem {
                action: copyAction
            }
            MenuItem {
                action: pasteAction
            }
        }
        Menu {
            title: qsTr("&Help")
            MenuItem {
                text: qsTr("About...")
                onTriggered: aboutDialog.open()
            }
        }
    }

    MainForm {
        id: mainForm
        anchors.fill: parent

        Connections {
            target: mainForm.tableView
            function onSelectedRowChanged() {
                mainForm.tableView.selectionChanged(mainForm.tableView.selectedRow)
            }

            function onSelectionChanged(row) {
                let tableView = this.target
                doScrollIfRequired(tableView, row)
            }

            function doScrollIfRequired(tableView, row) {
                // scroll down so bottom item becomes fully visible
                if (tableView.bottomRow <= row) {

                    // take the last item of the table and scroll only the hidden region of its height area so that it becomes fully visible
                    let lastRow = tableView.itemAtCell(Qt.point(tableView.leftColumn,tableView.bottomRow))
                    tableView.contentY += Math.abs((lastRow.y + lastRow.height) - (tableView.contentY + tableView.height))

                    // if the last item is not visible at all, scroll its whole height so that it becomes fully visible
                    if (row !== tableView.bottomRow) {
                        tableView.contentY += lastRow.height
                    }
                } else {
                    // scroll up so top item becomes fully visible
                    if (tableView.topRow >= row) {

                        let firstRow = tableView.itemAtCell(Qt.point(tableView.leftColumn,tableView.topRow))
                        tableView.contentY -= Math.abs(tableView.contentY - firstRow.y)

                        if (row !== tableView.topRow) {
                            tableView.contentY -= firstRow.height
                        }
                    }
                }
            }
        }

        Connections {
            target: tb
            onDataChanged: { tb.modelReset() }
        }

        Connections {
            target: mainForm.tableView.Keys

            function onPressed(event) {
                if (mainForm.tableView.activeFocus) {
                    if (event.key === Qt.Key_Up) {
                        mainForm.tableView.selectedRow = Math.max(mainForm.tableView.selectedRow - 1, 0)
                        mainForm.tableView.focus = true
                    }
                    else if (event.key === Qt.Key_Down) {
                        mainForm.tableView.selectedRow = Math.min(mainForm.tableView.selectedRow + 1, mainForm.tableView.rows - 1)
                        mainForm.tableView.focus = true
                    }
                }
            }
        }
    }
}

