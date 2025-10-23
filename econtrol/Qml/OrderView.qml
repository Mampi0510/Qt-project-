import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Item {
    id: root

    property var dishesModel
    property var clientsModel
    property var ordersModel

    function updateTotal() {
        var total = 0
        for (var i = 0; i < orderItemsModel.count; i++) {
            var item = orderItemsModel.get(i)
            total += item.prix * item.quantite
        }
        orderDialog.orderTotal = total
        console.log("Total MaJ :", total)
    }

    Dialog {
        id: orderDialog
        title: "Nouvelle Commande"
        standardButtons: Dialog.Save | Dialog.Cancel

        modal: true
        anchors.centerIn: parent
        width: 600
        height: 500

        property real orderTotal: 0

        ColumnLayout {
            anchors.fill: parent
            spacing: 16

            Text {
                text: "Sélectionner un client"
                font.pixelSize: 14
                font.weight: Font.Medium
            }

            ComboBox {
                id: clientCombo
                Layout.fillWidth: true
                model: clientsModel
                textRole: "nom"
                displayText: currentIndex >= 0 ? clientsModel.get(currentIndex).prenom + " " + clientsModel.get(currentIndex).nom : "Choisir un client"
            }

            Text {
                text: "Ajouter des plats"
                font.pixelSize: 14
                font.weight: Font.Medium
                Layout.topMargin: 16
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                ComboBox {
                    id: dishCombo
                    Layout.fillWidth: true
                    model: dishesModel
                    textRole: "nom_plat"
                }

                SpinBox {
                    id: quantitySpin
                    from: 1
                    to: 99
                    value: 1
                    Layout.preferredWidth: 100
                    onValueModified: root.updateTotal()
                }

                Button {
                    text: "Ajouter"

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
                            var dish = dishesModel.get(dishCombo.currentIndex)
                            orderItemsModel.append({
                                id_plat: dish.id_plat,
                                nom_plat: dish.nom_plat,
                                prix: dish.prix,
                                quantite: quantitySpin.value
                            })
                            root.updateTotal()
                        }
                    }
                }
            }

            // Order items list
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: orderItemsModel
                clip: true
                spacing: 8

                ListModel {
                    id: orderItemsModel
                }

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
                            text: nom_plat
                            font.pixelSize: 14
                            color: "#030213"
                            Layout.fillWidth: true
                        }

                        Text {
                            text: "x" + quantite
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: "#030213"
                        }

                        Text {
                            text: (prix * quantite).toFixed(2) + " €"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: "#030213"
                            Layout.preferredWidth: 80
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
                                orderItemsModel.remove(index)
                                root.updateTotal()
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "#e5e5e5"
            }

            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "Total:"
                    font.pixelSize: 18
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Text {
                    id: totalText
                    text: orderDialog.orderTotal.toFixed(2) + " €"
                    font.pixelSize: 24
                    font.weight: Font.Medium
                    color: "#030213"
                }
            }
        }

        onAccepted: {
            if (clientCombo.currentIndex >= 0 && orderItemsModel.count > 0) {
                var client = clientsModel.get(clientCombo.currentIndex)
                var total = 0
                for (var i = 0; i < orderItemsModel.count; i++) {
                    var item = orderItemsModel.get(i)
                    total += item.prix * item.quantite
                }

                var newId = ordersModel.count + 1
                var now = new Date()
                var dateStr = Qt.formatDateTime(now, "yyyy-MM-ddThh:mm:ss")

                var ok = gdManager.addCommande(dateStr, total,client.id_client)
                if (ok) {
                    console.log("commande enregistree. Client :",client.nom)
                    var data = gdManager.getCommandes()
                    ordersModel.clear()
                    for (var j = 0; j < data.length; j++)
                    ordersModel.append(data[j])
                } else {
                    console.log("Erreur lors de l'ajout")
                }

                orderItemsModel.clear()
                orderDialog.orderTotal = 0
            }
        }

        onRejected: {
            orderItemsModel.clear()
            orderDialog.orderTotal = 0
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            // Header with Add Button
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

            // Orders List
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

                    Text {
                        text: "Toutes les commandes"
                        font.pixelSize: 20
                        font.weight: Font.Medium
                        color: "#030213"
                    }

                    // Table Header
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
                                text: "N° Commande"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 100
                            }

                            Text {
                                text: "Client"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.fillWidth: true
                            }

                            Text {
                                text: "Date & Heure"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 150
                            }

                            Text {
                                text: "Total"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 100
                                horizontalAlignment: Text.AlignRight
                            }
                        }
                    }

                    // Table Content
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: ordersModel
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
                                    text: "#" + id_commande
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#030213"
                                    Layout.preferredWidth: 100
                                }

                                Text {
                                    text: prenom_client + " " + nom_client
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: Qt.formatDateTime(new Date(date_commande), "dd-MM-yyyy hh:mm:ss")
                                    font.pixelSize: 14
                                    color: "#717182"
                                    Layout.preferredWidth: 150
                                }


                                Text {
                                    text: total.toFixed(2) + " €"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#030213"
                                    Layout.preferredWidth: 100
                                    horizontalAlignment: Text.AlignRight
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
