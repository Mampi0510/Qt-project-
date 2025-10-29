#ifndef FACTURE_H
#define FACTURE_H

#include <QAbstractListModel>
#include <QDateTime>
#include <QVariantMap>

class Facture : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        CommandeIdRole,
        ClientIdRole,
        DateRole,
        MontantNetRole
    };

    explicit Facture(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QVariantMap get(int index) const;
    Q_INVOKABLE bool ajouterFacture(int idCommande, int idClient, const QDateTime &dateFacture, double montantNet);
    Q_INVOKABLE bool genererFacture(int idCommande);
    Q_INVOKABLE bool supprimerFacture(int idFacture);
    Q_INVOKABLE bool supprimerFactureParCommande(int idCommande);

private:
    void chargerFactures();

    QVector<QVariantMap> m_factures;
};

#endif // FACTURE_H
