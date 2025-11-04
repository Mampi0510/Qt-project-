import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            Text {
                text: "Tableau de bord"
                font.pixelSize: 32
                font.weight: Font.Medium
                color: "#1F1F1F"
                Layout.topMargin: 24
                Layout.leftMargin: 24
            }

            GridLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                columns: 3
                rowSpacing: 16
                columnSpacing: 16


                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    radius: 12
                    color: "#095eac"
                    border.color: "#4338CA"

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text { text: "Total Plats"; font.pixelSize: 16; color: "#E0E7FF" }
                        Text { text: platModel.count; font.pixelSize: 36; font.bold: true; color: "#FFFFFF" }
                        Text { text: "plats au menu"; font.pixelSize: 12; color: "#C7D2FE" }
                    }
                }


                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    radius: 12
                    color: "#018dc6"
                    border.color: "#059669"

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text { text: "Total Clients"; font.pixelSize: 16; color: "#D1FAE5" }
                        Text { text: clientModel.count; font.pixelSize: 36; font.bold: true; color: "#FFFFFF" }
                        Text { text: "clients enregistrés"; font.pixelSize: 12; color: "#A7F3D0" }
                    }
                }


                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    radius: 12
                    color: "#11ba92"
                    border.color: "#000000"

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text { text: "Commandes Total"; font.pixelSize: 16; color: "#FEF3C7" }
                        Text { text: commandeModel.count; font.pixelSize: 36; font.bold: true; color: "#FFFFFF" }
                        Text { text: "commandes passées"; font.pixelSize: 12; color: "#FDE68A" }
                    }
                }
            }

            // ==== TABLE CARD ====
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 550
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                Layout.bottomMargin: 24
                radius: 12
                color: "#FFFFFF"
                border.color: "#E5E7EB"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    Text {
                        text: "Commandes Récentes"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#1F2937"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        color: "#F3F4F6"
                        radius: 6

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 16
                            anchors.rightMargin: 16
                            spacing: 16

                            Text { text: "N°"; font.pixelSize: 14; font.bold: true; color: "#111827"; Layout.preferredWidth: 60 }
                            Text { text: "Client"; font.pixelSize: 14; font.bold: true; color: "#111827"; Layout.fillWidth: true }
                            Text { text: "Date"; font.pixelSize: 14; font.bold: true; color: "#111827"; Layout.preferredWidth: 150 }
                            Text { text: "Total"; font.pixelSize: 14; font.bold: true; color: "#111827"; Layout.preferredWidth: 100; horizontalAlignment: Text.AlignRight }
                        }
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: commandeModel
                        spacing: 8
                        clip: true

                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 50
                            color: index % 2 === 0 ? "#F9FAFB" : "#FFFFFF"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                Text { text: "#" + id_commande; font.pixelSize: 14; color: "#111827"; Layout.preferredWidth: 60 }
                                Text {
                                    text: getClientName(id_client)
                                    font.pixelSize: 14
                                    color: "#1F2937"
                                    Layout.fillWidth: true
                                }
                                Text { text: formatDate(date_commande); font.pixelSize: 14; color: "#6B7280"; Layout.preferredWidth: 150 }
                                Text { text: total.toFixed(2) + " €"; font.pixelSize: 14; font.bold: true; color: "#111827"; Layout.preferredWidth: 100; horizontalAlignment: Text.AlignRight }
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: "#E5E7EB"
                            }
                        }
                    }
                }
            }
        }
    }

    function getClientName(clientId) {
        for (var i = 0; i < clientModel.count; i++) {
            var client = clientModel.get(i)
            if (Number(client.id_client) === Number(clientId)) {
                return client.prenom + " " + client.nom
            }
        }
        return "Client #" + clientId
    }

    function formatDate(dateString) {
        if (!dateString) return ""
        var d = new Date(dateString)
        return Qt.formatDateTime(d, "dd/MM/yyyy hh:mm:ss")
    }
}
