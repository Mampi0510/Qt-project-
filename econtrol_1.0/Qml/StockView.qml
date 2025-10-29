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

                Text {
                    text: "Gestion des Stocks"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Ajouter un produit"
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
                Layout.preferredHeight: 500
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                Layout.bottomMargin: 24
                color: "#ffffff"
                radius: 10
                border.color: "#e5e5e5"
                border.width: 1

                ListView {
                    anchors.fill: parent
                    model: stockModel
                    spacing: 8
                    clip: true

                    delegate: Rectangle {
                        width: ListView.view.width
                        height: 80
                        color: "transparent"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 16
                            anchors.rightMargin: 16
                            spacing: 16

                            ColumnLayout {
                                Layout.fillWidth: true

                                Text {
                                    text: nom_produit
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#030213"
                                }

                                Text {
                                    text: quantite.toString() + " unités"
                                    font.pixelSize: 14
                                    color: "#717182"
                                }
                            }

                            RowLayout {
                                Layout.preferredWidth: 180
                                spacing: 8

                                Button {
                                    text: "Modifier"
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
                                    onClicked: stockDialog.openForEdit(index)
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
                                    onClicked: stockModel.supprimerProduit(id_produit)
                                }
                            }
                        }

                        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#e5e5e5" }
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
        anchors.centerIn: parent

        property bool editMode: false
        property int editIndex: -1

        ColumnLayout {
            anchors.fill: parent
            spacing: 16
            anchors.margins: 16

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
