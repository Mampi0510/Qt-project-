import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import Plat 1.0
Item {
    id: root
    Plat {
}
    property var dishesModel
    property var clientsModel
    property var ordersModel

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            // Header
            Text {
                text: "Tableau de bord"
                font.pixelSize: 32
                font.weight: Font.Medium
                color: "#030213"
                Layout.topMargin: 24
                Layout.leftMargin: 24
            }

            // Statistics Cards
            GridLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                columns: 3
                rowSpacing: 16
                columnSpacing: 16

                // Total Dishes Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#ffffff"
                    radius: 10
                    border.color: "#e5e5e5"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text {
                            text: "Total Plats"
                            font.pixelSize: 14
                            color: "#717182"
                        }

                        Text {
                            text: dishesModel.count
                            font.pixelSize: 36
                            font.weight: Font.Medium
                            color: "#030213"
                        }

                        Text {
                            text: "plats au menu"
                            font.pixelSize: 12
                            color: "#717182"
                        }
                    }
                }

                // Total Clients Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#ffffff"
                    radius: 10
                    border.color: "#e5e5e5"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text {
                            text: "Total Clients"
                            font.pixelSize: 14
                            color: "#717182"
                        }

                        Text {
                            text: clientsModel.count
                            font.pixelSize: 36
                            font.weight: Font.Medium
                            color: "#030213"
                        }

                        Text {
                            text: "clients enregistrés"
                            font.pixelSize: 12
                            color: "#717182"
                        }
                    }
                }

                // Total Orders Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#ffffff"
                    radius: 10
                    border.color: "#e5e5e5"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 8

                        Text {
                            text: "Commandes Aujourd'hui"
                            font.pixelSize: 14
                            color: "#717182"
                        }

                        Text {
                            text: ordersModel.count
                            font.pixelSize: 36
                            font.weight: Font.Medium
                            color: "#030213"
                        }

                        Text {
                            text: "commandes passées"
                            font.pixelSize: 12
                            color: "#717182"
                        }
                    }
                }
            }

            // Recent Orders
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 400
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
                        text: "Commandes Récentes"
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
                                text: "N°"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.preferredWidth: 60
                            }

                            Text {
                                text: "Client"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#030213"
                                Layout.fillWidth: true
                            }

                            Text {
                                text: "Date"
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
                            height: 50
                            color: "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 16

                                Text {
                                    text: "#" + id_commande
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.preferredWidth: 60
                                }

                                Text {
                                    text: prenom_client + " " + nom_client
                                    font.pixelSize: 14
                                    color: "#030213"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: date_commande
                                    font.pixelSize: 14
                                    color: "#717182"
                                    Layout.preferredWidth: 150
                                }

                                Text {
                                    text: total.toFixed(2) + " €"
                                    font.pixelSize: 14
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
