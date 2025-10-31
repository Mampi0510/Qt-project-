#include "headers/Commande.h"
#include "headers/GestionData.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QSqlDatabase>
#include <QTimer>

Commande::Commande(QObject *parent)
    : QAbstractListModel(parent)
{
    QTimer::singleShot(0, this, &Commande::chargerCommandes);

    m_detailsCommande = new DetailsCommande(this);

    auto gd = GestionData::instance();
    if (gd->isDatabaseConnected()) {
        chargerCommandes();
    } else {
        connect(gd, &GestionData::databaseConnected, this, &Commande::chargerCommandes);
    }
}

int Commande::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_commandes.count();
}

QVariant Commande::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_commandes.size())
        return QVariant();

    const QVariantMap &cmd = m_commandes[index.row()];
    switch(role) {
    case IdRole:       return cmd.value("id_commande");
    case ClientIdRole: return cmd.value("id_client");
    case DateRole:     return cmd.value("date_commande");
    case TotalRole:    return cmd.value("total");
    default:           return QVariant();
    }
}

QHash<int, QByteArray> Commande::roleNames() const
{
    return {
        {IdRole, "id_commande"},
        {ClientIdRole, "id_client"},
        {DateRole, "date_commande"},
        {TotalRole, "total"}
    };
}

QVariantMap Commande::get(int index) const
{
    if (index < 0 || index >= m_commandes.size())
        return QVariantMap();
    return m_commandes[index];
}

void Commande::chargerCommandes()
{
    beginResetModel();
    m_commandes.clear();

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) {
        qWarning() << "Base non ouverte!";
        endResetModel();
        return;
    }

    QSqlQuery query(db);
    if (!query.exec("SELECT id_commande, id_client, date_commande, total FROM commandes")) {
        qWarning() << "Erreur SELECT commandes:" << query.lastError().text();
        endResetModel();
        return;
    }

    while (query.next()) {
        QVariantMap c;
        c["id_commande"] = query.value("id_commande").toInt();
        c["id_client"] = query.value("id_client").toInt();
        c["date_commande"] = query.value("date_commande").toDateTime().toLocalTime().toString(Qt::ISODate);
        c["total"] = query.value("total").toDouble();
        m_commandes.append(c);
    }

    endResetModel();
    emit countChanged();
    qDebug() << "Commandes chargées:" << m_commandes.size();
}

bool Commande::ajouterCommande(int clientId, const QString &date, double total, const QVariantList &plats)
{
    qDebug() << "[COMMANDE::ajouterCommande] appelé depuis QML ? clientId=" << clientId
             << " date=" << date << " total=" << total << " plats_count=" << plats.size();

    if (clientId <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("INSERT INTO commandes (id_client, date_commande, total) VALUES (?, ?, ?)");

    QDateTime currentDateTime = QDateTime::currentDateTime();
    QString isoDate = currentDateTime.toString(Qt::ISODate);

    query.addBindValue(clientId);
    query.addBindValue(currentDateTime);
    query.addBindValue(total);

    if (!query.exec()) {
        qWarning() << "Erreur insert commande:" << query.lastError().text();
        return false;
    }

    int newId = query.lastInsertId().toInt();
    qDebug() << "[COMMANDE] Nouvelle commande ajoutée ID:" << newId;

    if (m_detailsCommande) {
        for (const QVariant &v : plats) {
            QVariantMap plat = v.toMap();
            int idPlat = plat["id_plat"].toInt();
            int quantite = plat["quantite"].toInt();
            double prixUnitaire = plat["prix"].toDouble();

            qDebug() << "[COMMANDE] Ajout du plat" << idPlat << "x" << quantite;
            m_detailsCommande->ajouterDetail(newId, idPlat, quantite, prixUnitaire);
        }
    }

    // Mise à jour du modèle
    beginInsertRows(QModelIndex(), m_commandes.size(), m_commandes.size());
    QVariantMap newCmd;
    newCmd["id_commande"] = newId;
    newCmd["id_client"] = clientId;
    newCmd["date_commande"] = isoDate;
    newCmd["total"] = total;
    m_commandes.append(newCmd);
    endInsertRows();

    emit countChanged();
    chargerCommandes();


    // Générer automatiquement une facture après ajout de la commande
    auto factureModel = GestionData::instance()->factureModel();
    if (factureModel) {
        factureModel->genererFacture(newId);
        qDebug() << "[COMMANDE] Facture générée automatiquement pour la commande" << newId;
    }

    return true;
}


bool Commande::modifierCommande(int id, int clientId, const QString &date, double total)
{
    if (id <= 0 || clientId <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    QSqlQuery query(db);
    query.prepare("UPDATE commandes SET id_client=?, date_commande=?, total=? WHERE id_commande=?");
    query.addBindValue(clientId);
    query.addBindValue(date);
    query.addBindValue(total);
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur update commande:" << query.lastError().text();
        return false;
    }


    for (int i = 0; i < m_commandes.size(); ++i) {
        if (m_commandes[i]["id_commande"].toInt() == id) {
            m_commandes[i]["id_client"] = clientId;
            m_commandes[i]["date_commande"] = date;
            m_commandes[i]["total"] = total;
            QModelIndex modelIndex = createIndex(i, 0);
            emit dataChanged(modelIndex, modelIndex);
            break;
        }
    }

    emit countChanged();    // met à jour le compteur QML
    chargerCommandes();

    return true;
}

bool Commande::supprimerCommande(int id)
{
    if (id <= 0) return false;

    QSqlDatabase db = GestionData::instance()->getDatabase();
    if (!db.isOpen()) return false;

    if (!db.transaction()) {
        qWarning() << "Impossible de démarrer la transaction";
        return false;
    }


    if (m_detailsCommande && !m_detailsCommande->supprimerDetailParCommande(id)) {
        db.rollback();
        return false;
    }

    QSqlQuery query(db);
    query.prepare("DELETE FROM commandes WHERE id_commande=?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Erreur delete commande:" << query.lastError().text();
        db.rollback();
        return false;
    }

    if (!db.commit()) {
        qWarning() << "Erreur commit transaction:" << db.lastError().text();
        db.rollback();
        return false;
    }


    for (int i = 0; i < m_commandes.size(); ++i) {
        if (m_commandes[i]["id_commande"].toInt() == id) {
            beginRemoveRows(QModelIndex(), i, i);
            m_commandes.removeAt(i);
            endRemoveRows();
            break;
        }
    }

    emit countChanged();    // met à jour le compteur QML
    chargerCommandes();

    return true;
}
