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

            // Header
            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 24
                Layout.rightMargin: 24

                Text {
                    text: "Gestion des Plats"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Ajouter un plat"
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
                    onClicked: dishDialog.open()
                }
            }


            GridLayout {
                Layout.fillWidth: true
                columns: 2
                rowSpacing: 16
                columnSpacing: 16

                Repeater {
                    model: platModel
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 140
                        color: "#ffffff"
                        radius: 10
                        border.color: "#e5e5e5"
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: nom_plat; font.pixelSize: 18; font.weight: Font.Medium; Layout.fillWidth: true; color: "#030213" }
                                Rectangle {
                                    Layout.preferredWidth: 80
                                    Layout.preferredHeight: 24
                                    color: "#f3f3f5"
                                    radius: 12
                                    Text { anchors.centerIn: parent; text: categorie; font.pixelSize: 12; color: "#030213" }
                                }
                            }

                            Text { text: prix.toFixed(2) + " €"; font.pixelSize: 24; font.weight: Font.Medium; color: "#030213" }
                            Item { Layout.fillHeight: true }

                            RowLayout {
                                Layout.fillWidth: true
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
                                    onClicked: dishDialog.openForEdit(index)
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
                                    onClicked: platModel.supprimerPlat(id_plat)
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    Dialog {
        id: dishDialog
        title: editMode ? "Modifier le plat" : "Ajouter un plat"
        standardButtons: Dialog.Save | Dialog.Cancel
        modal: true
        width: 400
        anchors.centerIn: parent

        property bool editMode: false
        property int editIndex: -1

        ColumnLayout {
            anchors.fill: parent
            spacing: 16

            TextField { id: nomPlatField; Layout.fillWidth: true; placeholderText: "Nom du plat" }
            TextField { id: prixField; Layout.fillWidth: true; placeholderText: "Prix (€)" }
            ComboBox {
                id: categorieCombo
                Layout.fillWidth: true
                model: ["Pizza","Burger","Salade","Pâtes","Dessert","Boisson","Entrée"]
                currentIndex: 0
            }
        }

        onAccepted: {
            if (nomPlatField.text === "" || prixField.text === "") return;

            let nom = nomPlatField.text.trim();
            let prix = parseFloat(prixField.text);
            let categorie = categorieCombo.currentText;

            if (editMode) {
                platModel.modifierPlat(platModel.get(editIndex).id_plat, nom, prix, categorie)
            } else {
                platModel.ajouterPlat(nom, prix, categorie)
            }

            editMode = false
            editIndex = -1
            nomPlatField.text = prixField.text = ""
            categorieCombo.currentIndex = 0
        }

        onRejected: {
            editMode = false
            editIndex = -1
            nomPlatField.text = prixField.text = ""
            categorieCombo.currentIndex = 0
        }

        function openForEdit(index) {
            editMode = true
            editIndex = index

            let item = platModel.get(index)
            console.log("ITEM:", JSON.stringify(item)) // debug

            nomPlatField.text = item.nom_plat
            prixField.text = Number(item.prix).toFixed(2)
            categorieCombo.currentIndex = categorieCombo.model.indexOf(item.categorie)

            open()
        }
    }
}
