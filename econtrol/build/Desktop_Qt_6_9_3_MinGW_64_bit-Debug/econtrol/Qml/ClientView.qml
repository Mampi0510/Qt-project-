import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Item {
    id: root

    property var clientsModel

    // Dialog for adding/editing clients
    Dialog {
        id: clientDialog
        title: editMode ? "Modifier le client" : "Ajouter un client"
        standardButtons: Dialog.Save | Dialog.Cancel

        property bool editMode: false
        property int editIndex: -1

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
            if (nomField.text === "" || prenomField.text === "" || telephoneField.text === "") {
                console.log("❌ Champs vides !");
                return;
            }

            let ok = dbManager.addClient(nomField.text, prenomField.text, telephoneField.text);
            if (ok) {
                console.log("✅ Client ajouté avec succès !");
                clientsModel.append({
                    id_client: clientsModel.count + 1,
                    nom: nomField.text,
                    prenom: prenomField.text,
                    telephone: telephoneField.text
                });
            } else {
                console.log("❌ Erreur lors de l'ajout !");
            }

            nomField.text = prenomField.text = telephoneField.text = "";
        }

        onRejected: {
            nomField.text = prenomField.text = telephoneField.text = "";
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
                    text: "Gestion des Clients"
                    font.pixelSize: 32
                    font.weight: Font.Medium
                    color: "#030213"
                    Layout.fillWidth: true
                }

                Button {
                    text: "+ Ajouter un client"

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

                    onClicked: clientDialog.open()
                }
            }

            // Clients Table
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
                                text: "ID"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 60
                            }

                            Text {
                                text: "Nom"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.fillWidth: true
                            }

                            Text {
                                text: "Prénom"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.fillWidth: true
                            }

                            Text {
                                text: "Téléphone"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 120
                            }

                            Text {
                                text: "Actions"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 180
                            }
                        }
                    }

                    // Table Content
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

                                Text {
                                    text: id_client
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.preferredWidth: 60
                                }

                                Text {
                                    text: nom
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: prenom
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: telephone
                                    font.pixelSize: 14
                                    color: "#717182"
                                    Layout.preferredWidth: 120
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
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        onClicked: clientDialog.openForEdit(index)
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

                                        onClicked: clientsModel.remove(index)
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
