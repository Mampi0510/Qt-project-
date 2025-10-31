cmake_minimum_required(VERSION 3.16)

project(econtrol VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Sql)
find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
#Set(CMAKE_AUTO)

qt_add_executable(appecontrol
    main.cpp
    resources.qrc
)

qt_add_qml_module(appecontrol
    URI econtrol
    VERSION 1.0

    SOURCES
    sources/Client.cpp
    sources/Commande.cpp
    sources/DetailsCommandes.cpp
    sources/Plat.cpp
    sources/Facture.cpp
    sources/Stock.cpp
    sources/GestionData.cpp

    HEADERS
    headers/Client.h
    headers/Commande.h
    headers/DetailsCommandes.h
    headers/Plat.h
    headers/Facture.h
    headers/Stock.h
    headers/GestionData.h

    QML_FILES
        Qml/Main.qml
        Qml/DashBoardView.qml
        Qml/ClientView.qml
        Qml/DishModelView.qml
        Qml/OrderView.qml
        Qml/StatisticsView.qml
        Qml/StockView.qml
        RESOURCES resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appecontrol PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appecontrol
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)



target_link_libraries(appecontrol
    PRIVATE Qt6::Quick Qt6::Core Qt6::Gui Qt6::Widgets Qt6::Sql Qt6::QuickControls2
)
target_link_libraries(appecontrol PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appecontrol
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
