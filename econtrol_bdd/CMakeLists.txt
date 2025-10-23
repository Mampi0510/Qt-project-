cmake_minimum_required(VERSION 3.16)

project(econtrol_bdd VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(QT NAMES Qt6 REQUIRED COMPONENTS Widgets Sql)
find_package(Qt6 REQUIRED COMPONENTS Widgets Sql)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)
qt_add_resources(resources sql/econtrol_db.sql)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
#Set(CMAKE_AUTO)


qt_add_executable(appecontrol_bdd
    main.cpp
)

qt_add_qml_module(appecontrol_bdd
    URI econtrol_bdd
    VERSION 1.0

    SOURCES
        sources/Client.cpp
        sources/Commande.cpp
        sources/DetailsCommandes.cpp
        sources/Plat.cpp
        sources/Facture.cpp
        sources/Stock.cpp

        HEADERS
        headers/Client.h
        headers/Commande.h
        headers/DetailsCommandes.h
        headers/Plat.h
        headers/Facture.h
        headers/Stock.h

        QML_FILES
            Qml/Main.qml

            Qml/DashBoardView.qml
            Qml/ClientView.qml
            Qml/DishModelView.qml
            Qml/OrderView.qml
            Qml/StatisticsView.qml
            SOURCES connection.h
            SOURCES backend.h backend.cpp
            SOURCES controllers/clientcontroller.h controllers/clientcontroller.cpp
            SOURCES controllers/platcontroller.h controllers/platcontroller.cpp
        )

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appecontrol_bdd PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appecontrol_bdd
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appecontrol_bdd
    PRIVATE Qt6::Quick
    Qt6::Widgets
    Qt6::Sql
)
target_link_libraries(appecontrol_bdd PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appecontrol_bdd
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
