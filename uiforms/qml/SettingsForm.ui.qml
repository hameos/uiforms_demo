import QtQuick 6.5
import QtQuick.Layouts 6.5
import QtQuick.Controls 6.5

Item {
    id: content

    property alias address: address
    property alias gridLayout: gridLayout
    property alias cancel: cancel
    property alias save: save

    property alias title: title
    property alias zipCode: zipCode
    property alias city: city
    property alias phoneNumber: phoneNumber
    property alias customerId: customerId
    property alias email: email
    property alias lastName: lastName
    property alias firstName: firstName

    GridLayout {
        id: gridLayout

        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.topMargin: 12
        columnSpacing: 8
        rowSpacing: 8
        rows: 8
        columns: 7
        enabled: false

        Label {
            id: label1
            text: qsTr("Title")
            Layout.columnSpan: 2
        }

        Label {
            id: label2
            text: qsTr("First Name")
            Layout.columnSpan: 2
        }

        Item {
            id: spacer10
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        Label {
            id: label3
            text: qsTr("Last Name")
        }

        Item {
            id: spacer15
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        ComboBox {
            id: title
            Layout.columnSpan: 2
            Layout.fillWidth: true
            model: ["Mr", "Ms", "Mrs", "Honorable", "Rev", "Dr"]
        }

        TextField {
            id: firstName
            Layout.minimumWidth: 140
            Layout.fillWidth: true
            Layout.columnSpan: 3
            placeholderText: qsTr("first name")
        }

        TextField {
            id: lastName
            Layout.minimumWidth: 140
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("last name")
        }

        Label {
            id: label4
            text: qsTr("Phone Number")
            Layout.columnSpan: 5
        }

        Label {
            id: label5
            text: qsTr("Email")
            Layout.preferredHeight: 13
            Layout.preferredWidth: 24
        }

        Item {
            id: spacer16
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: phoneNumber
            Layout.fillWidth: true
            Layout.columnSpan: 5
            placeholderText: qsTr("phone number")
        }

        TextField {
            id: email
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("email")
        }

        Label {
            id: label6
            text: qsTr("Address")
        }

        Item {
            id: spacer3
            Layout.columnSpan: 6
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: address
            Layout.fillWidth: true
            Layout.columnSpan: 7
            placeholderText: qsTr("address")
        }

        Label {
            id: label7
            text: qsTr("City")
        }

        Item {
            id: spacer4
            Layout.columnSpan: 4
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        Label {
            id: label8
            text: qsTr("Zip Code")
        }

        Item {
            id: spacer18
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: city
            Layout.fillWidth: true
            Layout.columnSpan: 5
            placeholderText: qsTr("city")
        }

        TextField {
            id: zipCode
            Layout.fillWidth: true
            Layout.columnSpan: 2
            placeholderText: qsTr("zip code")
        }

        Label {
            id: label9
            text: qsTr("Customer Id")
        }

        Item {
            id: spacer19
            Layout.columnSpan: 6
            Layout.preferredHeight: 14
            Layout.preferredWidth: 14
        }

        TextField {
            id: customerId
            Layout.columnSpan: 7
            Layout.fillWidth: true
            placeholderText: qsTr("id")
            readOnly: true
            background: Rectangle {
                border.width: 1
                color: customerId.palette.base
                border.color: customerId.palette.mid
                opacity: 0.5
            }
        }
    }

    RowLayout {
        anchors.topMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.top: gridLayout.bottom

        Button {
            id: save
            text: qsTr("Save")
            enabled: false
        }

        Button {
            id: cancel
            text: qsTr("Cancel")
            enabled: false
        }
    }
}

