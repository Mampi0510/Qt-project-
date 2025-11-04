import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    property string searchText: ""

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
                spacing: 12

                Text {
                    text: "Gestion des Plats"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.alignment: Qt.AlignVCenter
                }

                Item { Layout.fillWidth: true }

                TextField {
                                   id: searchField
                                   Layout.preferredWidth: 200
                                   Layout.preferredHeight: 30
                                   placeholderText: "Rechercher un plat..."
                                   font.pixelSize: 14
                                   padding: 4
                                   onTextChanged: root.searchText = text
                               }

                Button {
                    text: "+ Ajouter un plat"
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
                    onClicked: dishDialog.open()
                }
            }

            GridLayout {
                Layout.fillWidth: true
                columns: menuVisible ? 2 : 3
                rowSpacing: 16
                columnSpacing: 16

                Repeater {
                    model: platModel
                    delegate: Rectangle {
                        visible: searchField.text === "" ||
                                nom_plat.toLowerCase().includes(searchField.text.toLowerCase()) ||
                                categorie.toLowerCase().includes(searchField.text.toLowerCase())
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
                                    Layout.preferredHeight: 36
                                    background: Rectangle {
                                        color: parent.pressed ? "#0c8040" : (parent.hovered ? "#13a057" : "#17b863")
                                      //  color: parent.pressed ? "#d9d9dc" : (parent.hovered ? "#e5e5e8" : "#f3f3f5")
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
                                    onClicked: dishDialog.openForEdit(index)
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
                                        anchors.fill: parent                                     }
                                    onClicked: {
                                        confirmDeleteDialog.platId = id_plat
                                        confirmDeleteDialog.open()
                                    }
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
            nomPlatField.text = item.nom_plat
            prixField.text = Number(item.prix).toFixed(2)
            categorieCombo.currentIndex = categorieCombo.model.indexOf(item.categorie)

            open()
        }
    }
    Dialog {
        id: confirmDeleteDialog
        title: "Confirmation"
        modal: true
        standardButtons: Dialog.Yes | Dialog.No
        width: 350
        anchors.centerIn: parent

        property int platId: -1

        contentItem: ColumnLayout {
            spacing: 16
            Label {
                text: "Voulez-vous vraiment supprimer ce plat ?"
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }

        onAccepted: {
            if (platId !== -1) {
                platModel.supprimerPlat(platId)
                platId = -1
            }
        }

        onRejected: platId = -1
    }

}
