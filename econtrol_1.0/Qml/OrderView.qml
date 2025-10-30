import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    property int commandeCount: commandeModel ? commandeModel.rowCount() : 0

    // AJOUT: Connexion pour les changements de données
    Connections {
        target: commandeModel
        function onRowCountChanged() {
            console.log("Commande rowCount changed:", commandeModel.rowCount())
            commandeCount = commandeModel.rowCount()
        }
    }

    // AJOUT: Chargement automatique au démarrage
    Component.onCompleted: {
        console.log("CommandeView initialisé")
        if (commandeModel && commandeModel.chargerCommandes) {
            commandeModel.chargerCommandes()
        }

        // Debug: vérifier l'état des modèles
        console.log("CommandeModel disponible:", !!commandeModel)
        console.log("ClientModel disponible:", !!clientModel)
        console.log("PlatModel disponible:", !!platModel)
        console.log("DetailsCommandeModel disponible:", !!detailsCommandeModel)
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            // Header
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

                // AJOUT: Affichage du count
                Text {
                    text: commandeCount + " commande(s)"
                    font.pixelSize: 14
                    color: "#717182"
                    visible: commandeCount > 0
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
                    onClicked: {
                        orderDialog.resetForm()
                        orderDialog.open()
                    }
                }
            }

            // Table des commandes
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.max(200, Math.min(500, commandeCount * 80 + 80))
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                Layout.bottomMargin: 24
                color: "#ffffff"
                radius: 10
                border.color: "#e5e5e5"
                border.width: 1
                visible: commandeCount > 0

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    // Table header
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
                                text: "ID";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 80
                            }
                            Text {
                                text: "CLIENT";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "DATE";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 120
                            }
                            Text {
                                text: "TOTAL";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 100;
                                horizontalAlignment: Text.AlignRight
                            }
                            Text {
                                text: "ACTIONS";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 150
                            }
                        }
                    }

                    // Table content
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: commandeModel
                        spacing: 8
                        clip: true
                        boundsBehavior: Flickable.StopAtBounds

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
                                    text: "#" + model.id_commande;
                                    font.pixelSize: 14;
                                    color: "#030213";
                                    Layout.preferredWidth: 80
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Text {
                                        text: getClientName(model.id_client);
                                        font.pixelSize: 14;
                                        font.weight: Font.Medium;
                                        color: "#030213";
                                    }

                                    Text {
                                        text: getPlatsDetails(model.id_commande);
                                        font.pixelSize: 12;
                                        color: "#717182";
                                        elide: Text.ElideRight
                                    }
                                }

                                Text {
                                    text: formatDate(model.date_commande);
                                    font.pixelSize: 12;
                                    color: "#717182";
                                    Layout.preferredWidth: 120
                                }

                                Text {
                                    text: model.total.toFixed(2) + " €";
                                    font.pixelSize: 16;
                                    font.weight: Font.Medium;
                                    color: "#030213";
                                    Layout.preferredWidth: 100;
                                    horizontalAlignment: Text.AlignRight
                                }

                                RowLayout {
                                    Layout.preferredWidth: 150
                                    spacing: 8

                                    Button {
                                        text: "Facture"
                                        Layout.preferredHeight: 32
                                        background: Rectangle {
                                            color: parent.pressed ? "#1a5c1a" : (parent.hovered ? "#2a7a2a" : "#2ecc71")
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: "#ffffff"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: factureDialog.showFacture(model.id_commande)
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
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: commandeModel.supprimerCommande(model.id_commande)
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

            // Message si aucune commande
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                color: "#ffffff"
                radius: 10
                border.color: "#e5e5e5"
                border.width: 1
                visible: commandeCount === 0

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 16

                    Text {
                        text: "Aucune commande trouvée"
                        font.pixelSize: 18
                        color: "#717182"
                    }

                    // AJOUT: Message de debug
                    Text {
                        text: commandeModel ? "Modèle disponible mais vide" : "Modèle non disponible"
                        font.pixelSize: 12
                        color: "#717182"
                        visible: commandeCount === 0
                    }

                    Button {
                        text: "Créer une première commande"
                        Layout.alignment: Qt.AlignCenter
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
                            orderDialog.resetForm()
                            orderDialog.open()
                        }
                    }
                }
            }
        }
    }

    // Popup pour créer une commande
    Popup {
        id: orderDialog
        width: 600
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        background: Rectangle {
            color: "#ffffff"
            radius: 8
            border.color: "#e5e5e5"
            border.width: 1
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 16
            anchors.margins: 16

            // En-tête du popup
            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "Nouvelle Commande"
                    font.pixelSize: 18
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }
                Button {
                    text: "×"
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    background: Rectangle {
                        color: parent.pressed ? "#e5e5e5" : (parent.hovered ? "#f0f0f0" : "transparent")
                        radius: 15
                    }
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 16
                        color: "#030213"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        orderDialog.resetForm()
                        orderDialog.close()
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#e5e5e5" }

            Text { text: "Sélectionner un client"; font.pixelSize: 14; font.weight: Font.Medium }

            ComboBox {
                id: clientCombo
                Layout.fillWidth: true
                model: clientModel
                textRole: "display"
                delegate: ItemDelegate {
                    width: clientCombo.width
                    text: model.prenom + " " + model.nom
                    highlighted: clientCombo.highlightedIndex === index
                }
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
                            orderDialog.updateTotal()
                        }
                    }
                }
            }

            Text {
                text: "Plats commandés:"
                font.pixelSize: 14;
                font.weight: Font.Medium
                visible: orderItemsModel.count > 0
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: orderItemsModel
                clip: true
                spacing: 8
                visible: orderItemsModel.count > 0

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

                        Text {
                            text: nom_plat;
                            font.pixelSize: 14;
                            Layout.fillWidth: true;
                            color: "#030213"
                            elide: Text.ElideRight
                        }
                        Text { text: "x" + quantite; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213" }
                        Text {
                            text: (prix * quantite).toFixed(2) + " €";
                            font.pixelSize: 14;
                            font.weight: Font.Medium;
                            color: "#030213";
                            Layout.preferredWidth: 80;
                            horizontalAlignment: Text.AlignRight
                        }

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
                            onClicked: {
                                orderItemsModel.remove(index);
                                orderDialog.updateTotal()
                            }
                        }
                    }
                }
            }

            Text {
                text: "Aucun plat ajouté"
                font.pixelSize: 14
                color: "#717182"
                Layout.alignment: Qt.AlignCenter
                visible: orderItemsModel.count === 0
            }

            Rectangle {
                Layout.fillWidth: true;
                Layout.preferredHeight: 1;
                color: "#e5e5e5"
                visible: orderItemsModel.count > 0
            }

            // TOTAL
            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "Total:";
                    font.pixelSize: 18;
                    font.weight: Font.Medium;
                    Layout.fillWidth: true;
                    color: "#030213"
                }
                Text {
                    id: totalText;
                    text: "0.00 €";
                    font.pixelSize: 24;
                    font.weight: Font.Medium;
                    color: "#030213"
                }
            }

            // BOUTONS
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                Button {
                    text: "Annuler"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    background: Rectangle {
                        color: parent.pressed ? "#d9d9dc" : (parent.hovered ? "#e5e5e8" : "#f3f3f5")
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#030213"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        orderDialog.resetForm()
                        orderDialog.close()
                    }
                }

                Button {
                    text: "Créer"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    enabled: clientCombo.currentIndex >= 0 && orderItemsModel.count > 0
                    background: Rectangle {
                        color: !parent.enabled ? "#cccccc" :
                                parent.pressed ? "#1a1a2e" : (parent.hovered ? "#2a2a3e" : "#030213")
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: parent.enabled ? "#ffffff" : "#666666"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        if (clientCombo.currentIndex < 0 || orderItemsModel.count === 0) return

                        var client = clientModel.get(clientCombo.currentIndex)
                        var total = parseFloat(totalText.text.replace(" €", ""))

                        var success = commandeModel.ajouterCommande(client.id_client, Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss"), total)

                        if (success) {
                            var lastIndex = commandeModel.rowCount() - 1
                            if (lastIndex >= 0) {
                                var newCmd = commandeModel.get(lastIndex)
                                var newCmdId = newCmd.id_commande

                                for (var j = 0; j < orderItemsModel.count; j++) {
                                    var item = orderItemsModel.get(j)
                                    detailsCommandeModel.ajouterDetail(newCmdId, item.id_plat, item.quantite, item.prix)
                                }
                            }

                            // Recharger les données après création
                            if (commandeModel.chargerCommandes) {
                                commandeModel.chargerCommandes()
                            }
                        }

                        orderDialog.resetForm()
                        orderDialog.close()
                    }
                }
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

        function resetForm() {
            orderItemsModel.clear()
            totalText.text = "0.00 €"
            clientCombo.currentIndex = -1
            quantitySpin.value = 1
            if (dishCombo.count > 0) {
                dishCombo.currentIndex = 0
            }
        }
    }

    // Popup de facture
    Popup {
        id: factureDialog
        width: 500
        height: 700
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        property int currentCommandeId: -1
        property string currentClientName: ""
        property string currentDate: ""
        property double currentTotal: 0.0

        background: Rectangle {
            color: "#ffffff"
            radius: 8
            border.color: "#e5e5e5"
            border.width: 1
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            // En-tête de la facture
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: "FACTURE"
                    font.pixelSize: 24
                    font.weight: Font.Bold
                    color: "#030213"
                    Layout.alignment: Qt.AlignCenter
                }

                Text {
                    text: "Restaurant Gastronomique"
                    font.pixelSize: 14
                    color: "#717182"
                    Layout.alignment: Qt.AlignCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#e5e5e5"
                    Layout.topMargin: 8
                    Layout.bottomMargin: 8
                }
            }

            // Informations de la commande
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                columnSpacing: 16
                rowSpacing: 8

                Text { text: "N° Facture:"; font.pixelSize: 12; color: "#717182"; font.weight: Font.Medium }
                Text { text: "#" + factureDialog.currentCommandeId; font.pixelSize: 12; color: "#030213" }

                Text { text: "Date:"; font.pixelSize: 12; color: "#717182"; font.weight: Font.Medium }
                Text { text: factureDialog.currentDate; font.pixelSize: 12; color: "#030213" }

                Text { text: "Client:"; font.pixelSize: 12; color: "#717182"; font.weight: Font.Medium }
                Text { text: factureDialog.currentClientName; font.pixelSize: 12; color: "#030213" }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "#e5e5e5"
                Layout.topMargin: 8
                Layout.bottomMargin: 8
            }

            // Détails des articles
            Text {
                text: "DÉTAIL DES ARTICLES"
                font.pixelSize: 14
                font.weight: Font.Medium
                color: "#030213"
            }

            // En-tête du tableau des articles
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: "Article"
                    font.pixelSize: 12
                    font.weight: Font.Medium
                    color: "#717182"
                    Layout.fillWidth: true
                }

                Text {
                    text: "Qté"
                    font.pixelSize: 12
                    font.weight: Font.Medium
                    color: "#717182"
                    Layout.preferredWidth: 40
                    horizontalAlignment: Text.AlignRight
                }

                Text {
                    text: "Prix U."
                    font.pixelSize: 12
                    font.weight: Font.Medium
                    color: "#717182"
                    Layout.preferredWidth: 70
                    horizontalAlignment: Text.AlignRight
                }

                Text {
                    text: "Total"
                    font.pixelSize: 12
                    font.weight: Font.Medium
                    color: "#717182"
                    Layout.preferredWidth: 70
                    horizontalAlignment: Text.AlignRight
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "#e5e5e5"
            }

            // Liste des articles
            ListView {
                id: factureItemsList
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: ListModel { id: factureItemsModel }
                spacing: 8
                clip: true

                delegate: RowLayout {
                    width: ListView.view.width
                    spacing: 8

                    Text {
                        text: nom_plat
                        font.pixelSize: 12
                        color: "#030213"
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        text: "x" + quantite
                        font.pixelSize: 12
                        color: "#030213"
                        Layout.preferredWidth: 40
                        horizontalAlignment: Text.AlignRight
                    }

                    Text {
                        text: prix_unitaire.toFixed(2) + " €"
                        font.pixelSize: 12
                        color: "#030213"
                        Layout.preferredWidth: 70
                        horizontalAlignment: Text.AlignRight
                    }

                    Text {
                        text: (prix_unitaire * quantite).toFixed(2) + " €"
                        font.pixelSize: 12
                        font.weight: Font.Medium
                        color: "#030213"
                        Layout.preferredWidth: 70
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "#e5e5e5"
            }

            // Total
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: "SOUS-TOTAL:"
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#030213"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: factureDialog.currentTotal.toFixed(2) + " €"
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#030213"
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: "TVA (10%):"
                        font.pixelSize: 12
                        color: "#717182"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: (factureDialog.currentTotal * 0.10).toFixed(2) + " €"
                        font.pixelSize: 12
                        color: "#717182"
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#030213"
                }

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: "TOTAL:"
                        font.pixelSize: 16
                        font.weight: Font.Bold
                        color: "#030213"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: (factureDialog.currentTotal * 1.10).toFixed(2) + " €"
                        font.pixelSize: 16
                        font.weight: Font.Bold
                        color: "#030213"
                    }
                }
            }

            // Boutons
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                Button {
                    text: "Fermer"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    background: Rectangle {
                        color: parent.pressed ? "#d9d9dc" : (parent.hovered ? "#e5e5e8" : "#f3f3f5")
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#030213"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: factureDialog.close()
                }

                Button {
                    text: "Imprimer"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
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
                    onClicked: printFacture()
                }
            }
        }

        function showFacture(commandeId) {
            currentCommandeId = commandeId
            factureItemsModel.clear()

            // Charger les informations de la commande
            if (commandeModel) {
                for (var i = 0; i < commandeModel.rowCount(); i++) {
                    var cmd = commandeModel.get(i)
                    if (cmd.id_commande === commandeId) {
                        currentClientName = getClientName(cmd.id_client)
                        currentDate = formatDate(cmd.date_commande)
                        currentTotal = cmd.total
                        break
                    }
                }
            }

            // Charger les détails de la commande
            if (detailsCommandeModel && platModel) {
                for (var j = 0; j < detailsCommandeModel.rowCount(); j++) {
                    var detail = detailsCommandeModel.get(j)
                    if (detail.id_commande === commandeId) {
                        for (var k = 0; k < platModel.rowCount(); k++) {
                            var plat = platModel.get(k)
                            if (plat.id_plat === detail.id_plat) {
                                factureItemsModel.append({
                                    nom_plat: plat.nom_plat,
                                    quantite: detail.quantite,
                                    prix_unitaire: detail.prix_unitaire
                                })
                                break
                            }
                        }
                    }
                }
            }

            open()
        }

        function printFacture() {
            console.log("Impression de la facture #" + currentCommandeId)
        }
    }

    function getClientName(clientId) {
        if (!clientModel) return "Client #" + clientId

        for (var i = 0; i < clientModel.rowCount(); i++) {
            var client = clientModel.get(i)
            if (client.id_client === clientId) {
                return client.prenom + " " + client.nom
            }
        }
        return "Client #" + clientId
    }

    function getPlatsDetails(commandeId) {
        if (!detailsCommandeModel || !platModel) return "Chargement..."

        var plats = []
        for (var i = 0; i < detailsCommandeModel.rowCount(); i++) {
            var detail = detailsCommandeModel.get(i)
            if (detail.id_commande === commandeId) {
                for (var j = 0; j < platModel.rowCount(); j++) {
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
