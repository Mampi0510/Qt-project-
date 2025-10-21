#include "headers/DatabaseManager.h"

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
{
    connectToDatabase();
}

bool DatabaseManager::connectToDatabase()
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setPort(3306);
    db.setDatabaseName("eoy_project");
    db.setUserName("root");
    db.setPassword("login");

    if (!db.open()) {
        qDebug() << "Erreur connexion MySQL:" << db.lastError().text();
        return false;
    }

    qDebug() << "Connexion MySQL réussie.";
    return true;
}

bool DatabaseManager::addClient(const QString &nom, const QString &prenom, const QString &telephone)
{
    if (!db.isOpen()) {
        qDebug() << "Base non connectée !";
        return false;
    }

    QSqlQuery query;
    query.prepare("INSERT INTO clients (nom, prenom, telephone) VALUES (:nom, :prenom, :telephone)");
    query.bindValue(":nom", nom);
    query.bindValue(":prenom", prenom);
    query.bindValue(":telephone", telephone);

    if (!query.exec()) {
        qDebug() << "Erreur d'insertion:" << query.lastError().text();
        return false;
    }

    qDebug() << "Client ajouté avec succès.";
    return true;
}
