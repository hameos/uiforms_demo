import QtQuick 6.5
import QtQuick.Controls 6.5

HistoryForm {
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
        let history = currentRow.history
        let entries = history.indexOf("~") === -1 ? history : history.split("~")

        tbhist.clear()

        for (let index = 0; index < entries.length; index++) {
            let entry = entries[index]
            let data = entry.split("|")

            tbhist.appendRow({
                date: data[0],
                type: data[1],
                text: data[2]
            })
        }
    }

    Connections {
        target: tableView
        function onSelectionChanged(row) { form.readData(row) }
    }

    Component.onCompleted: form.readData(indexSelectedRow)
}

