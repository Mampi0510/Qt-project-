#ifndef COMMANDE_H
#define COMMANDE_H

#include <QAbstractListModel>
#include <QVariantMap>
#include "headers/DetailsCommandes.h"

class Commande : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        ClientIdRole,
        DateRole,
        TotalRole
    };

    explicit Commande(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QVariantMap get(int index) const;
    Q_INVOKABLE bool ajouterCommande(int clientId, const QString &date, double total, const QVariantList &plats);
    Q_INVOKABLE bool modifierCommande(int id, int clientId, const QString &date, double total);
    Q_INVOKABLE bool supprimerCommande(int id);

    DetailsCommande* detailsModel() const { return m_detailsCommande; }

private:
    void chargerCommandes();

    QVector<QVariantMap> m_commandes;
    DetailsCommande* m_detailsCommande;

signals:
    void countChanged();
};

#endif // COMMANDE_H
