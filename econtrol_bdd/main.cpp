#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlError>
#include "controllers/clientcontroller.h"
#include "headers/client.h"
#include "controllers/platcontroller.h"
#include "backend.h"
#include "connection.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Backend> ("Backend", 1, 0, "Backend");
    qmlRegisterType<Client>("Client", 1, 0, "Client");                  // Le modèle
    qmlRegisterType<ClientController>("Client", 1, 0, "ClientController");
    qmlRegisterType<PlatController> ("Plat", 1,0,"Plat");


    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("econtrol_bdd", "Main");

    QObject::connect(&app, &QCoreApplication::aboutToQuit, []() {
        stopEmbeddedMySQL();
    });

    return app.exec();
}
