import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import Client 1.0

Item {
    id: root

    ClientController {
        id: clientController
    }

    property var client3: null

    Connections {
        target: clientController
        function onClientsChanged() {
            log("🟢 Clients rechargés")
            client3 = clientController.getClientById(
                        clientSearchField.text ? clientSearchField.text : 3)
            if (client3)
                log("✅ Client trouvé: " + client3.nom + " " + client3.prenom
                    + " (" + client3.telephone + ")")
            else
                log("❌ Aucun client trouvé avec cet ID")
        }
    }

    MessageDialog {
        id: deleteDialog
        title: "Confirmation"
        text: "Voulez-vous vraiment supprimer ce client ?"
        informativeText: "Cette action est irréversible."
        buttons: MessageDialog.Ok | MessageDialog.Cancel

        property int clientIndex: -1

        onAccepted: {
            if (clientIndex >= 0) {
                var client = clientController.clients[clientIndex]
                if (clientController.supprimerClient(client.idClient)) {
                    console.log("Client supprimé avec succès")
                } else {
                    console.log("Échec de la suppression")
                }
                clientIndex = -1
            }
        }

        onRejected: clientIndex = -1
    }

    Dialog {
        id: clientDialog
        title: editMode ? "Modifier le client" : "Ajouter un client"
        standardButtons: Dialog.Save | Dialog.Cancel

        property bool editMode: false
        property int editIndex: -1
        property int editId: -1

        modal: true
        anchors.centerIn: parent
        width: 400

        ColumnLayout {
            spacing: 16
            width: parent.width

            TextField {
                id: nomField
                Layout.fillWidth: true
                placeholderText: "Nom"
            }
            TextField {
                id: prenomField
                Layout.fillWidth: true
                placeholderText: "Prénom"
            }
            TextField {
                id: telephoneField
                Layout.fillWidth: true
                placeholderText: "Téléphone"
            }
        }

        onAccepted: {
            if (nomField.text && prenomField.text && telephoneField.text) {
                var ok
                if (editMode) {
                    ok = clientController.modifierClient(editId, nomField.text,
                                                         prenomField.text,
                                                         telephoneField.text)
                } else {
                    ok = clientController.ajouterClient(nomField.text,
                                                        prenomField.text,
                                                        telephoneField.text)
                }

                if (ok) {
                    resetFields()
                } else {
                    console.log("Échec de l’opération")
                }
            }
        }

        onRejected: resetFields()

        function resetFields() {
            nomField.text = ""
            prenomField.text = ""
            telephoneField.text = ""
            editMode = false
            editIndex = -1
            editId = -1
        }

        function openForEdit(index) {
            editMode = true
            editIndex = index
            var client = clientController.clients[index]
            editId = client.idClient
            nomField.text = client.nom
            prenomField.text = client.prenom
            telephoneField.text = client.telephone
            open()
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 24
                Layout.rightMargin: 24

                Text {
                    text: "Gestion des Clients"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Ajouter un client"
                    onClicked: {
                        clientDialog.resetFields()
                        clientDialog.open()
                    }
                }
            }

            // 🕵️‍♂️ Barre de recherche + boutons
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                spacing: 12

                TextField {
                    id: clientSearchField
                    placeholderText: "Entrer ID du client (ex: 3)"
                    Layout.preferredWidth: 180
                    inputMethodHints: Qt.ImhDigitsOnly
                }

                Button {
                    text: "🔍 Rechercher"
                    onClicked: {
                        if (clientSearchField.text) {
                            client3 = clientController.getClientById(
                                        clientSearchField.text)
                            if (client3)
                                log("✅ Client trouvé: " + client3.nom + " " + client3.prenom)
                            else
                                log("❌ Aucun client trouvé avec ID=" + clientSearchField.text)
                        }
                    }
                }

                Button {
                    text: "🔄 Rafraîchir"
                    onClicked: {
                        if (clientController.reloadClients) {
                            clientController.reloadClients()
                            log("🔄 Rafraîchissement demandé...")
                        } else {
                            log("⚠️ Fonction reloadClients non trouvée dans ClientController")
                        }
                    }
                }
            }

            // 🧍 Affichage du client trouvé
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                color: "#f0f4ff"
                radius: 8
                border.color: "#c5d3ff"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 8

                    Text {
                        text: client3 ? "👤 Client ID " + client3.idClient : "Aucun client trouvé"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#1a237e"
                    }
                    Text {
                        text: client3 ? "Nom : " + client3.nom : ""
                    }
                    Text {
                        text: client3 ? "Prénom : " + client3.prenom : ""
                    }
                    Text {
                        text: client3 ? "Téléphone : " + client3.telephone : ""
                    }
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
                                text: "ID"
                                Layout.preferredWidth: 60
                            }
                            Text {
                                text: "Nom"
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "Prénom"
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "Téléphone"
                                Layout.preferredWidth: 120
                            }
                            Text {
                                text: "Actions"
                                Layout.preferredWidth: 180
                            }
                        }
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: clientController.clients // ⚡️ DIRECTEMENT le QQmlListProperty<Client>
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

                                Text {
                                    text: idClient
                                    Layout.preferredWidth: 60
                                }
                                Text {
                                    text: nom
                                    Layout.fillWidth: true
                                }
                                Text {
                                    text: prenom
                                    Layout.fillWidth: true
                                }
                                Text {
                                    text: telephone
                                    Layout.preferredWidth: 120
                                }

                                RowLayout {
                                    Layout.preferredWidth: 180
                                    spacing: 8

                                    Button {
                                        text: "Modifier"
                                        onClicked: clientDialog.openForEdit(
                                                       index)
                                    }

                                    Button {
                                        text: "Supprimer"
                                        onClicked: {
                                            deleteDialog.clientIndex = index
                                            deleteDialog.open()
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: "#e5e5e5"
                            }
                        }
                    }
                }
            }
        }
    }
}

/*

import QtQuick 2.15


import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import Client 1.0


Item {
    id: root

    ClientController {
        id: clientController
    }


    MessageDialog {
        id: deleteDialog
        title: "Confirmation"
        text: "Voulez-vous vraiment supprimer ce client ?"
        informativeText: "Cette action est irréversible."
        buttons: MessageDialog.Ok | MessageDialog.Cancel

        property int clientIndex: -1

        onAccepted: {
            if (clientIndex >= 0) {
                var id = clientsModel.get(clientIndex).id_client
                var ok = clientController.supprimerClient(id)
                if (ok) {
                    refreshClients()
                    console.log(" Client supprimé avec succès")
                } else {
                    console.log(" Échec de la suppression")
                }
                clientIndex = -1
            }
        }

        onRejected: clientIndex = -1
    }


    property var clientsModel: ListModel {}

    Component.onCompleted: {
        refreshClients()
    }

    function refreshClients() {
        clientsModel.clear()
        for (var i = 0; i < clientController.clients.length; ++i) {
            var c = clientController.clients[i]
            clientsModel.append({
                id_client: c.idClient,
                nom: c.nom,
                prenom: c.prenom,
                telephone: c.telephone
            })
        }
    }


    Dialog {
        id: clientDialog
        title: editMode ? "Modifier le client" : "Ajouter un client"
        standardButtons: Dialog.Save | Dialog.Cancel

        property bool editMode: false
        property int editIndex: -1
        property int editId: -1

        modal: true
        anchors.centerIn: parent
        width: 400

        ColumnLayout {
            spacing: 16
            width: parent.width

            TextField { id: nomField; Layout.fillWidth: true; placeholderText: "Nom" }
            TextField { id: prenomField; Layout.fillWidth: true; placeholderText: "Prénom" }
            TextField { id: telephoneField; Layout.fillWidth: true; placeholderText: "Téléphone" }
        }

        onAccepted: {
            if (nomField.text && prenomField.text && telephoneField.text) {
                var ok
                if (editMode) {
                    ok = clientController.modifierClient(editId, nomField.text, prenomField.text, telephoneField.text)
                } else {
                    ok = clientController.ajouterClient(nomField.text, prenomField.text, telephoneField.text)
                }

                if (ok) {
                    refreshClients()
                    resetFields()
                } else {
                    console.log("❌ Échec de l’opération")
                }
            }
        }

        onRejected: resetFields()

        function resetFields() {
            nomField.text = ""
            prenomField.text = ""
            telephoneField.text = ""
            editMode = false
            editIndex = -1
            editId = -1
        }

        function openForEdit(index) {
            editMode = true
            editIndex = index
            var item = clientsModel.get(index)
            editId = item.id_client
            nomField.text = item.nom
            prenomField.text = item.prenom
            telephoneField.text = item.telephone
            open()
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 24
                Layout.rightMargin: 24

                Text {
                    text: "Gestion des Clients"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Ajouter un client"
                    onClicked: {
                        clientDialog.resetFields()
                        clientDialog.open()
                    }
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

                            Text { text: "ID"; Layout.preferredWidth: 60 }
                            Text { text: "Nom"; Layout.fillWidth: true }
                            Text { text: "Prénom"; Layout.fillWidth: true }
                            Text { text: "Téléphone"; Layout.preferredWidth: 120 }
                            Text { text: "Actions"; Layout.preferredWidth: 180 }
                        }
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: clientsModel
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

                                Text { text: id_client; Layout.preferredWidth: 60 }
                                Text { text: nom; Layout.fillWidth: true }
                                Text { text: prenom; Layout.fillWidth: true }
                                Text { text: telephone; Layout.preferredWidth: 120 }

                                RowLayout {
                                    Layout.preferredWidth: 180
                                    spacing: 8

                                    Button {
                                        text: "Modifier"
                                        onClicked: clientDialog.openForEdit(index)
                                    }

                                    Button {
                                        text: "Supprimer"
                                        onClicked: {
                                            deleteDialog.clientIndex = index
                                            deleteDialog.open()
                                        }
                                    }

                                }
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: "#e5e5e5"
                            }
                        }
                    }
                }
            }
        }
    }
}


*/

