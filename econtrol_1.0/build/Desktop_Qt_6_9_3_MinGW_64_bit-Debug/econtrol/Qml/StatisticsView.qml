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
                text: "Statistiques "
                font.pixelSize: 32
                font.weight: Font.Medium
                color: "#030213"
                Layout.topMargin: 24
                Layout.leftMargin: 24
            }

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

                    Text { text: "Revenu Total"; font.pixelSize: 16; color: "#ffffff"; opacity: 0.8 }
                    Text { text: calculateTotalRevenue() + " €"; font.pixelSize: 48; font.weight: Font.Medium; color: "#ffffff" }
                    Text { text: commandeModel.count + " commandes au total"; font.pixelSize: 14; color: "#ffffff"; opacity: 0.7 }
                }
            }

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

                    Text { text: "Plats les Plus Populaires"; font.pixelSize: 20; font.weight: Font.Medium; color: "#030213" }
                    Text { text: "Classement basé sur le nombre de commandes"; font.pixelSize: 14; color: "#717182" }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 12
                        clip: true
                        model: getPlatStats()

                        delegate: Rectangle {
                            width: ListView.view.width
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
                                    Text { text: modelData.nom_plat; font.pixelSize: 16; font.weight: Font.Medium; color: "#030213" }
                                    Text { text: modelData.nb_commandes + " commandes"; font.pixelSize: 14; color: "#717182" }
                                }

                                Item {
                                    Layout.fillWidth: true
                                    Text {
                                        anchors.right: parent.right
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: modelData.total_revenue.toFixed(2) + " €"
                                        font.pixelSize: 18
                                        font.weight: Font.Medium
                                        color: "#030213"
                                    }
                                }

                            }
                        }
                    }
                }
            }

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
                        font.pixelSize: 20
                        font.weight: Font.Medium
                        color: "#030213"
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        ScrollBar.vertical.policy: ScrollBar.AsNeeded
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                        contentWidth: parent.width

                        GridLayout {
                            width: parent.width - 20
                            columns: 2
                            rowSpacing: 16
                            columnSpacing: 16

                            Repeater {
                                model: getCategoryStats()

                                delegate: Rectangle {
                                    width: (parent.width / 2) - 12
                                    height: 100
                                    color: "#f9f9fa"
                                    radius: 8

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        spacing: 8

                                        Text {
                                            text: modelData.category
                                            font.pixelSize: 16
                                            font.weight: Font.Medium
                                            color: "#030213"
                                            wrapMode: Text.Wrap
                                        }

                                        Text {
                                            text: modelData.count + " vendu(s) — " + modelData.totalSales.toFixed(2) + " €"
                                            font.pixelSize: 14
                                            color: "#717182"
                                            wrapMode: Text.Wrap
                                        }

                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 8
                                            color: "#e5e5e5"
                                            radius: 4

                                            Rectangle {
                                                width: parent.width * (modelData.count / Math.max(1, detailsCommandeModel.count))
                                                height: parent.height
                                                color: "#030213"
                                                radius: 4
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
    }

    function calculateTotalRevenue() {
        var total = 0
        for (var i = 0; i < commandeModel.count; i++) {
            var cmd = commandeModel.get(i)
            if (cmd.total !== undefined) total += cmd.total
        }
        return total.toFixed(2)
    }

    function getPlatStats() {
        var stats = []
        for (var i = 0; i < platModel.count; i++) {
            var platItem = platModel.get(i)
            var nb = 0
            var total = 0

            for (var j = 0; j < detailsCommandeModel.count; j++) {
                var detail = detailsCommandeModel.get(j)

                var idPlat = detail.id_plat !== undefined ? detail.id_plat :
                             detail.idPlat !== undefined ? detail.idPlat :
                             detail.plat_id !== undefined ? detail.plat_id : -1

                var quantite = detail.quantite !== undefined ? detail.quantite :
                               detail.qte !== undefined ? detail.qte : 0

                var prix = detail.prix_unitaire !== undefined ? detail.prix_unitaire :
                           detail.prix !== undefined ? detail.prix : 0

                if (idPlat === platItem.id_plat || idPlat === platItem.idPlat) {
                    nb += quantite
                    total += quantite * prix
                }
            }

            stats.push({
                id: platItem.id_plat || platItem.idPlat,
                nom_plat: platItem.nom_plat || platItem.nomPlat,
                nb_commandes: nb,
                total_revenue: total
            })
        }

        // Tri décroissant par nombre de commandes
        stats.sort(function(a,b){ return b.nb_commandes - a.nb_commandes })

        return stats
    }


    function getCategoryStats() {
        var categories = {}

        // Parcourt les plats
        for (var i = 0; i < platModel.count; i++) {
            var plat = platModel.get(i)
            var cat = plat.categorie || "Autre"
            var idPlat = plat.id_plat || plat.idPlat

            // Initialise si besoin
            if (!categories[cat]) {
                categories[cat] = { category: cat, count: 0, totalSales: 0 }
            }

            // Calcule les ventes pour ce plat
            for (var j = 0; j < detailsCommandeModel.count; j++) {
                var detail = detailsCommandeModel.get(j)
                var detailIdPlat = detail.id_plat || detail.idPlat
                var qte = detail.quantite || detail.qte || 0
                var prix = detail.prix_unitaire || detail.prix || 0

                if (detailIdPlat === idPlat) {
                    categories[cat].count += qte
                    categories[cat].totalSales += qte * prix
                }
            }
        }

        // Convertit en tableau trié par count décroissant
        var result = []
        for (var key in categories) {
            result.push(categories[key])
        }
        result.sort(function(a, b) { return b.count - a.count })

        return result
    }

}
