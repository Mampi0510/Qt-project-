import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 800
    title: "RestaurantPro - Système de Gestion"

    // Modèle de données pour les plats
    ListModel {
        id: dishesModel
        ListElement {
            id_plat: 1
            nom_plat: "Pizza Margheritaaaaaaaau"
            prix: 12.99
            categorie: "Pizza"
        }
        ListElement {
            id_plat: 2
            nom_plat: "Burger Classique"
            prix: 10.50
            categorie: "Burger"
        }
        ListElement {
            id_plat: 3
            nom_plat: "Salade César"
            prix: 8.99
            categorie: "Salade"
        }
        ListElement {
            id_plat: 4
            nom_plat: "Pâtes Carbonara"
            prix: 11.99
            categorie: "Pâtes"
        }
        ListElement {
            id_plat: 5
            nom_plat: "Tiramisu"
            prix: 6.50
            categorie: "Dessert"
        }
    }

    // Modèle de données pour les clients
    ListModel {
        id: clientsModel
        ListElement {
            id_client: 1
            nom: "Mahay"
            prenom: "Mampiadana"
            telephone: "0601020304"
        }
        ListElement {
            id_client: 2
            nom: "Tsiky"
            prenom: "Ny Avo"
            telephone: "0612345678"
        }
        ListElement {
            id_client: 3
            nom: "Fy"
            prenom: "Tahiantsoa"
            telephone: "0698765432"
        }
        ListElement {
            id_client: 4
            nom: "Délicia"
            prenom: "Alexiane"
            telephone: "0698765432"
        }
    }

    // Modèle de données pour les commandes
    ListModel {
        id: ordersModel
        Component.onCompleted: {
            ordersModel.append({
                id_commande: 1,
                id_client: 1,
                nom_client: "Délicia",
                prenom_client: "Alexane",
                date_commande: "2025-10-09 10:30:00",
                total: 31.48
            })
            ordersModel.append({
                id_commande: 2,
                id_client: 2,
                nom_client: "Fy",
                prenom_client: "Tahiantsoa",
                date_commande: "2025-10-09 12:15:00",
                total: 22.48
            })
            ordersModel.append({
                id_commande: 3,
                id_client: 3,
                nom_client: "Tsiky",
                prenom_client: "Ny Avo",
                date_commande: "2025-10-09 12:15:00",
                total: 22.48
            })
            ordersModel.append({
                id_commande: 4,
                id_client: 4,
                nom_client: "Mahay",
                prenom_client: "Mampiadana",
                date_commande: "2025-10-09 12:15:00",
                total: 22.48
            })
        }
    }

    property string currentView: "dashboard"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar
        Rectangle {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: "#fcfcfd"
            border.color: "#e5e5e5"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 0
                spacing: 0

                // Header
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    color: "transparent"
                    border.color: "#e5e5e5"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "RestaurantPro"
                        font.pixelSize: 20
                        font.weight: Font.Medium
                        color: "#030213"
                    }
                }

                // Menu Items
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: menuModel
                    delegate: menuItemDelegate
                    clip: true
                    spacing: 4

                    ListModel {
                        id: menuModel
                        ListElement {
                            menuId: "dashboard"
                            label: "Tableau de bord"
                            icon: "🏠"
                        }
                        ListElement {
                            menuId: "dishes"
                            label: "Gestion des plats"
                            icon: "🍽️"
                        }
                        ListElement {
                            menuId: "clients"
                            label: "Gestion des clients"
                            icon: "👥"
                        }
                        ListElement {
                            menuId: "orders"
                            label: "Commandes"
                            icon: "🛒"
                        }
                        ListElement {
                            menuId: "statistics"
                            label: "Statistiques"
                            icon: "📊"
                        }
                    }

                    Component {
                        id: menuItemDelegate

                        Rectangle {
                            width: ListView.view.width - 8
                            height: 44
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: currentView === menuId ? "#030213" : "transparent"
                            radius: 6

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onEntered: {
                                    if (currentView !== menuId) {
                                        parent.color = "#f3f3f5"
                                    }
                                }
                                onExited: {
                                    if (currentView !== menuId) {
                                        parent.color = "transparent"
                                    }
                                }
                                onClicked: {
                                    currentView = menuId
                                }
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                spacing: 12

                                Text {
                                    text: icon
                                    font.pixelSize: 18
                                }

                                Text {
                                    text: label
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: currentView === menuId ? "#ffffff" : "#030213"
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }
            }
        }

        // Main Content Area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#f9f9fa"

            StackLayout {
                anchors.fill: parent
                currentIndex: {
                    if (currentView === "dashboard") return 0
                    if (currentView === "dishes") return 1
                    if (currentView === "clients") return 2
                    if (currentView === "orders") return 3
                    if (currentView === "statistics") return 4
                    return 0
                }

                // Dashboard View
                DashBoardView {
                    dishesModel: dishesModel
                    clientsModel: clientsModel
                    ordersModel: ordersModel
                }

                // Dish Management View
                DishModelView {
                    dishesModel: dishesModel
                }

                // Client Management View
                ClientView {
                    clientsModel: clientsModel
                }

                // Order Management View
                OrderView {
                    dishesModel: dishesModel
                    clientsModel: clientsModel
                    ordersModel: ordersModel
                }

                // Statistics View
                StatisticsView {
                    dishesModel: dishesModel
                    ordersModel: ordersModel
                }
            }
        }
    }
}

