import QtQuick 2.15
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
    property bool menuVisible: true

    property var viewMap: {
        "dashboard": 0,
        "dishes": 1,
        "clients": 2,
        "orders": 3,
        "statistics": 4,
        "stock": 5
    }

    Component.onCompleted: {
        clientModel.chargerClients()
        platModel.chargerPlats()
    }

    RowLayout {
        anchors.fill: parent

        Rectangle {
            id: sidebar
            Layout.fillHeight: true
            Layout.preferredWidth: menuVisible ? parent.width * 0.25 : 0
            color: "#ffffff"
            border.color: "#e0e0e0"
            clip: true

            Behavior on width {
                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
            }


            ColumnLayout {
                id: menuContent
                anchors.fill: parent
                opacity: menuVisible ? 1 : 0
                visible: true

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }


                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    color: "transparent"
                    border.color: "#e5e5e5"
                    border.width: 1

                        Text {
                            text: "ADMIN"
                            anchors.centerIn: parent
                            font.pixelSize: 32
                            font.bold: true
                            color: "#030213"
                            Layout.fillWidth: true
                            verticalAlignment: Text.AlignVCenter
                        }
                }


                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: menuModel
                    delegate: menuItemDelegate
                    clip: true
                    spacing: 4
                }
            }
        }


        Rectangle {
            id: toggleButton
            width: 20
            Layout.fillHeight: true
            color: "transparent"

            Button {
                anchors.centerIn: parent
                text: menuVisible ? "⮜" : "⮞"
                background: Rectangle { color: "#030213"; radius: 6 }
                font.pixelSize: 18
                onClicked: menuVisible = !menuVisible
                contentItem: Text {
                    text: parent.text
                    color: "#ffffff"
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }


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

                Image {
                    width: 22
                    height: 22
                    source: "qrc:/assets/icons/" + menuId + ".svg"
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                }

                Text {
                    text: label
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    color: currentView === menuId ? "#ffffff" : "#030213"
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
