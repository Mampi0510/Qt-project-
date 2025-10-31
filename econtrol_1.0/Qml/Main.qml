import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    id: window
    visible: true
    width: screen.width
    height: screen.height
    color: "#f8f8f8"
    title: "Econtrol - Système de gestion"

    property string currentView: "dashboard"

    Component.onCompleted: {
        clientModel.chargerClients()
        platModel.chargerPlats()
    }



    // mapping des vues à l'index du StackLayout
    property var viewMap: {
        "dashboard": 0,
        "dishes": 1,
        "clients": 2,
        "orders": 3,
        "statistics": 4,
        "stock": 5
    }

    RowLayout {
        anchors.fill: parent

        // SideBar
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.25
            color: "#ffffff"
            border.color: "#e0e0e0"

            ColumnLayout {
                anchors.fill: parent

                // Header
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    color: "transparent"
                    border.color: "#e5e5e5"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "ADMIN"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#030213"
                    }
                }

                // Menu
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: menuModel
                    delegate: menuItemDelegate
                    clip: true
                    spacing: 4

                    ListModel {
                        id: menuModel
                        ListElement { menuId: "dashboard"; label: "Tableau de bord" }
                        ListElement { menuId: "dishes"; label: "Gestion des plats" }
                        ListElement { menuId: "clients"; label: "Gestion des clients" }
                        ListElement { menuId: "orders"; label: "Commandes" }
                        ListElement { menuId: "statistics"; label: "Statistiques" }
                        ListElement { menuId: "stock"; label: "Stock" }
                    }

                    Component {
                        id: menuItemDelegate
                        Rectangle {
                            width: ListView.view.width - 8
                            height: 44
                            radius: 6

                            color: mouseArea.containsMouse
                                   ? "#e6e6e6"
                                   : currentView === menuId
                                     ? "#030213"
                                     : "transparent"

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: currentView = menuId
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 16
                                anchors.rightMargin: 16
                                spacing: 12

                                Rectangle { width: 20; height: 20; radius: 4; color: "transparent" }

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

        // Main
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#f9f9fb"

            StackLayout {
                id: stackLayout
                anchors.fill: parent

                currentIndex: viewMap[currentView]

                Loader { source: "DashBoardView.qml" }
                Loader { source: "DishModelView.qml" }
                Loader { source: "ClientView.qml" }
                Loader { source: "OrderView.qml" }
                Loader { source: "StatisticsView.qml" }
                Loader { source: "StockView.qml" }
            }
        }
    }
}
