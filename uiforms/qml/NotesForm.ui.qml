import QtQuick 6.5
import QtQuick.Layouts 6.5
import QtQuick.Controls 6.5

Item {
    id: content

    property alias cancel: cancel
    property alias save: save
    property alias textArea: textArea

    width: 640
    height: 480

    ColumnLayout {
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.bottomMargin: 12
        anchors.topMargin: 12
        anchors.fill: parent

        TextArea {
            id: textArea
            padding: 12
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: Rectangle {
                color: Qt.rgba(1,1,1,1)
            }

            font {
                pointSize: 18
                family: "Helvetica"
            }
            color: Qt.rgba(0,0,0,0.7)
            cursorVisible: true
        }

        RowLayout {
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
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
}
