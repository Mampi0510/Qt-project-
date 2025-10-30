import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    // Propriétés pour les counts
    property int platCount: platModel ? platModel.rowCount() : 0
    property int clientCount: clientModel ? clientModel.rowCount() : 0
    property int commandeCount: commandeModel ? commandeModel.rowCount() : 0

    // Chargement automatique au démarrage
    Component.onCompleted: {
        console.log("Dashboard initialisé")

        // Forcer le chargement des modèles si disponible
        if (platModel && platModel.chargerPlats) {
            platModel.chargerPlats()
        }
        if (clientModel && clientModel.chargerClients) {
            clientModel.chargerClients()
        }
        if (commandeModel && commandeModel.chargerCommandes) {
            commandeModel.chargerCommandes()
        }

        console.log("Plats:", platCount, "Clients:", clientCount, "Commandes:", commandeCount)
    }

    // Connexions pour les changements de données
    Connections {
        target: platModel
        function onRowCountChanged() {
            platCount = platModel.rowCount()
        }
    }

    Connections {
        target: clientModel
        function onRowCountChanged() {
            clientCount = clientModel.rowCount()
        }
    }

    Connections {
        target: commandeModel
        function onRowCountChanged() {
            commandeCount = commandeModel.rowCount()
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            // Header
            Text {
                text: "Tableau de bord"
                font.pixelSize: 32
                font.weight: Font.Medium
                color: "#030213"
                Layout.topMargin: 24
                Layout.leftMargin: 24
            }

            // Cartes de statistiques
            GridLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                columns: 3
                rowSpacing: 16
                columnSpacing: 16

                // Carte Plats
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

                        Text {
                            text: "Total Plats"
                            font.pixelSize: 14;
                            color: "#717182"
                        }
                        Text {
                            text: platCount
                            font.pixelSize: 36;
                            font.weight: Font.Medium;
                            color: "#030213"
                        }
                        Text {
                            text: "plats au menu";
                            font.pixelSize: 12;
                            color: "#717182"
                        }
                    }
                }

                // Carte Clients
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

                        Text {
                            text: "Total Clients"
                            font.pixelSize: 14;
                            color: "#717182"
                        }
                        Text {
                            text: clientCount
                            font.pixelSize: 36;
                            font.weight: Font.Medium;
                            color: "#030213"
                        }
                        Text {
                            text: "clients enregistrés";
                            font.pixelSize: 12;
                            color: "#717182"
                        }
                    }
                }

                // Carte Commandes
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

                        Text {
                            text: "Commandes Total"
                            font.pixelSize: 14;
                            color: "#717182"
                        }
                        Text {
                            text: commandeCount
                            font.pixelSize: 36;
                            font.weight: Font.Medium;
                            color: "#030213"
                        }
                        Text {
                            text: "commandes passées";
                            font.pixelSize: 12;
                            color: "#717182"
                        }
                    }
                }
            }

            // Section Commandes Récentes
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 400
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

                    Text {
                        text: "Commandes Récentes"
                        font.pixelSize: 20;
                        font.weight: Font.Medium;
                        color: "#030213"
                    }

                    // En-tête du tableau
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

                            Text {
                                text: "N°";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 60
                            }
                            Text {
                                text: "Client";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "Date";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 150
                            }
                            Text {
                                text: "Total";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 100;
                                horizontalAlignment: Text.AlignRight
                            }
                        }
                    }

                    // Liste des commandes
                    ListView {
                        id: recentOrdersList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: commandeModel
                        spacing: 8
                        clip: true
                        boundsBehavior: Flickable.StopAtBounds

                        delegate: Rectangle {
                            width: recentOrdersList.width
                            height: 50
                            color: index % 2 === 0 ? "#ffffff" : "#f9f9fa"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                Text {
                                    text: "#" + (model.id_commande !== undefined ? model.id_commande : "N/A")
                                    font.pixelSize: 14;
                                    color: "#030213";
                                    Layout.preferredWidth: 60
                                }
                                Text {
                                    text: getClientName(model.id_client);
                                    font.pixelSize: 14;
                                    color: "#030213";
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }
                                Text {
                                    text: formatDate(model.date_commande);
                                    font.pixelSize: 14;
                                    color: "#717182";
                                    Layout.preferredWidth: 150
                                }
                                Text {
                                    text: (model.total !== undefined ? model.total.toFixed(2) : "0.00") + " €";
                                    font.pixelSize: 14;
                                    font.weight: Font.Medium;
                                    color: "#030213";
                                    Layout.preferredWidth: 100;
                                    horizontalAlignment: Text.AlignRight
                                }
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom;
                                width: parent.width;
                                height: 1;
                                color: "#e5e5e5"
                            }
                        }

                        // Message si pas de commandes
                        Label {
                            anchors.centerIn: parent
                            text: commandeModel ? "Aucune commande récente" : "Modèle de commandes non disponible"
                            font.pixelSize: 16
                            color: "#717182"
                            visible: recentOrdersList.count === 0
                        }
                    }
                }
            }
        }
    }

    function getClientName(clientId) {
        if (!clientModel) return "Client #" + clientId

        for (var i = 0; i < clientModel.rowCount(); i++) {
            var client = clientModel.get(i)
            if (client && client.id_client === clientId) {
                return (client.prenom || "") + " " + (client.nom || "")
            }
        }
        return "Client #" + clientId
    }

    function formatDate(dateString) {
        if (!dateString) return "N/A"
        try {
            var date = new Date(dateString)
            return date.toLocaleDateString(Qt.locale(), "dd/MM/yyyy HH:mm")
        } catch (e) {
            return dateString
        }
    }
}
