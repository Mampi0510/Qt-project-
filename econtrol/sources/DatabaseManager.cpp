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

    if (db.open()) {
        qDebug() << "Connexion MySQL réussie.";
        return true;
    }
        qDebug() << "Erreur connexion MySQL:" << db.lastError().text();
        return false;
}

QVariantList DatabaseManager::getClients() {
    QVariantList list;

    if (!db.isOpen()) {
        qWarning() << "Base non connectée, impossible de charger les clients.";
        return list;
    }

    QSqlQuery query("SELECT id_client, nom, prenom, telephone FROM clients");

    if (!query.exec()) {
        qWarning() << "Erreur requête SELECT:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        QVariantMap client;
        client["id_client"] = query.value(0).toInt();
        client["nom"] = query.value(1).toString();
        client["prenom"] = query.value(2).toString();
        client["telephone"] = query.value(3).toString();
        list.append(client);

        qDebug() << "Client lu:" << client;
    }

    qDebug() << "Nombre de clients trouvés :" << list.size();
    return list;
}

bool DatabaseManager::addClient(const QString &nom, const QString &prenom, const QString &telephone) {
    QSqlQuery query;
    query.prepare("INSERT INTO clients (nom, prenom, telephone) VALUES (?, ?, ?)");
    query.addBindValue(nom);
    query.addBindValue(prenom);
    query.addBindValue(telephone);

    if (!query.exec()) {
        qWarning() << "Erreur ajout client:" << query.lastError().text();
        return false;
    }

    emit clientsChanged();
    return true;
}


bool DatabaseManager::updateClient(int id, const QString &nom, const QString &prenom, const QString &telephone) {
    QSqlQuery query;
    query.prepare("UPDATE clients SET nom=?, prenom=?, telephone=? WHERE id_client=?");
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
    query.prepare("DELETE FROM clients WHERE id_client=?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur suppression client:" << query.lastError().text();
        return false;
    }

    emit clientsChanged();
    return true;
}

QVariantList DatabaseManager::getCommandes(){
    QVariantList list;

    QSqlQuery query(R"(
        SELECT c.id_commande, c.date_commande, c.total, cl.id_client, cl.nom, cl.prenom FROM commandes c
        JOIN clients cl ON c.id_client = cl.id_client
        ORDER BY c.id_commande DESC
    )");

    if (!query.exec()) {
        qWarning() << "Erreur SELECT commandes:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        QVariantMap commande;
        commande["id_commande"] = query.value("id_commande").toInt();
        commande["date_commande"] = query.value("date_commande").toString();
        commande["total"] = query.value("total").toDouble();
        commande["id_client"] = query.value("id_client").toInt();
        commande["nom_client"] = query.value("nom").toString();
        commande["prenom_client"] = query.value("prenom").toString();
        list.append(commande);

        qDebug() << "Commande lu:" << commande;
    }
    qDebug() << "liste commandes :" << list.size();
    return list;
}

bool DatabaseManager::addCommande(const QVariant &date_commande, const double total, int id_client) {
    QSqlQuery query;
    query.prepare("INSERT INTO commandes (date_commande, total, id_client) VALUES (?, ?, ?)");
    QDateTime date =  QDateTime::fromString(date_commande.toString(),"yyyy-MM-dd hh:mm:ss");
    if (!date.isValid()) {
        date = QDateTime::currentDateTime();
        qWarning() << "Date invalide reçue, utilisation de la date actuelle.";
    }
    query.addBindValue(date);
    query.addBindValue(total);
    query.addBindValue(id_client);

    if (!query.exec()) {
        qWarning() << "Erreur ajout commande:" << query.lastError().text();
        return false;
    }

    qDebug() << "Commande ajoutée pour le client" << id_client;
    emit commandesChanged();
    return true;
}

bool DatabaseManager::updateCommande(int id, const QDateTime &date_commande, double total, int id_client) {
    QSqlQuery query;
    query.prepare("UPDATE commandes SET date_commande=?, total=?, id_client=? WHERE id_commande=?");
    query.addBindValue(date_commande);
    query.addBindValue(total);
    query.addBindValue(id_client);
    query.addBindValue(id);

    qDebug() << "Commande modifiée (ID:" << id << ")";
    emit commandesChanged();
    return true;
}

bool DatabaseManager::deleteCommande(int id) {
    QSqlQuery query;
    query.prepare("DELETE FROM commandes WHERE id_commande=?");
    query.addBindValue(id);

    emit commandesChanged();
    return true;
}

QVariantList DatabaseManager::getPlats(){
    QVariantList list;

    QSqlQuery query("SELECT id_plat, nom_plat, prix, categorie FROM plats");

    while (query.next()) {
        QVariantMap plat;
        plat["id_plat"] = query.value(0).toInt();
        plat["nom_plat"] = query.value(1).toString();
        plat["prix"] = query.value(2).toFloat();
        plat["categorie"] = query.value(3).toString();
        list.append(plat);

        qDebug() << "nombres de plats :" << plat;
    }
    qDebug() << "liste plats :" << list.size();
    return list;
}

bool DatabaseManager::addPlat(const QString &nom_plat, const float prix, const QString &categorie) {
    QSqlQuery query;
    query.prepare("INSERT INTO plats (nom_plat, prix, categorie) VALUES (?, ?, ?)");
    query.addBindValue(nom_plat);
    query.addBindValue(prix);
    query.addBindValue(categorie);

    if (!query.exec()) {
        qWarning() << "Erreur plat non-ajoute:" << query.lastError().text();
        return false;
    }

    emit platsChanged();
    return true;
}

bool DatabaseManager::updatePlat(int id,const QString &nom_plat, const float prix, const QString &categorie) {
    QSqlQuery query;
    query.prepare("UPDATE plats SET nom_plat=?, prix=?, categorie=? WHERE id_plat=?");
    query.addBindValue(nom_plat);
    query.addBindValue(prix);
    query.addBindValue(categorie);
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur mise à jour plat:" << query.lastError().text();
        return false;
    }

    qDebug() << "Plat ID :" << id << "modifiée";
    emit platsChanged();
    return true;
}

bool DatabaseManager::deletePlat(int id){
    QSqlQuery query;
    query.prepare("DELETE FROM plats WHERE id_plat=?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur suppression plat (id=" << id << "):" << query.lastError().text();
        return false;
    }

    qDebug() << "Plat supprimé avec succès, id =" << id;

    emit platsChanged();
    return true;
}

