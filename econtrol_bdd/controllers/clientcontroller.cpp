#include "clientcontroller.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

ClientController::ClientController(QObject *parent)
    : QObject(parent)
{
    my_connection(); // connexion MySQL
    chargerClients(); // charge automatiquement les clients
}

ClientController::~ClientController() {
    clearClients();
}

void ClientController::clearClients() {
    for (auto *client : m_clients) {
        client->deleteLater();
    }
    m_clients.clear();
}

QQmlListProperty<Client> ClientController::getClients() {
    return QQmlListProperty<Client>(this, &m_clients);
}

void ClientController::chargerClients()
{
    clearClients();

    QSqlQuery query("SELECT id_client, nom, prenom, telephone FROM clients");
    while (query.next()) {
        Client *client = new Client(this);
        client->setIdClient(query.value(0).toInt());
        client->setNom(query.value(1).toString());
        client->setPrenom(query.value(2).toString());
        client->setTelephone(query.value(3).toString());
        m_clients.append(client);
    }

    emit clientsChanged();
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

    chargerClients();
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

    chargerClients();
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

    chargerClients();
    return true;
}

QObject* ClientController::getClientById(int idClient) {
    qDebug() << "Recherche du client id =" << idClient;
    for (auto client : m_clients) {
        qDebug() << "→ trouvé client:" << client->getIdClient();
        if (client->getIdClient() == idClient)
            return client;
    }
    qDebug() << "⚠️ Aucun client trouvé pour id =" << idClient;
    return nullptr;
}


