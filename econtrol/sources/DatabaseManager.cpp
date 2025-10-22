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

QVariantList DatabaseManager::getClients() {
    QVariantList list;

    if (!db.isOpen()) {
        qWarning() << "❌ Base non connectée, impossible de charger les clients.";
        return list;
    }

    // ✅ Table correcte : clients
    // ✅ Colonne correcte : id_client
    QSqlQuery query("SELECT id_client, nom, prenom, telephone FROM clients");

    if (!query.exec()) {
        qWarning() << "❌ Erreur requête SELECT:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        QVariantMap client;
        client["id_client"] = query.value(0).toInt();  // ✅ clé utilisée en QML
        client["nom"] = query.value(1).toString();
        client["prenom"] = query.value(2).toString();
        client["telephone"] = query.value(3).toString();
        list.append(client);

        qDebug() << "📋 Client lu:" << client;
    }

    qDebug() << "✅ Nombre de clients trouvés :" << list.size();
    return list;
}

bool DatabaseManager::addClient(const QString &nom, const QString &prenom, const QString &telephone) {
    QSqlQuery query;

    // ✅ Table correcte : clients
    query.prepare("INSERT INTO clients (nom, prenom, telephone) VALUES (?, ?, ?)");
    query.addBindValue(nom);
    query.addBindValue(prenom);
    query.addBindValue(telephone);

    if (!query.exec()) {
        qWarning() << "❌ Erreur ajout client:" << query.lastError().text();
        return false;
    }

    emit clientsChanged();  // 🔔 Notifie QML
    return true;
}


bool DatabaseManager::updateClient(int id, const QString &nom, const QString &prenom, const QString &telephone) {
    QSqlQuery query;
    query.prepare("UPDATE clients SET nom=?, prenom=?, telephone=? WHERE id=?");
    query.addBindValue(nom);
    query.addBindValue(prenom);
    query.addBindValue(telephone);
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur maj client:" << query.lastError().text();
        return false;
    }

    emit clientsChanged();
    return true;
}

bool DatabaseManager::deleteClient(int id) {
    QSqlQuery query;
    query.prepare("DELETE FROM clients WHERE id=?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur suppression client:" << query.lastError().text();
        return false;
    }

    emit clientsChanged();
    return true;
}

