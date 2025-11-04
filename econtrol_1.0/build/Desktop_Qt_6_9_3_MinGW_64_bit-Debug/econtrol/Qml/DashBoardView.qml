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
                color: "#030213"
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
                    color: "#095eac"
                    radius: 10
                    border.color: "#e5e5e5"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text { text: "Total Plats"; font.pixelSize: 14; color: "#000000" }
                        Text { text: platModel.count; font.pixelSize: 36; font.weight: Font.Medium; color: "#030213" }
                        Text { text: "plats au menu"; font.pixelSize: 12; color: "#000000" }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#ffffff"
                    radius: 10
                    border.color: "#e5e5e5"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text { text: "Total Clients"; font.pixelSize: 14; color: "#717182" }
                        Text { text: clientModel.count; font.pixelSize: 36; font.weight: Font.Medium; color: "#030213";}
                        Text { text: "clients enregistrés"; font.pixelSize: 12; color: "#717182" }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#ffffff"
                    radius: 10
                    border.color: "#e5e5e5"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text { text: "Commandes Total"; font.pixelSize: 14; color: "#717182" }
                        Text { text: commandeModel.count; font.pixelSize: 36; font.weight: Font.Medium; color: "#030213" }
                        Text { text: "commandes passées"; font.pixelSize: 12; color: "#717182" }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 550
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                Layout.bottomMargin: 24
                color: "#ffffff"
                radius: 10
                border.color: "#e5e5e5"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    Text { text: "Commandes Récentes"; font.pixelSize: 20; font.weight: Font.Medium; color: "#030213" }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        color: "#f9f9fa"
                        radius: 6

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 16
                            anchors.rightMargin: 16
                            spacing: 16

                            Text { text: "N°"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 60 }
                            Text { text: "Client"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.fillWidth: true }
                            Text { text: "Date"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 150 }
                            Text { text: "Total"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 100; horizontalAlignment: Text.AlignRight }
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
                            color: "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                Text { text: "#" + id_commande; font.pixelSize: 14; color: "#030213"; Layout.preferredWidth: 60 }
                                Text {
                                    text: getClientName(id_client);
                                    font.pixelSize: 14;
                                    color: "#030213";
                                    Layout.fillWidth: true
                                }
                                Text { text: formatDate(date_commande); font.pixelSize: 14; color: "#717182"; Layout.preferredWidth: 150 }
                                Text { text: total.toFixed(2) + " €"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 100; horizontalAlignment: Text.AlignRight }
                            }

                            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#e5e5e5" }
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
