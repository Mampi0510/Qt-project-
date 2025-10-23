#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "headers/GestionData.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/icons/resto.png"));

    DatabaseManager gdManager;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("gdManager", &gdManager);

    engine.loadFromModule("econtrol", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
