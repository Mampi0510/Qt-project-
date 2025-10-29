#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QDebug>

#include "headers/GestionData.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/icons/resto.png"));

    GestionData* gdManager = GestionData::instance();

    // Attendre que la connexion soit établie
    if (!gdManager->connectToDatabase()) {
        qCritical() << "Impossible de se connecter à la base de données.";
        return -1;
    }

    // Les modèles sont maintenant initialisés à la demande
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("gdManager", gdManager);
    engine.rootContext()->setContextProperty("clientModel", gdManager->clientsModel());
    engine.rootContext()->setContextProperty("commandeModel", gdManager->ordersModel());
    engine.rootContext()->setContextProperty("platModel", gdManager->platModel());
    engine.rootContext()->setContextProperty("stockModel", gdManager->stockModel());
    engine.rootContext()->setContextProperty("factureModel", gdManager->factureModel());
    engine.rootContext()->setContextProperty("detailsCommandeModel", gdManager->ordersModel()->detailsModel());

    engine.loadFromModule("econtrol", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
