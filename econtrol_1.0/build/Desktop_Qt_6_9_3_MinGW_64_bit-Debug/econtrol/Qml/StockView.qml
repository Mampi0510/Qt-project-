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

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                spacing: 12

                Text {
                    text: "Gestion des Stocks"
                    font.pixelSize: 28
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.alignment: Qt.AlignVCenter
                }

                Item { Layout.fillWidth: true }

                TextField {
                    id: searchField
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 30
                    placeholderText: "Rechercher un produit..."
                    font.pixelSize: 14
                    padding: 4
                }

                Button {
                    text: "+ Ajouter un produit"
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
                    onClicked: stockDialog.open()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: Screen.height - 34
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

                    // En-tête
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

                            Text { text: "Produit"
                                   font.pixelSize: 14
                                   font.weight: Font.Bold
                                   color: "#030213"
                                   Layout.preferredWidth: 450
                            }
                            Text { text: "Quantité"
                                   font.pixelSize: 14
                                   font.weight: Font.Bold
                                   color: "#030213"
                                   Layout.preferredWidth: 150
                            }
                            Text { text: "Actions"
                                   font.pixelSize: 14
                                   font.weight: Font.Bold
                                   color: "#030213"
                                   Layout.preferredWidth: 160
                            }
                        }
                    }

                    // Liste des produits
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: stockModel
                        spacing: 8
                        clip: true

                        delegate: Rectangle {
                            width: ListView.view.width
                            height: visible ? 70 : 0
                            visible: searchField.text === "" || nom_produit.toLowerCase().includes(searchField.text.toLowerCase())
                            color: "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                // Produit
                                ColumnLayout {
                                    Layout.preferredWidth: parent.width * 0.45
                                    spacing: 2

                                    Text {
                                        text: nom_produit
                                        font.pixelSize: 15
                                        font.weight: Font.Medium
                                        color: "#030213"
                                        elide: Text.ElideRight
                                    }
                                }

                                // Colonne quantité
                                Item {
                                    Layout.preferredWidth: parent.width * 0.25
                                    Text {
                                        anchors.centerIn: parent
                                        text: Number(quantite).toFixed(quantite % 1 === 0 ? 0 : 2)
                                        font.pixelSize: 15
                                        color: "#030213"
                                    }
                                }

                                // Actions
                                RowLayout {
                                    Layout.preferredWidth: parent.width * 0.10
                                    spacing: 8
                                    Button {
                                        text: "Modifier"
                                        Layout.preferredHeight: 36
                                        background: Rectangle {
                                            color: parent.pressed ? "#0c8040" : (parent.hovered ? "#13a057" : "#17b863")
                                           // color: parent.pressed ? "#d9d9dc" : (parent.hovered ? "#e5e5e8" : "#f3f3f5")
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: "#030213"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            anchors.fill: parent
                                        }
                                        onClicked: stockDialog.openForEdit(index)
                                    }

                                    Button {
                                        text: "Supprimer"
                                        Layout.preferredHeight: 36
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
                                            anchors.fill: parent
                                        }
                                        onClicked: stockModel.supprimerProduit(id_produit)
                                    }
                                }
                            }

                            // Ligne de séparation
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

    Dialog {
        id: stockDialog
        title: editMode ? "Modifier le produit" : "Ajouter un produit"
        standardButtons: Dialog.Save | Dialog.Cancel
        modal: true
        width: 400
        height: 300
        anchors.centerIn: parent

        property bool editMode: false
        property int editIndex: -1

        ColumnLayout {
            anchors.fill: parent
            spacing: 12
            anchors.topMargin: 8
            anchors.margins: 10

            TextField {
                id: nomProduitField
                Layout.fillWidth: true
                placeholderText: "Nom du produit"
            }

            TextField {
                id: quantiteField
                Layout.fillWidth: true
                placeholderText: "Quantité"
                validator: DoubleValidator { bottom: 0 }
            }
        }

        onAccepted: {
            if (nomProduitField.text === "" || quantiteField.text === "") return;

            if (editMode) {
                stockModel.modifierProduit(
                    stockModel.get(editIndex).id_produit,
                    nomProduitField.text,
                    parseFloat(quantiteField.text)
                )
            } else {
                stockModel.ajouterProduit(
                    nomProduitField.text,
                    parseFloat(quantiteField.text)
                )
            }

            resetFields()
        }

        onRejected: resetFields

        function resetFields() {
            nomProduitField.text = ""
            quantiteField.text = ""
            editMode = false
            editIndex = -1
        }

        function openForEdit(index) {
            editMode = true
            editIndex = index
            var item = stockModel.get(index)
            if (!item) return
            nomProduitField.text = item.nom_produit
            quantiteField.text = item.quantite
            open()
        }
    }
}
