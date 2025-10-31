#include "headers/Facture.h"
#include "headers/GestionData.h"
#include <QTimer>
#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>

Facture::Facture(QObject *parent)
    : QAbstractListModel(parent)
{
    auto gd = GestionData::instance();
    if (gd->isDatabaseConnected()) {
        chargerFactures();
    } else {
        connect(gd, &GestionData::databaseConnected, this, &Facture::chargerFactures);
    }
}

int Facture::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_factures.size();
}

QVariant Facture::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_factures.size())
        return {};

    const QVariantMap &f = m_factures.at(index.row());

    switch(role) {
    case IdRole:          return f["id_facture"];
    case CommandeIdRole:  return f["id_commande"];
    case ClientIdRole:    return f["id_client"];
    case DateRole:        return f["date_facture"];
    case MontantNetRole:  return f["montant_net"];
    default:              return {};
    }
}

QHash<int, QByteArray> Facture::roleNames() const
{
    return {
        {IdRole, "id_facture"},
        {CommandeIdRole, "id_commande"},
        {ClientIdRole, "id_client"},
        {DateRole, "date_facture"},
        {MontantNetRole, "montant_net"}
    };
}

QVariantMap Facture::get(int index) const
{
    if (index < 0 || index >= m_factures.size())
        return {};
    return m_factures.at(index);
}

void Facture::chargerFactures()
{
    beginResetModel();
    m_factures.clear();

    QSqlQuery query(GestionData::instance()->getDatabase());
    if(!query.exec("SELECT id_facture, id_commande, id_client, date_facture, net_a_payer FROM facture")) {
        qWarning() << "Erreur SELECT factures:" << query.lastError().text();
        endResetModel();
        return;
    }

    while(query.next()) {
        QVariantMap f;
        f["id_facture"] = query.value("id_facture").toInt();
        f["id_commande"] = query.value("id_commande").toInt();
        f["id_client"] = query.value("id_client").toInt();
        f["date_facture"] = query.value("date_facture").toDateTime().toLocalTime().toString(Qt::ISODate);
        f["montant_net"] = query.value("net_a_payer").toDouble();
        m_factures.append(f);

        qDebug() << "Facture chargée:" << f;
    }

    endResetModel();
}

bool Facture::ajouterFacture(int idCommande, int idClient, const QDateTime &dateFacture, double montantNet)
{
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("INSERT INTO facture (id_commande, id_client, date_facture, net_a_payer) VALUES (?, ?, ?, ?)");
    query.addBindValue(idCommande);
    query.addBindValue(idClient);
    query.addBindValue(dateFacture);
    query.addBindValue(montantNet);

    if(!query.exec()) {
        qWarning() << "Erreur ajout facture:" << query.lastError().text();
        return false;
    }

    int newId = query.lastInsertId().toInt();
    beginInsertRows(QModelIndex(), m_factures.size(), m_factures.size());
    QVariantMap facture;
    facture["id_facture"] = newId;
    facture["id_commande"] = idCommande;
    facture["id_client"] = idClient;
    facture["date_facture"] = dateFacture.toString(Qt::ISODate);
    facture["montant_net"] = montantNet;
    m_factures.append(facture);
    endInsertRows();

    return true;
}

bool Facture::genererFacture(int idCommande)
{
    if (idCommande <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery cmdQuery(db);
    cmdQuery.prepare("SELECT id_client, total FROM commandes WHERE id_commande = ?");
    cmdQuery.addBindValue(idCommande);

    if (!cmdQuery.exec() || !cmdQuery.next()) {
        qWarning() << "Commande non trouvée:" << idCommande;
        return false;
    }

    int idClient = cmdQuery.value("id_client").toInt();
    double totalCommande = cmdQuery.value("total").toDouble();


    QSqlQuery checkQuery(db);
    checkQuery.prepare("SELECT 1 FROM facture WHERE id_commande = ?");
    checkQuery.addBindValue(idCommande);

    if (checkQuery.exec() && checkQuery.next()) {
        qWarning() << "Facture existe déjà pour commande:" << idCommande;
        return false;
    }


    return ajouterFacture(idCommande, idClient, QDateTime::currentDateTime().toLocalTime(), totalCommande);
}

bool Facture::supprimerFacture(int idFacture)
{
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("DELETE FROM facture WHERE id_facture=?");
    query.addBindValue(idFacture);

    if(!query.exec()) {
        qWarning() << "Erreur suppression facture:" << query.lastError().text();
        return false;
    }


    for (int i = 0; i < m_factures.size(); ++i) {
        if (m_factures[i]["id_facture"].toInt() == idFacture) {
            beginRemoveRows(QModelIndex(), i, i);
            m_factures.removeAt(i);
            endRemoveRows();
            break;
        }
    }

    return true;
}

bool Facture::supprimerFactureParCommande(int idCommande)
{
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("DELETE FROM facture WHERE id_commande=?");
    query.addBindValue(idCommande);

    if(!query.exec()) {
        qWarning() << "Erreur suppression factures liées à la commande:" << query.lastError().text();
        return false;
    }

    for (int i = m_factures.size() - 1; i >= 0; --i) {
        if (m_factures[i]["id_commande"].toInt() == idCommande) {
            beginRemoveRows(QModelIndex(), i, i);
            m_factures.removeAt(i);
            endRemoveRows();
        }
    }

    return true;
}
