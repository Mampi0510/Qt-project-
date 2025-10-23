#include "clientcontroller.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

ClientController::ClientController(QObject *parent)
    : QObject(parent)
{
    my_connection();
}

bool ClientController::ajouterClient(const QString &nom, const QString &prenom, const QString &telephone)
{
    QSqlQuery query;
    query.prepare("INSERT INTO clients (nom, prenom, telephone) VALUES (:nom, :prenom, :telephone)");
    query.bindValue(":nom", nom);
    query.bindValue(":prenom", prenom);
    query.bindValue(":telephone", telephone);
    if (!query.exec()) {
        qDebug() << "Erreur insertion client:" << query.lastError().text();
        return false;
    }

     qDebug() << " Client inséré:" << nom << prenom << telephone;

    return true;
}

bool ClientController::modifierClient(int id, const QString &nom, const QString &prenom, const QString &telephone)
{
    QSqlQuery query;
    query.prepare("UPDATE clients SET nom=:nom, prenom=:prenom, telephone=:telephone WHERE id_client=:id");
    query.bindValue(":nom", nom);
    query.bindValue(":prenom", prenom);
    query.bindValue(":telephone", telephone);
    query.bindValue(":id", id);
    if (!query.exec()) {
        qDebug() << "Erreur modification client:" << query.lastError().text();
        return false;
    }
    return true;
}

bool ClientController::supprimerClient(int id)
{
    QSqlQuery query;
    query.prepare("DELETE FROM clients WHERE id_client=:id");
    query.bindValue(":id", id);
    if (!query.exec()) {
        qDebug() << "Erreur suppression client:" << query.lastError().text();
        return false;
    }
    return true;
}

QVariantList ClientController::getAllClients()
{
    QVariantList list;
    QSqlQuery query("SELECT id_client, nom, prenom, telephone FROM clients");

    while (query.next()) {
        QVariantMap client;
        client["id_client"] = query.value(0);
        client["nom"] = query.value(1);
        client["prenom"] = query.value(2);
        client["telephone"] = query.value(3);
        list.append(client);
    }
    return list;
}
