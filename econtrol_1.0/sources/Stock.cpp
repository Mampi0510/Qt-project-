#include "headers/Stock.h"
#include "headers/GestionData.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

Stock::Stock(QObject *parent)
    : QAbstractListModel(parent)
{
    auto gd = GestionData::instance();
    if (gd->isDatabaseConnected()) {
        chargerStock();
    } else {
        connect(gd, &GestionData::databaseConnected, this, &Stock::chargerStock);
    }
}

int Stock::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_stock.count();
}

QVariant Stock::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_stock.size())
        return QVariant();

    const QVariantMap &item = m_stock[index.row()];

    switch(role) {
    case IdRole:       return item.value("id_produit");
    case NomRole:      return item.value("nom_produit");
    case QuantiteRole: return item.value("quantite");
    default:           return QVariant();
    }
}

QHash<int, QByteArray> Stock::roleNames() const
{
    return {
        {IdRole, "id_produit"},
        {NomRole, "nom_produit"},
        {QuantiteRole, "quantite"}
    };
}

QVariantMap Stock::get(int index) const
{
    if (index < 0 || index >= m_stock.size())
        return QVariantMap();
    return m_stock[index];
}

void Stock::chargerStock()
{
    beginResetModel();
    m_stock.clear();

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) {
        qWarning() << "Base non ouverte!";
        endResetModel();
        return;
    }

    QSqlQuery query(db);
    if (!query.exec("SELECT id_produit, nom_produit, quantite FROM stock")) {
        qWarning() << "Erreur SELECT stock:" << query.lastError().text();
        endResetModel();
        return;
    }

    while (query.next()) {
        QVariantMap prod;
        prod["id_produit"] = query.value("id_produit").toInt();
        prod["nom_produit"] = query.value("nom_produit").toString();
        prod["quantite"] = query.value("quantite").toDouble();
        m_stock.append(prod);
    }

    endResetModel();
    qDebug() << "Stock chargé:" << m_stock.size() << "produits";
}

bool Stock::ajouterProduit(const QString &nom, double quantite)
{
    if (nom.isEmpty() || quantite < 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("INSERT INTO stock (nom_produit, quantite) VALUES (?, ?)");
    query.addBindValue(nom);
    query.addBindValue(quantite);

    if (!query.exec()) {
        qWarning() << "Erreur INSERT stock:" << query.lastError().text();
        return false;
    }

    int newId = query.lastInsertId().toInt();
    beginInsertRows(QModelIndex(), m_stock.size(), m_stock.size());
    QVariantMap produit;
    produit["id_produit"] = newId;
    produit["nom_produit"] = nom;
    produit["quantite"] = quantite;
    m_stock.append(produit);
    endInsertRows();

    return true;
}

bool Stock::modifierProduit(int id, const QString &nom, double quantite)
{
    if (id <= 0 || nom.isEmpty() || quantite < 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    int index = -1;
    for (int i = 0; i < m_stock.size(); ++i) {
        if (m_stock[i]["id_produit"].toInt() == id) {
            index = i;
            break;
        }
    }
    if (index == -1) return false;

    QSqlQuery query(db);
    query.prepare("UPDATE stock SET nom_produit=?, quantite=? WHERE id_produit=?");
    query.addBindValue(nom);
    query.addBindValue(quantite);
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur UPDATE stock:" << query.lastError().text();
        return false;
    }

    // Mise à jour incrémentale
    m_stock[index]["nom_produit"] = nom;
    m_stock[index]["quantite"] = quantite;
    QModelIndex modelIndex = createIndex(index, 0);
    emit dataChanged(modelIndex, modelIndex);

    return true;
}

bool Stock::supprimerProduit(int id)
{
    if (id <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    int index = -1;
    for (int i = 0; i < m_stock.size(); ++i) {
        if (m_stock[i]["id_produit"].toInt() == id) {
            index = i;
            break;
        }
    }
    if (index == -1) return false;

    QSqlQuery query(db);
    query.prepare("DELETE FROM stock WHERE id_produit=?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur DELETE stock:" << query.lastError().text();
        return false;
    }


    beginRemoveRows(QModelIndex(), index, index);
    m_stock.removeAt(index);
    endRemoveRows();

    return true;
}

bool Stock::reduireStockPourPlat(int idPlat, double quantiteCommandee)
{
    qDebug() << "[STOCK::reduireStockPourPlat] idPlat=" << idPlat << " qte=" << quantiteCommandee;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("SELECT id_produit, quantite_prise FROM detailsstock WHERE id_plat=?");
    query.addBindValue(idPlat);

    if (!query.exec()) {
        qWarning() << "Erreur lecture detailsstock:" << query.lastError().text();
        return false;
    }

    while (query.next()) {
        int idProduit = query.value("id_produit").toInt();
        double qteUtilisee = query.value("quantite_prise").toDouble();
        double totalAretirer = qteUtilisee * quantiteCommandee;

        QSqlQuery update(db);
        update.prepare("UPDATE stock SET quantite = quantite - ? WHERE id_produit=?");
        update.addBindValue(totalAretirer);
        update.addBindValue(idProduit);

        if (!update.exec()) {
            qWarning() << "Erreur maj stock:" << update.lastError().text();
            return false;
        }
    }

    chargerStock();
    return true;
}


