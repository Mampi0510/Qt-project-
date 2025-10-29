#include "headers/DetailsCommandes.h"
#include "headers/GestionData.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

DetailsCommande::DetailsCommande(QObject *parent)
    : QAbstractListModel(parent)
{
    auto gd = GestionData::instance();
    if (gd->isDatabaseConnected()) {
        chargerDetails();
    } else {
        connect(gd, &GestionData::databaseConnected, this, &DetailsCommande::chargerDetails);
    }
}

int DetailsCommande::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_details.count();
}

QVariant DetailsCommande::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_details.size())
        return QVariant();

    const QVariantMap &d = m_details[index.row()];
    switch(role) {
    case CommandeIdRole: return d.value("id_commande");
    case PlatIdRole:     return d.value("id_plat");
    case QuantiteRole:   return d.value("quantite");
    case PrixUnitaireRole: return d.value("prix_unitaire");
    default:             return QVariant();
    }
}

QHash<int, QByteArray> DetailsCommande::roleNames() const
{
    return {
        {CommandeIdRole, "id_commande"},
        {PlatIdRole, "id_plat"},
        {QuantiteRole, "quantite"},
        {PrixUnitaireRole, "prix_unitaire"}
    };
}

void DetailsCommande::chargerDetails()
{
    beginResetModel();
    m_details.clear();

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) {
        qWarning() << "La base n'est pas ouverte!";
        endResetModel();
        return;
    }

    QSqlQuery query(db);
    if (!query.exec("SELECT id_commande, id_plat, quantite, prix_unitaire FROM detailscommande")) {
        qWarning() << "Erreur SELECT details:" << query.lastError().text();
        endResetModel();
        return;
    }

    while (query.next()) {
        QVariantMap d;
        d["id_commande"] = query.value("id_commande").toInt();
        d["id_plat"] = query.value("id_plat").toInt();
        d["quantite"] = query.value("quantite").toInt();
        d["prix_unitaire"] = query.value("prix_unitaire").toDouble();
        m_details.append(d);
    }

    endResetModel();
    qDebug() << "Détails commandes chargés:" << m_details.size();
}

bool DetailsCommande::ajouterDetail(int idCommande, int idPlat, int quantite, double prixUnitaire)
{
    if (idCommande <= 0 || idPlat <= 0 || quantite <= 0 || prixUnitaire <= 0)
        return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("INSERT INTO detailscommande (id_commande, id_plat, quantite, prix_unitaire) VALUES (?, ?, ?, ?)");
    query.addBindValue(idCommande);
    query.addBindValue(idPlat);
    query.addBindValue(quantite);
    query.addBindValue(prixUnitaire);

    if (!query.exec()) {
        qWarning() << "Erreur insert detail:" << query.lastError().text();
        return false;
    }


    beginInsertRows(QModelIndex(), m_details.size(), m_details.size());
    QVariantMap newDetail;
    newDetail["id_commande"] = idCommande;
    newDetail["id_plat"] = idPlat;
    newDetail["quantite"] = quantite;
    newDetail["prix_unitaire"] = prixUnitaire;
    m_details.append(newDetail);
    endInsertRows();

    return true;
}

bool DetailsCommande::supprimerDetail(int idCommande, int idPlat)
{
    if (idCommande <= 0 || idPlat <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("DELETE FROM detailscommande WHERE id_commande=? AND id_plat=?");
    query.addBindValue(idCommande);
    query.addBindValue(idPlat);

    if (!query.exec()) {
        qWarning() << "Erreur delete detail:" << query.lastError().text();
        return false;
    }

    for (int i = 0; i < m_details.size(); ++i) {
        if (m_details[i]["id_commande"].toInt() == idCommande &&
            m_details[i]["id_plat"].toInt() == idPlat) {
            beginRemoveRows(QModelIndex(), i, i);
            m_details.removeAt(i);
            endRemoveRows();
            break;
        }
    }

    return true;
}

bool DetailsCommande::supprimerDetailParCommande(int idCommande)
{
    if (idCommande <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("DELETE FROM detailscommande WHERE id_commande=?");
    query.addBindValue(idCommande);

    if (!query.exec()) {
        qWarning() << "Erreur delete details par commande:" << query.lastError().text();
        return false;
    }

    // Mise à jour incrémentale
    for (int i = m_details.size() - 1; i >= 0; --i) {
        if (m_details[i]["id_commande"].toInt() == idCommande) {
            beginRemoveRows(QModelIndex(), i, i);
            m_details.removeAt(i);
            endRemoveRows();
        }
    }

    return true;
}

QVariantMap DetailsCommande::get(int index) const
{
    if (index < 0 || index >= m_details.size())
        return QVariantMap();
    return m_details[index];
}

QVariantList DetailsCommande::getDetailsByCommande(int idCommande)
{
    QVariantList result;
    for (const QVariantMap &detail : m_details) {
        if (detail["id_commande"].toInt() == idCommande) {
            result.append(detail);
        }
    }
    return result;
}
