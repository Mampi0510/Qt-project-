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
                text: "Statistiques & Analytics"
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

                                Text {
                                    text: modelData.total_revenue.toFixed(2) + " €"
                                    font.pixelSize: 18
                                    font.weight: Font.Medium
                                    color: "#030213"
                                    Layout.preferredWidth: 120
                                    horizontalAlignment: Text.AlignRight
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

                    Text { text: "Distribution par Catégorie"; font.pixelSize: 20; font.weight: Font.Medium; color: "#030213" }

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

                                    Text { text: modelData.category; font.pixelSize: 16; font.weight: Font.Medium; color: "#030213" }
                                    Text { text: modelData.count + " plat(s)"; font.pixelSize: 14; color: "#717182" }

                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 8
                                        color: "#e5e5e5"
                                        radius: 4

                                        Rectangle {
                                            width: parent.width * (modelData.count / platModel.count)
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
                if (detail.id_plat === platItem.id_plat) {
                    nb += detail.quantite
                    total += detail.quantite * detail.prix_unitaire
                }
            }

            stats.push({
                id: platItem.id_plat,
                nom_plat: platItem.nom_plat,
                nb_commandes: nb,
                total_revenue: total
            })
        }
        stats.sort(function(a,b){return b.nb_commandes - a.nb_commandes})
        return stats
    }

    function getCategoryStats() {
        var categories = {}
        for (var i = 0; i < platModel.count; i++) {
            var cat = platModel.get(i).categorie
            if (categories[cat]) categories[cat]++
            else categories[cat] = 1
        }

        var result = []
        for (var key in categories) {
            result.push({ category: key, count: categories[key] })
        }
        return result
    }
}
