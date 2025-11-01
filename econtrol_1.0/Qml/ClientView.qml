import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    ScrollView {
        anchors.fill: parent
        Layout.preferredHeight: Screen.height - 24
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

            // Table
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
                                text: "ID"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                color: "#030213"
                                Layout.preferredWidth:  parent.width * 0.07
                            }
                            Text {
                                text: "Nom"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                color: "#030213"
                                Layout.preferredWidth: parent.width * 0.23
                            }
                            Text {
                                text: "Prénom"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                color: "#030213"
                                Layout.preferredWidth: parent.width * 0.23
                            }
                            Text {
                                text: "Téléphone"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                color: "#030213"
                                Layout.preferredWidth: parent.width * 0.22
                            }
                            Text {
                                text: "Actions"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                color: "#030213"
                                Layout.preferredWidth: parent.width * 0.25
                            }
                        }
                    }

                    // Table content
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: clientModel
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

                                Text { text: id_client; font.pixelSize: 14; color: "#030213"; Layout.preferredWidth: parent.width * 0.07 }
                                Text { text: nom; font.pixelSize: 14; color: "#030213"; Layout.preferredWidth: parent.width * 0.23 }
                                Text { text: prenom; font.pixelSize: 14; color: "#030213"; Layout.preferredWidth: parent.width * 0.23 }
                                Text { text: telephone; font.pixelSize: 14; color: "#717182"; Layout.preferredWidth: parent.width * 0.22 }

                                RowLayout {
                                    Layout.preferredWidth: parent.width * 0.25
                                    spacing: 8

                                    Button {
                                        text: "Modifier"
                                        Layout.preferredHeight: 32
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
                                            anchors.centerIn: parent
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
                                            anchors.centerIn: parent
                                        }

                                        onClicked: clientModel.supprimerClient(id_client)
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
        id: clientDialog
        title: editMode ? "Modifier le client" : "Ajouter un client"
        standardButtons: Dialog.Save | Dialog.Cancel
        modal: true
        anchors.centerIn: parent
        width: 400

        property bool editMode: false
        property int editIndex: -1

        ColumnLayout {
            spacing: 16
            width: parent.width

            TextField { id: nomField; Layout.fillWidth: true; placeholderText: "Nom" }
            TextField { id: prenomField; Layout.fillWidth: true; placeholderText: "Prénom" }
            TextField { id: telephoneField; Layout.fillWidth: true; placeholderText: "Téléphone" }
        }

        onAccepted: {
            if (nomField.text === "" || prenomField.text === "" || telephoneField.text === "") return;

            if (editMode) {
                let id = clientModel.get(editIndex).id_client
                clientModel.modifierClient(id, nomField.text, prenomField.text, telephoneField.text)
            } else {
                clientModel.ajouterClient(nomField.text, prenomField.text, telephoneField.text)
            }

            editMode = false
            editIndex = -1
            nomField.text = prenomField.text = telephoneField.text = ""
        }

        onRejected: {
            editMode = false
            editIndex = -1
            nomField.text = prenomField.text = telephoneField.text = ""
        }


        function openForEdit(index) {
            editMode = true
            editIndex = index

            let item = clientModel.get(index)
            if (!item) return

            nomField.text = item.nom
            prenomField.text = item.prenom
            telephoneField.text = item.telephone

            open()
        }
    }
}
