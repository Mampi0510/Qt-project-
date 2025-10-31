import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Effects

Item {
    id: root
    anchors.fill: parent

    property var factureData: ({})
    property var detailsData: ({})
    property int commandeCount: 0

    Connections {
            target: commandeModel
            function onCountChanged() {
                commandeCount = commandeModel.rowCount()
            }
        }


    function updateTotal() {
        var total = 0
        for (var i = 0; i < orderItems.count; i++) {
            var item = orderItems.get(i)
            total += item.prix * item.quantite
        }
        orderDialog.orderTotal = total
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            // HEADER
            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 24
                Layout.rightMargin: 24

                Text {
                    text: "Gestion des Commandes"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Nouvelle Commande"
                    background: Rectangle {
                        color: parent.pressed ? "#1a1a2e" : (parent.hovered ? "#2a2a3e" : "#030213")
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: orderDialog.open()
                }
            }

            // TABLE
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 600
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

                    // HEADER ROW
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
                            Text { text: "Date"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 140 }
                            Text { text: "Actions"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 160 }
                        }
                    }

                    // TABLE CONTENT
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: commandeModel
                        spacing: 8
                        clip: true

                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 60
                            color: "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                Text { text: "#" + id_commande; font.pixelSize: 14; color: "#030213"; Layout.preferredWidth: 60 }
                                Text { text: getClientName(id_client); font.pixelSize: 14; color: "#030213"; Layout.fillWidth: true }
                                Text { text: formatDateTime(date_commande); font.pixelSize: 14; color: "#717182"; Layout.preferredWidth: 140 }

                                RowLayout {
                                    Layout.preferredWidth: 200
                                    spacing: 8

                                    Button {
                                        text: "Facture"
                                        Layout.preferredHeight: 32
                                        background: Rectangle {
                                            color: parent.pressed ? "#0c8040" : (parent.hovered ? "#13a057" : "#17b863")
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: "#ffffff"
                                            anchors.centerIn: parent
                                        }
                                        onClicked: factureDialog.openFacture(id_commande)
                                    }

                                    Button {
                                        text: "Supprimer"
                                        Layout.preferredHeight: 32
                                        background: Rectangle {
                                            color: parent.pressed ? "#b81633" : (parent.hovered ? "#c01838" : "#d4183d")
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: "#ffffff"
                                            anchors.centerIn: parent
                                        }
                                        onClicked: commandeModel.supprimerCommande(id_commande)
                                    }
                                }

                            }

                            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#e5e5e5" }
                        }
                    }
                }
            }
        }
    }

    Dialog {
        id: orderDialog
        title: "Nouvelle Commande"
        standardButtons: Dialog.Save | Dialog.Cancel
        modal: true
        anchors.centerIn: parent
        width: 500
        height: 450

        property real orderTotal: 0

        ColumnLayout {
            anchors.fill: parent
            spacing: 16
            anchors.margins: 16

            Text { text: "Client"; font.pixelSize: 14; font.weight: Font.Medium }

            ComboBox {
                id: clientCombo
                Layout.fillWidth: true
                model: clientModel
                textRole: "nom"
                displayText: currentIndex >= 0 ? clientModel.get(currentIndex).prenom + " " + clientModel.get(currentIndex).nom : "Choisir un client"
            }

            Text { text: "Ajouter un plat"; font.pixelSize: 14; font.weight: Font.Medium }

            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                ComboBox { id: dishCombo; Layout.fillWidth: true; model: platModel; textRole: "nom_plat" }
                SpinBox { id: qtySpin; from: 1; to: 99; value: 1; Layout.preferredWidth: 80 }

                Button {
                    text: "Ajouter"
                    Layout.preferredWidth: 100
                    background: Rectangle {
                        color: parent.pressed ? "#1a1a2e" : (parent.hovered ? "#2a2a3e" : "#030213")
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#ffffff"
                        anchors.centerIn: parent
                    }
                    onClicked: {
                        if (dishCombo.currentIndex >= 0) {
                            let dish = platModel.get(dishCombo.currentIndex)
                            orderItems.append({
                                id_plat: dish.id_plat,
                                nom_plat: dish.nom_plat,
                                prix: dish.prix,
                                quantite: qtySpin.value
                            })
                            updateTotal()
                        }
                    }
                }
            }
            ListModel { id: orderItems }

            Component.onCompleted: {
                orderItems.countChanged.connect(updateTotal)
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: orderItems
                spacing: 6
                clip: true

                onCountChanged: updateTotal()

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 40
                    color: "#f9f9fa"
                    radius: 4

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8
                        Text { text: nom_plat; font.pixelSize: 14; color: "#030213"; Layout.fillWidth: true }
                        Text { text: "x" + quantite; font.pixelSize: 14; color: "#030213" }
                        Text { text: (prix * quantite).toFixed(2) + " €"; font.pixelSize: 14; color: "#030213" }

                        Button {
                            text: "×"
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 32
                            background: Rectangle {
                                color: parent.pressed ? "#b81633" : (parent.hovered ? "#c01838" : "#d4183d")
                                radius: 6
                            }
                            contentItem: Text {
                                text: parent.text
                                font.pixelSize: 16
                                font.weight: Font.Bold
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                anchors.centerIn: parent
                            }
                            onClicked: {
                                orderItems.remove(index)
                                updateTotal()
                            }
                        }

                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Total:"; font.pixelSize: 16; font.weight: Font.Medium; Layout.fillWidth: true }
                Text { id: totalText; text: orderDialog.orderTotal.toFixed(2) + " €"; font.pixelSize: 18; font.weight: Font.Medium }
            }
        }

        onAccepted: {
            if (clientCombo.currentIndex < 0 || orderItems.count === 0) return
            var client = clientModel.get(clientCombo.currentIndex)
            var total = parseFloat(totalText.text.replace(" €", ""))
            var now = new Date()
            var dateTime = Qt.formatDateTime(now, "yyyy-MM-dd hh:mm:ss")
            var plats = []
            for (var i = 0; i < orderItems.count; i++) {
                var item = orderItems.get(i)
                plats.push({
                    "id_plat": item.id_plat,
                    "quantite": item.quantite,
                    "prix": item.prix
                })
            }
            commandeModel.ajouterCommande(client.id_client, dateTime, total, plats)
            orderItems.clear()
            orderDialog.orderTotal = 0
        }

        onRejected: {
            orderItems.clear()
            orderDialog.orderTotal = 0
        }
    }

    function getClientName(idClient) {
        for (var i = 0; i < clientModel.count; i++) {
            var c = clientModel.get(i)
            if (c.id_client === idClient)
                return c.prenom + " " + c.nom
        }
        return "Client #" + idClient
    }

    function formatDateTime(dateString) {
        if (!dateString) return ""
        var d = new Date(dateString)
        return Qt.formatDateTime(d, "dd/MM/yyyy hh:mm:ss")
    }

    // POPUP FACTURE
    Popup {
        id: factureDialog
        width: 520
        height: 640
        modal: true
        focus: true
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        property var factureData: ({})
        ListModel { id: factureItemsModel }

        background: Rectangle {
            color: "#ffffff"
            radius: 14
            border.color: "#e5e5e5"
            border.width: 1
            layer.enabled: true
            layer.smooth: true
            layer.effect: MultiEffect {
                   shadowEnabled: true
                   shadowColor: "#33000000"
                   shadowBlur: 0.6
                   shadowVerticalOffset: 6
               }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 28
            spacing: 16

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6
                Text {
                    text: "FACTURE"
                    font.pixelSize: 26
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                    color: "#0b0b10"
                }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#e5e5e5" }

            GridLayout {
                Layout.fillWidth: true
                columns: 2
                columnSpacing: 12
                rowSpacing: 6

                Text { text: "N° Facture :" ; font.bold: true; color: "#030213" }
                Text { id: factureNumTxt; text: "#" + (factureData.id || ""); color: "#030213" }

                Text { text: "Date :" ; font.bold: true; color: "#030213" }
                Text { id: factureDateTxt; text: (factureData.date || ""); color: "#030213" }

                Text { text: "Client :" ; font.bold: true; color: "#030213" }
                Text { id: factureClientTxt; text: (factureData.client || ""); color: "#030213" }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#efefef" }

            Text { text: "DÉTAIL DES ARTICLES"; font.pixelSize: 16; font.bold: true; color: "#030213" }

            Column {
                Layout.fillWidth: true
                spacing: 2

            GridLayout {
                    Layout.fillWidth: true
                    columns: 4
                    columnSpacing: 10

                    Text { text: "Article"; font.bold: true; Layout.column: 0; Layout.preferredWidth: 230 }
                    Text { text: "Qté";     font.bold: true; Layout.column: 1; Layout.preferredWidth: 40; horizontalAlignment: Text.AlignHCenter }
                    Text { text: "Prix U."; font.bold: true; Layout.column: 2; Layout.preferredWidth: 60; horizontalAlignment: Text.AlignRight }
                    Text { text: "Total";   font.bold: true; Layout.column: 3; Layout.preferredWidth: 60; horizontalAlignment: Text.AlignRight }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#f0f0f0" }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: factureItemsModel
                spacing: 6
                clip: true

                delegate: Item {
                    width: ListView.view.width
                    height: 34

                    GridLayout {
                        anchors.fill: parent
                        columns: 4
                        columnSpacing: 6

                        Text {
                            text: (nom_plat || ("Plat #" + id_plat))
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                            Layout.column: 0
                            Layout.preferredWidth: 200
                            font.pixelSize: 13
                        }

                        Text {
                            text: "x" + quantite
                            Layout.column: 1
                            Layout.preferredWidth: 40
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 13
                        }

                        Text {
                            text: prix_unitaire.toFixed(2) + " €"
                            Layout.column: 2
                            Layout.preferredWidth: 60
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 13
                        }

                        Text {
                            text: (prix_unitaire * quantite).toFixed(2) + " €"
                            Layout.column: 3
                            Layout.preferredWidth: 60
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 13
                        }
                    }
                }


            }

            Rectangle { color: "#e5e5e5"; height: 1; Layout.fillWidth: true }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "TOTAL :"; font.pixelSize: 16; font.bold: true; Layout.fillWidth: true; color: "#030213" }
                Text { id: factureTotalTxt; text: factureData.total ? factureData.total.toFixed(2) + " €" : ""; font.pixelSize: 16; font.bold: true; color: "#030213" }
            }

            Button {
                text: "Fermer"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                onClicked: factureDialog.close()
            }
        }

        // Fonction pour ouvrir et remplir la facture
        function openFacture(idCommande) {
            factureData = {}
            factureItemsModel.clear()

            // récupération des détails via le modèle C++ (devrait retourner QVariantList ou similaire)
            var rawDetails = []
            if (detailsCommandeModel && typeof detailsCommandeModel.getDetailsByCommande === "function") {
                rawDetails = detailsCommandeModel.getDetailsByCommande(idCommande)
            }

            // recherche de la commande dans commandeModel (par id_commande)
            var commande = null
            if (commandeModel) {
                for (var i = 0; i < commandeModel.rowCount(); i++) {
                    var c = commandeModel.get(i)
                    if (c.id_commande === idCommande) { commande = c; break }
                }
            }

            if (commande) {
                factureData = {
                    id: idCommande,
                    client: getClientName(commande.id_client),
                    date: formatDateTime(commande.date_commande),
                    total: commande.total
                }
            } else {
                factureData = { id: idCommande, client: "Inconnu", date: "", total: 0 }
            }

            // remplir factureItemsModel depuis rawDetails
            // rawDetails peut être un QVariantList d'objets contenant id_plat, quantite, prix_unitaire
            for (var j = 0; j < rawDetails.length; j++) {
                var d = rawDetails[j]
                // si ton DetailsCommande renvoie des clés différentes, adapte ici
                var idp = d.id_plat !== undefined ? d.id_plat : (d.platId || d.idPlat || d.id)
                var q   = d.quantite !== undefined ? d.quantite : (d.qty || d.quantity || 1)
                var pu  = d.prix_unitaire !== undefined ? d.prix_unitaire : (d.prix || d.prixUnitaire || d.prix_u || 0)

                // essayer de récupérer le nom du plat depuis platModel si disponible
                var nom = "Plat #" + idp
                if (platModel) {
                    for (var k = 0; k < platModel.rowCount(); k++) {
                        var p = platModel.get(k)
                        if (p.id_plat === idp || p.id === idp) {
                            nom = p.nom_plat || p.nom || nom
                            break
                        }
                    }
                }

                factureItemsModel.append({ id_plat: idp, nom_plat: nom, quantite: q, prix_unitaire: pu })
            }

            // mettre à jour textes visibles
            factureNumTxt.text = (factureData.id || "")
            factureClientTxt.text = (factureData.client || "")
            factureDateTxt.text = (factureData.date || "")
            factureTotalTxt.text = factureData.total ? factureData.total.toFixed(2) + " €" : ""

            open()
        }
    }

}
