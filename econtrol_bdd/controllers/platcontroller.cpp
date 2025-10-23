#include "platcontroller.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

PlatController::PlatController(QObject *parent)
    : QObject(parent)
{
    my_connection();
}

bool PlatController::ajouterPlat(const QString &nom_plat, const QString &prix, const QString &categorie)
{
    QSqlQuery query;
    query.prepare("INSERT INTO plats (nom_plat, prix, categorie) VALUES (:nom_plat, :prix, :categorie)");
    query.bindValue(":nom_plat", nom_plat);
    query.bindValue(":prix", prix);
    query.bindValue(":categorie", categorie);
    if (!query.exec()) {
        qDebug() << "Erreur insertion plats:" << query.lastError().text();
        return false;
    }

    qDebug() << "Plat inséré:" << nom_plat << prix << categorie;

    return true;
}

QVariantList PlatController::getAllPlats()
{
    QVariantList list;
    QSqlQuery query("SELECT id_PLat, nom_plat, prix, categorie FROM plats");

    while (query.next()) {
        QVariantMap plat;
        plat["id_plat"] = query.value(0);
        plat["nom_plat"] = query.value(1);
        plat["prix"] = query.value(2);
        plat["categorie"] = query.value(3);
        list.append(plat);
    }
    return list;
}
/*
bool PlatController::supprimerClient(int id)
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
*/
