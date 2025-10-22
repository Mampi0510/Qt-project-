#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "headers/DatabaseManager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/icons/resto.png"));

    DatabaseManager dbManager;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("dbManager", &dbManager);

    engine.loadFromModule("econtrol", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
