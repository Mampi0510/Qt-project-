#include "headers/Plat.h"
#include "headers/GestionData.h"
#include <QTimer>

Plat::Plat(QObject *parent)
    : QAbstractListModel(parent)
{

    QTimer::singleShot(0, this, &Plat::chargerPlats);
}


QHash<int, QByteArray> Plat::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id_plat";
    roles[NomRole] = "nom_plat";
    roles[PrixRole] = "prix";
    roles[CategorieRole] = "categorie";
    return roles;
}

int Plat::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)
    return m_plats.size();
}

QVariant Plat::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_plats.size())
        return QVariant();

    const QVariantMap &plat = m_plats.at(index.row());
    switch(role) {
    case IdRole: return plat["id_plat"];
    case NomRole: return plat["nom_plat"];
    case PrixRole: return plat["prix"];
    case CategorieRole: return plat["categorie"];
    default: return QVariant();
    }
}


QVariantMap Plat::get(int index) const {
    if(index < 0 || index >= m_plats.size()) return QVariantMap();
    return m_plats.at(index);
}


void Plat::chargerPlats() {
    beginResetModel();
    m_plats.clear();

    QSqlQuery query(GestionData::instance()->getDatabase());
    if(!query.exec("SELECT id_plat, nom_plat, prix, categorie FROM plats")) {
        qWarning() << "Erreur SELECT plats:" << query.lastError().text();
        endResetModel();
        return;
    }

    while(query.next()) {
        QVariantMap plat;
        plat["id_plat"] = query.value("id_plat").toInt();
        plat["nom_plat"] = query.value("nom_plat").toString();
        plat["prix"] = query.value("prix").toDouble();
        plat["categorie"] = query.value("categorie").toString();
        m_plats.append(plat);
    }

    endResetModel();
    emit countChanged();
    qDebug() << "Plats chargés:" << m_plats.size();
}


bool Plat::ajouterPlat(const QString &nom, double prix, const QString &categorie) {
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("INSERT INTO plats (nom_plat, prix, categorie) VALUES (?, ?, ?)");
    query.addBindValue(nom);
    query.addBindValue(prix);
    query.addBindValue(categorie);

    if(!query.exec()) {
        qWarning() << "Erreur ajout plat:" << query.lastError().text();
        return false;
    }

    chargerPlats();
    emit countChanged();
    return true;
}


bool Plat::modifierPlat(int id, const QString &nom, double prix, const QString &categorie) {
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("UPDATE plats SET nom_plat=?, prix=?, categorie=? WHERE id_plat=?");
    query.addBindValue(nom);
    query.addBindValue(prix);
    query.addBindValue(categorie);
    query.addBindValue(id);

    if(!query.exec()) {
        qWarning() << "Erreur modification plat:" << query.lastError().text();
        return false;
    }

    chargerPlats();
    emit countChanged();
    return true;
}


bool Plat::supprimerPlat(int id) {
    QSqlQuery query(GestionData::instance()->getDatabase());
    query.prepare("DELETE FROM plats WHERE id_plat=?");
    query.addBindValue(id);

    if(!query.exec()) {
        qWarning() << "Erreur suppression plat:" << query.lastError().text();
        return false;
    }

    chargerPlats();
    emit countChanged();
    return true;
}
