#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlError>
#include "controllers/clientcontroller.h"
#include "controllers/platcontroller.h"
#include "backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Backend> ("Backend", 1, 0, "Backend");
    qmlRegisterType<ClientController> ("Client", 1,0,"Client");
    qmlRegisterType<PlatController> ("Plat", 1,0,"Plat");


    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("econtrol_bdd", "Main");
    return app.exec();
}
