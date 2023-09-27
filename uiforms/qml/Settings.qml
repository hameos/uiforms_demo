import QtQuick 6.5
import QtQuick.Layouts 6.5
import QtQuick.Controls 6.5
import MyTableModel 0.1

SettingsForm {
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
        delete currentRow.notes
        delete currentRow.history

        for(let key in currentRow) {
            if (key === "title")
                form[key].currentIndex = currentRow[key] ? form.title.find(currentRow[key]) : -1
            else
                form[key].text = currentRow[key] ?? ""
        }

        save.enabled = true
        cancel.enabled = true
        gridLayout.enabled = true
    }

    function writeData(selectedRow) {
        tb.setData(tb.index(selectedRow, 0), form.customerId.text,  Roles.CellRole)
        tb.setData(tb.index(selectedRow, 1), form.firstName.text,   Roles.CellRole)
        tb.setData(tb.index(selectedRow, 2), form.lastName.text,    Roles.CellRole)
        tb.setData(tb.index(selectedRow, 3), form.title.currentText, Roles.CellRole)
        tb.setData(tb.index(selectedRow, 4), form.email.text,       Roles.CellRole)
        tb.setData(tb.index(selectedRow, 5), form.address.text,     Roles.CellRole)
        tb.setData(tb.index(selectedRow, 6), form.city.text,        Roles.CellRole)
        tb.setData(tb.index(selectedRow, 7), form.zipCode.text,     Roles.CellRole)
        tb.setData(tb.index(selectedRow, 8), form.phoneNumber.text, Roles.CellRole)
    }

    cancel.onClicked: readData(indexSelectedRow)
    save.onClicked: writeData(indexSelectedRow)

    Connections {
        target: tableView
        function onSelectionChanged(row) { form.readData(row) }
    }

    Component.onCompleted: readData(indexSelectedRow)
}

