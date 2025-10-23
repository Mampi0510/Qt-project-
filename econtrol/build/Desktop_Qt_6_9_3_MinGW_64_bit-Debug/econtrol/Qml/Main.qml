import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 800
    title: "Gestion de restaurant - Econtrol"

    Dialog {
        id: dbErrorDialog
        title: "Erreur de connexion"
        modal: true
        standardButtons: Dialog.Ok
        visible: false

        contentItem: Text {
            text: "Impossible de se connecter à la base de données.\nVérifiez vos identifiants MySQL ou le service MySQL Workbench."
            wrapMode: Text.Wrap
            width: 300
            padding: 12
        }

        onAccepted: Qt.quit()
    }

    Component.onCompleted: {
        refreshClients()
        refreshPlats()
        refreshCommandes()
    }

    // Données pour les clients
    ListModel { id: clientsModel }

    function refreshClients() {
        clientsModel.clear()
        var data = dbManager.getClients()
        for (var i = 0; i < data.length; ++i)
            clientsModel.append(data[i])
    }

    Connections {
        target: dbManager
        function onClientsChanged() {
            refreshClients()
        }
    }

    // Données pour les plats
    ListModel { id: dishesModel }

    function refreshPlats() {
        dishesModel.clear()
        var data = dbManager.getPlats()
        for (var i =0; i < data.length; ++i)
            dishesModel.append(data[i])
    }

    Connections {
        target:  dbManager
        function onPlatsChanged() {
            refreshPlats()
        }
    }

    // Données pour les commandes
    ListModel { id: ordersModel }

    function refreshCommandes() {
        ordersModel.clear()
        var data = dbManager.getCommandes()
        for (var i = 0; i< data.length; ++i)
            ordersModel.append(data[i])
    }

    Connections {
        target: dbManager
        function onCommandesChanged() {
            refreshCommandes()
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
                            label: "Plats"
                            icon: "🍽️"
                        }
                        ListElement {
                            menuId: "clients"
                            label: "Clients"
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

