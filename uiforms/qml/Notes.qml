import QtQuick 6.5
import QtQuick.Layouts 6.5
import QtQuick.Controls 6.5
import MyTableModel 0.1

NotesForm {
    id: form

    property int indexSelectedRow: 0

    function getCurrentRow(selectedRow) {
        let rowIndex = selectedRow >= 0 ? selectedRow : -1
        let cols = tb.columnCount()

        let res = {}
        for (let colIndex = 0; colIndex < cols; colIndex++) {
            var key = tb.headerData(colIndex, Qt.Horizontal)
            var value = (rowIndex === -1) ? "" : tb.data(tb.index(rowIndex, colIndex))
            res[key] = value
        }

        return res
    }

    function readData(selectedRow) {
        indexSelectedRow = selectedRow >= 0 ? selectedRow : -1
        let currentRow = getCurrentRow(indexSelectedRow)
        form.textArea.text = currentRow.notes

        save.enabled = true
        cancel.enabled = true
        form.textArea.enabled = true

        form.textArea.cursorPosition = form.textArea.length
        form.textArea.focus = true
    }

    function writeData(selectedRow) {
        tb.setData(tb.index(selectedRow, 9), form.textArea.text, Roles.CellRole)
        form.textArea.cursorPosition = form.textArea.length
        form.textArea.focus = true
    }

    cancel.onClicked: readData(indexSelectedRow)
    save.onClicked: writeData(indexSelectedRow)

    Connections {
        target: tableView
        function onSelectionChanged(row) { form.readData(row) }
    }

    Component.onCompleted: {
        readData(indexSelectedRow)
    }
}

