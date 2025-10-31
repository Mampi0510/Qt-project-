#ifndef DETAILSCOMMANDE_H
#define DETAILSCOMMANDE_H
#include <QAbstractListModel>
#include <QVariantMap>

class DetailsCommande : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    enum Roles {
        CommandeIdRole = Qt::UserRole + 1,
        PlatIdRole,
        QuantiteRole,
        PrixUnitaireRole
    };

    explicit DetailsCommande(QObject *parent = nullptr);


    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;


    Q_INVOKABLE bool ajouterDetail(int idCommande, int idPlat, int quantite, double prixUnitaire);
    Q_INVOKABLE bool supprimerDetail(int idCommande, int idPlat);
    Q_INVOKABLE bool supprimerDetailParCommande(int idCommande);
    Q_INVOKABLE QVariantMap get(int index) const;
    Q_INVOKABLE QVariantList getDetailsByCommande(int idCommande);
    Q_INVOKABLE void chargerDetails();

signals:
    void countChanged();

private:
    QVector<QVariantMap> m_details;
};

#endif // DETAILSCOMMANDE_H
