import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    Dialog {
        id: orderDialog
        title: editMode ? "Modifier la Commande" : "Nouvelle Commande"
        standardButtons: Dialog.Save | Dialog.Cancel
        modal: true
        width: 600
        height: 500

        property bool editMode: false
        property int editIndex: -1
        property int currentCommandeId: -1

        ColumnLayout {
            anchors.fill: parent
            spacing: 16
            anchors.margins: 16

            Text { text: "Sélectionner un client"; font.pixelSize: 14; font.weight: Font.Medium }

            ComboBox {
                id: clientCombo
                Layout.fillWidth: true
                model: clientModel
                textRole: "nom"
                displayText: currentIndex >= 0 ? clientModel.get(currentIndex).prenom + " " + clientModel.get(currentIndex).nom : "Choisir un client"
            }

            Text { text: "Ajouter des plats"; font.pixelSize: 14; font.weight: Font.Medium }

            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                ComboBox {
                    id: dishCombo
                    Layout.fillWidth: true
                    model: platModel
                    textRole: "nom_plat"
                }

                SpinBox {
                    id: quantitySpin
                    from: 1
                    to: 99
                    value: 1
                    Layout.preferredWidth: 100
                }

                Button {
                    text: "Ajouter"
                    Layout.preferredWidth: 120

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

                    onClicked: {
                        if (dishCombo.currentIndex >= 0) {
                            let dish = platModel.get(dishCombo.currentIndex)
                            orderItemsModel.append({
                                id_plat: dish.id_plat,
                                nom_plat: dish.nom_plat,
                                prix: dish.prix,
                                quantite: quantitySpin.value
                            })
                            updateTotal()
                        }
                    }
                }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: orderItemsModel
                clip: true
                spacing: 8

                ListModel { id: orderItemsModel }

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 50
                    color: "#f9f9fa"
                    radius: 6

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12

                        Text { text: nom_plat; font.pixelSize: 14; Layout.fillWidth: true; color: "#030213" }
                        Text { text: "x" + quantite; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213" }
                        Text { text: (prix * quantite).toFixed(2) + " €"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 80; horizontalAlignment: Text.AlignRight }

                        Button {
                            text: "×"
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 32
                            background: Rectangle {
                                color: parent.pressed ? "#b81633" : (parent.hovered ? "#c01838" : "#d4183d")
                                radius: 16
                            }
                            contentItem: Text {
                                text: parent.text
                                font.pixelSize: 18
                                color: "#ffffff"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: { orderItemsModel.remove(index); updateTotal() }
                        }
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#e5e5e5" }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Total:"; font.pixelSize: 18; font.weight: Font.Medium; Layout.fillWidth: true; color: "#030213" }
                Text { id: totalText; text: "0.00 €"; font.pixelSize: 24; font.weight: Font.Medium; color: "#030213" }
            }
        }

        function updateTotal() {
            var total = 0
            for (var i = 0; i < orderItemsModel.count; i++) {
                var item = orderItemsModel.get(i)
                total += item.prix * item.quantite
            }
            totalText.text = total.toFixed(2) + " €"
        }

        function openForEdit(index) {
            editMode = true
            editIndex = index
            var cmd = commandeModel.get(index)
            currentCommandeId = cmd.id_commande

            // Trouver le client correspondant
            for (var i = 0; i < clientModel.count; i++) {
                if (clientModel.get(i).id_client === cmd.id_client) {
                    clientCombo.currentIndex = i
                    break
                }
            }

            // CHARGER LES DÉTAILS DE LA COMMANDE
            orderItemsModel.clear()
            loadCommandeDetails(cmd.id_commande)

            // Afficher le total existant
            totalText.text = cmd.total.toFixed(2) + " €"

            open()
        }

        function loadCommandeDetails(commandeId) {
            // Charger les détails depuis detailsCommandeModel
            for (var i = 0; i < detailsCommandeModel.count; i++) {
                var detail = detailsCommandeModel.get(i)
                if (detail.id_commande === commandeId) {
                    // Trouver les informations du plat
                    for (var j = 0; j < platModel.count; j++) {
                        var plat = platModel.get(j)
                        if (plat.id_plat === detail.id_plat) {
                            orderItemsModel.append({
                                id_plat: detail.id_plat,
                                nom_plat: plat.nom_plat,
                                prix: detail.prix_unitaire,
                                quantite: detail.quantite
                            })
                            break
                        }
                    }
                }
            }
        }

        onAccepted: {
            if (clientCombo.currentIndex < 0 || orderItemsModel.count === 0) return

            var client = clientModel.get(clientCombo.currentIndex)
            var total = parseFloat(totalText.text.replace(" €", ""))

            if (editMode) {

                var cmdId = currentCommandeId


                commandeModel.modifierCommande(cmdId, client.id_client, Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss"), total)

                detailsCommandeModel.supprimerDetailParCommande(cmdId)


                for (var i = 0; i < orderItemsModel.count; i++) {
                    var item = orderItemsModel.get(i)
                    detailsCommandeModel.ajouterDetail(cmdId, item.id_plat, item.quantite, item.prix)
                }

            } else {

                var newCmdId = commandeModel.ajouterCommande(client.id_client, Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss"), total)

                for (var j = 0; j < orderItemsModel.count; j++) {
                    var item2 = orderItemsModel.get(j)
                    detailsCommandeModel.ajouterDetail(newCmdId, item2.id_plat, item2.quantite, item2.prix)
                }
            }

            resetForm()
        }

        onRejected: {
            resetForm()
        }

        function resetForm() {
            editMode = false
            editIndex = -1
            currentCommandeId = -1
            orderItemsModel.clear()
            totalText.text = "0.00 €"
            clientCombo.currentIndex = -1
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24
            anchors.margins: 24

            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "Gestion des Commandes";
                    font.pixelSize: 32;
                    font.weight: Font.Medium;
                    color: "#030213";
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Nouvelle Commande"
                    Layout.preferredWidth: 180
                    onClicked: {
                        orderDialog.editMode = false
                        orderDialog.editIndex = -1
                        orderDialog.currentCommandeId = -1
                        orderDialog.orderItemsModel.clear()
                        orderDialog.totalText.text = "0.00 €"
                        orderDialog.clientCombo.currentIndex = -1
                        orderDialog.open()
                    }
                    background: Rectangle {
                        color: "#030213";
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text;
                        font.pixelSize: 14;
                        font.weight: Font.Medium;
                        color: "#ffffff";
                        anchors.centerIn: parent
                    }
                }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: commandeModel
                clip: true
                spacing: 8

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 80
                    color: "transparent"

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16
                        spacing: 16

                        Text {
                            text: "#" + id_commande;
                            font.pixelSize: 14;
                            font.weight: Font.Medium;
                            color: "#030213";
                            Layout.preferredWidth: 80
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: getClientName(id_client);
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                            }

                            Text {
                                text: getPlatsDetails(id_commande);
                                font.pixelSize: 12;
                                color: "#717182";
                                elide: Text.ElideRight
                            }
                        }

                        Text {
                            text: formatDate(date_commande);
                            font.pixelSize: 12;
                            color: "#717182";
                            Layout.preferredWidth: 120
                        }

                        Text {
                            text: total.toFixed(2) + " €";
                            font.pixelSize: 16;
                            font.weight: Font.Medium;
                            color: "#030213";
                            Layout.preferredWidth: 80;
                            horizontalAlignment: Text.AlignRight
                        }

                        RowLayout {
                            spacing: 8
                            Layout.preferredWidth: 160

                            Button {
                                text: "Modifier"
                                onClicked: orderDialog.openForEdit(index)
                                Layout.preferredHeight: 32
                                background: Rectangle {
                                    color: parent.pressed ? "#d9d9dc" : (parent.hovered ? "#e5e5e8" : "#f3f3f5")
                                    radius: 6
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.pixelSize: 13
                                    font.weight: Font.Medium
                                    color: "#030213"
                                    anchors.centerIn: parent
                                }
                            }

                            Button {
                                text: "Supprimer"
                                onClicked: commandeModel.supprimerCommande(id_commande)
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
                            }
                        }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom;
                        width: parent.width;
                        height: 1;
                        color: "#e5e5e5"
                    }
                }
            }
        }
    }

    function getClientName(clientId) {
        for (var i = 0; i < clientModel.count; i++) {
            var client = clientModel.get(i)
            if (client.id_client === clientId) {
                return client.prenom + " " + client.nom
            }
        }
        return "Client #" + clientId
    }

    function getPlatsDetails(commandeId) {
        var plats = []
        for (var i = 0; i < detailsCommandeModel.count; i++) {
            var detail = detailsCommandeModel.get(i)
            if (detail.id_commande === commandeId) {
                for (var j = 0; j < platModel.count; j++) {
                    var plat = platModel.get(j)
                    if (plat.id_plat === detail.id_plat) {
                        plats.push(plat.nom_plat + " (x" + detail.quantite + ")")
                        break
                    }
                }
            }
        }
        return plats.slice(0, 2).join(", ") + (plats.length > 2 ? "..." : "")
    }

    function formatDate(dateString) {
        if (!dateString) return ""
        var date = new Date(dateString)
        return date.toLocaleDateString(Qt.locale(), "dd/MM/yyyy HH:mm")
    }
}
