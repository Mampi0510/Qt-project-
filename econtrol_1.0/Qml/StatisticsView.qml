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
    property double totalRevenue: 0.0

    // Chargement automatique au démarrage
    Component.onCompleted: {
        console.log("StatisticsView initialisé")

        // Forcer le chargement des modèles
        if (platModel && platModel.chargerPlats) {
            platModel.chargerPlats()
        }
        if (clientModel && clientModel.chargerClients) {
            clientModel.chargerClients()
        }
        if (commandeModel && commandeModel.chargerCommandes) {
            commandeModel.chargerCommandes()
        }
        if (detailsCommandeModel && detailsCommandeModel.chargerDetails) {
            detailsCommandeModel.chargerDetails()
        }

        // Calculer le revenu total
        totalRevenue = calculateTotalRevenue()
    }

    // Connexions pour les changements de données
    Connections {
        target: platModel
        function onRowCountChanged() {
            platCount = platModel.rowCount()
            totalRevenue = calculateTotalRevenue()
        }
    }

    Connections {
        target: commandeModel
        function onRowCountChanged() {
            commandeCount = commandeModel.rowCount()
            totalRevenue = calculateTotalRevenue()
        }
    }

    Connections {
        target: detailsCommandeModel
        ignoreUnknownSignals: true
        function onDataChanged() {
            totalRevenue = calculateTotalRevenue()
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
                text: "Statistiques & Analytics"
                font.pixelSize: 32
                font.weight: Font.Medium
                color: "#030213"
                Layout.topMargin: 24
                Layout.leftMargin: 24
            }

            // Carte Revenu Total
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                color: "#030213"
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 5

                    Text {
                        text: "Revenu Total"
                        font.pixelSize: 16;
                        color: "#ffffff";
                        opacity: 0.8
                    }
                    Text {
                        text: totalRevenue.toFixed(2) + " €"
                        font.pixelSize: 48;
                        font.weight: Font.Medium;
                        color: "#ffffff"
                    }
                    Text {
                        text: commandeCount + " commandes au total";
                        font.pixelSize: 14;
                        color: "#ffffff";
                        opacity: 0.7
                    }
                }
            }

            // Section Plats Populaires
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 500
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
                        text: "Plats les Plus Populaires"
                        font.pixelSize: 20;
                        font.weight: Font.Medium;
                        color: "#030213"
                    }
                    Text {
                        text: "Classement basé sur le nombre de commandes"
                        font.pixelSize: 14;
                        color: "#717182"
                    }

                    ListView {
                        id: popularDishesList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 12
                        clip: true
                        boundsBehavior: Flickable.StopAtBounds
                        model: getPlatStats()

                        delegate: Rectangle {
                            width: popularDishesList.width
                            height: 80
                            color: "#f9f9fa"
                            radius: 8

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 20
                                anchors.rightMargin: 20
                                spacing: 20

                                Rectangle {
                                    Layout.preferredWidth: 50
                                    Layout.preferredHeight: 50
                                    radius: 25
                                    color: index === 0 ? "#FFD700" : index === 1 ? "#C0C0C0" : index === 2 ? "#CD7F32" : "#e9ebef"

                                    Text {
                                        anchors.centerIn: parent
                                        text: "#" + (index + 1)
                                        font.pixelSize: 18
                                        font.weight: Font.Medium
                                        color: index <= 2 ? "#ffffff" : "#030213"
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Text {
                                        text: modelData.nom_plat || "Plat inconnu"
                                        font.pixelSize: 16;
                                        font.weight: Font.Medium;
                                        color: "#030213"
                                        elide: Text.ElideRight
                                    }
                                    Text {
                                        text: modelData.nb_commandes + " commandes";
                                        font.pixelSize: 14;
                                        color: "#717182"
                                    }
                                }

                                Text {
                                    text: (modelData.total_revenue || 0).toFixed(2) + " €"
                                    font.pixelSize: 18
                                    font.weight: Font.Medium
                                    color: "#030213"
                                    Layout.preferredWidth: 120
                                    horizontalAlignment: Text.AlignRight
                                }
                            }
                        }

                        // Message si pas de données
                        Label {
                            anchors.centerIn: parent
                            text: "Aucune donnée disponible pour les plats populaires"
                            font.pixelSize: 16
                            color: "#717182"
                            visible: popularDishesList.count === 0
                        }
                    }
                }
            }

            // Section Distribution par Catégorie
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
                        text: "Distribution par Catégorie"
                        font.pixelSize: 20;
                        font.weight: Font.Medium;
                        color: "#030213"
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        columns: 2
                        rowSpacing: 16
                        columnSpacing: 16

                        Repeater {
                            model: getCategoryStats()

                            delegate: Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 100
                                color: "#f9f9fa"
                                radius: 8

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    spacing: 8

                                    Text {
                                        text: modelData.category || "Non catégorisé"
                                        font.pixelSize: 16;
                                        font.weight: Font.Medium;
                                        color: "#030213"
                                    }
                                    Text {
                                        text: modelData.count + " plat(s)";
                                        font.pixelSize: 14;
                                        color: "#717182"
                                    }

                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 8
                                        color: "#e5e5e5"
                                        radius: 4

                                        Rectangle {
                                            width: parent.width * (modelData.count / Math.max(platCount, 1))
                                            height: parent.height
                                            color: "#030213"
                                            radius: 4
                                        }
                                    }
                                }
                            }
                        }

                        // Message si pas de catégories
                        Label {
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignCenter
                            text: "Aucune catégorie disponible"
                            font.pixelSize: 16
                            color: "#717182"
                            visible: platCount === 0
                        }
                    }
                }
            }
        }
    }

    function calculateTotalRevenue() {
        if (!commandeModel) return 0.0

        var total = 0.0
        for (var i = 0; i < commandeModel.rowCount(); i++) {
            var cmd = commandeModel.get(i)
            if (cmd && cmd.total !== undefined) {
                total += cmd.total
            }
        }
        return total
    }

    function getPlatStats() {
        var stats = []

        if (!platModel || !detailsCommandeModel) {
            return stats
        }

        for (var i = 0; i < platModel.rowCount(); i++) {
            var platItem = platModel.get(i)
            if (!platItem) continue

            var nb = 0
            var total = 0.0

            for (var j = 0; j < detailsCommandeModel.rowCount(); j++) {
                var detail = detailsCommandeModel.get(j)
                if (detail && detail.id_plat === platItem.id_plat) {
                    nb += detail.quantite || 0
                    total += (detail.quantite || 0) * (detail.prix_unitaire || 0)
                }
            }

            stats.push({
                id: platItem.id_plat,
                nom_plat: platItem.nom_plat,
                nb_commandes: nb,
                total_revenue: total
            })
        }

        // Trier par nombre de commandes (décroissant)
        stats.sort(function(a, b){
            return (b.nb_commandes || 0) - (a.nb_commandes || 0)
        })

        return stats
    }

    function getCategoryStats() {
        var categories = {}

        if (!platModel) {
            return []
        }

        // Compter les plats par catégorie
        for (var i = 0; i < platModel.rowCount(); i++) {
            var plat = platModel.get(i)
            if (!plat) continue

            var cat = plat.categorie || "Non catégorisé"
            if (categories[cat]) {
                categories[cat]++
            } else {
                categories[cat] = 1
            }
        }

        // Convertir en tableau
        var result = []
        for (var key in categories) {
            result.push({
                category: key,
                count: categories[key]
            })
        }

        return result
    }
}
