#include "headers/Client.h"
#include "headers/GestionData.h"
#include <QTimer>

Client::Client(QObject *parent)
    : QAbstractListModel(parent)
{

    QTimer::singleShot(0, this, &Client::chargerClients);
}

QHash<int, QByteArray> Client::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id_client";
    roles[NomRole] = "nom";
    roles[PrenomRole] = "prenom";
    roles[TelephoneRole] = "telephone";
    return roles;
}

int Client::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)
    return m_clients.size();
}

QVariant Client::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_clients.size())
        return QVariant();

    const QVariantMap &client = m_clients.at(index.row());

    switch (role) {
    case IdRole: return client["id_client"];
    case NomRole: return client["nom"];
    case PrenomRole: return client["prenom"];
    case TelephoneRole: return client["telephone"];
    default: return QVariant();
    }
}

QVariantMap Client::get(int index) const {
    if (index < 0 || index >= m_clients.size())
        return QVariantMap();
    return m_clients.at(index);
}


void Client::chargerClients() {
    beginResetModel();
    m_clients.clear();

    QSqlQuery query(GestionData::instance()->getDatabase());
    if (!query.exec("SELECT id_client, nom, prenom, telephone FROM clients")) {
        qWarning() << "Erreur SELECT clients:" << query.lastError().text();
        endResetModel();
        return;
    }

    while (query.next()) {
        QVariantMap client;
        client["id_client"] = query.value("id_client").toInt();
        client["nom"] = query.value("nom").toString();
        client["prenom"] = query.value("prenom").toString();
        client["telephone"] = query.value("telephone").toString();
        m_clients.append(client);
    }

    endResetModel();
    emit countChanged();
    qDebug() << "Clients chargés:" << m_clients.size();
}


bool Client::ajouterClient(const QString &nom, const QString &prenom, const QString &telephone) {
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("INSERT INTO clients (nom, prenom, telephone) VALUES (?, ?, ?)");
    query.addBindValue(nom);
    query.addBindValue(prenom);
    query.addBindValue(telephone);

    if (!query.exec()) {
        qWarning() << "Erreur ajout client:" << query.lastError().text();
        return false;
    }

    chargerClients();
    return true;
}

bool Client::modifierClient(int id, const QString &nom, const QString &prenom, const QString &telephone) {
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("UPDATE clients SET nom=?, prenom=?, telephone=? WHERE id_client=?");
    query.addBindValue(nom);
    query.addBindValue(prenom);
    query.addBindValue(telephone);
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur maj client:" << query.lastError().text();
        return false;
    }

    chargerClients();
    return true;
}


bool Client::supprimerClient(int id) {
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("DELETE FROM clients WHERE id_client=?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur suppression client:" << query.lastError().text();
        return false;
    }

    chargerClients();
    return true;
}
