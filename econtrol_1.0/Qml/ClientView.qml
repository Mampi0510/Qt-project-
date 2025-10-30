import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    property int clientCount: clientModel ? clientModel.rowCount() : 0

    // Recharger automatiquement quand le modèle change
    Connections {
        target: clientModel
        function onRowCountChanged() {
            console.log("RowCount changed:", clientModel.rowCount())
            clientCount = clientModel.rowCount()
        }
    }

    // Forcer le rechargement au démarrage
    Component.onCompleted: {
        console.log("ClientView initialisé")
        if (clientModel && clientModel.chargerClients) {
            clientModel.chargerClients()
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width
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

                Text {
                    text: clientCount + " client(s)"
                    font.pixelSize: 14
                    color: "#717182"
                }

                Button {
                    text: "+ Nouveau Client"
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
                        clientDialog.resetForm()
                        clientDialog.open()
                    }
                }
            }

            // Table des clients - VERSION SCROLLABLE
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(600, Math.max(200, clientCount * 60 + 100))
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
                                text: "ID";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 80
                            }
                            Text {
                                text: "NOM";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "PRÉNOM";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "TÉLÉPHONE";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 150
                            }
                            Text {
                                text: "ACTIONS";
                                font.pixelSize: 14;
                                font.weight: Font.Medium;
                                color: "#030213";
                                Layout.preferredWidth: 180
                            }
                        }
                    }

                    // Table content - VERSION SCROLLABLE
                    ListView {
                        id: clientListView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: clientModel
                        spacing: 8
                        clip: true
                        boundsBehavior: Flickable.StopAtBounds

                        delegate: Rectangle {
                            width: clientListView.width
                            height: 60
                            color: index % 2 === 0 ? "#ffffff" : "#f9f9fa"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                Text {
                                    text: model.id_client !== undefined ? model.id_client : "N/A"
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.preferredWidth: 80
                                }

                                Text {
                                    text: model.nom !== undefined ? model.nom : "N/A"
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: model.prenom !== undefined ? model.prenom : "N/A"
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: model.telephone !== undefined ? model.telephone : "N/A"
                                    font.pixelSize: 14
                                    color: "#717182"
                                    Layout.preferredWidth: 150
                                    elide: Text.ElideRight
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
                                        onClicked: {
                                            if (model.id_client !== undefined) {
                                                clientModel.supprimerClient(model.id_client)
                                            }
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

                        // Message si vide
                        Label {
                            anchors.centerIn: parent
                            text: "Aucun client trouvé"
                            font.pixelSize: 16
                            color: "#717182"
                            visible: clientListView.count === 0
                        }
                    }
                }
            }
        }
    }

    // Popup pour les clients
    Popup {
        id: clientDialog
        width: 500
        height: 400
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        anchors.centerIn: Overlay.overlay

        property bool editMode: false
        property int currentClientId: -1

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

            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: clientDialog.editMode ? "Modifier le Client" : "Nouveau Client"
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
                    onClicked: clientDialog.close()
                }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#e5e5e5" }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                Text { text: "Nom"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213" }
                TextField {
                    id: nomField
                    Layout.fillWidth: true
                    placeholderText: "Entrez le nom"
                    background: Rectangle {
                        color: "#f9f9fa"
                        radius: 6
                        border.color: parent.activeFocus ? "#030213" : "#e5e5e5"
                        border.width: 1
                    }
                }

                Text { text: "Prénom"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213" }
                TextField {
                    id: prenomField
                    Layout.fillWidth: true
                    placeholderText: "Entrez le prénom"
                    background: Rectangle {
                        color: "#f9f9fa"
                        radius: 6
                        border.color: parent.activeFocus ? "#030213" : "#e5e5e5"
                        border.width: 1
                    }
                }

                Text { text: "Téléphone"; font.pixelSize: 14; font.weight: Font.Medium; color: "#030213" }
                TextField {
                    id: telephoneField
                    Layout.fillWidth: true
                    placeholderText: "Entrez le téléphone"
                    background: Rectangle {
                        color: "#f9f9fa"
                        radius: 6
                        border.color: parent.activeFocus ? "#030213" : "#e5e5e5"
                        border.width: 1
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: "#e5e5e5" }

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
                    onClicked: clientDialog.close()
                }

                Button {
                    text: clientDialog.editMode ? "Modifier" : "Créer"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    enabled: nomField.text !== "" && prenomField.text !== "" && telephoneField.text !== ""
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
                        if (clientDialog.editMode) {
                            clientModel.modifierClient(clientDialog.currentClientId, nomField.text, prenomField.text, telephoneField.text)
                        } else {
                            clientModel.ajouterClient(nomField.text, prenomField.text, telephoneField.text)
                        }
                        clientDialog.close()
                        clientDialog.resetForm()
                    }
                }
            }
        }

        function openForEdit(index) {
            editMode = true
            var client = clientModel.get(index)
            if (client) {
                currentClientId = client.id_client
                nomField.text = client.nom || ""
                prenomField.text = client.prenom || ""
                telephoneField.text = client.telephone || ""
            }
            open()
        }

        function resetForm() {
            editMode = false
            currentClientId = -1
            nomField.text = ""
            prenomField.text = ""
            telephoneField.text = ""
        }
    }
}
