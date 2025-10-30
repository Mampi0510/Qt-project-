import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

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
                            Text { text: "Total"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 80 }
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
                                Text { text: total.toFixed(2) + " €"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213"; Layout.preferredWidth: 80 }

                                RowLayout {
                                    Layout.preferredWidth: 160
                                    spacing: 8

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
                            console.log("[QML] Plat sélectionné :", JSON.stringify(dish))
                            orderItems.append({
                                id_plat: dish.id_plat,
                                nom_plat: dish.nom_plat,
                                prix: dish.prix,
                                quantite: qtySpin.value
                            })
                            updateTotal()
                        } else {
                            console.log("[QML] Aucun plat sélectionné !")
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
            console.log("[QML] Envoi commande avec", plats.length, "plats ->", JSON.stringify(plats))
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
}
