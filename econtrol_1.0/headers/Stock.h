#ifndef STOCK_H
#define STOCK_H

#include <QAbstractListModel>
#include <QVariantMap>

class Stock : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NomRole,
        QuantiteRole
    };

    explicit Stock(QObject *parent = nullptr);


    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;


    Q_INVOKABLE QVariantMap get(int index) const;
    Q_INVOKABLE bool ajouterProduit(const QString &nom, double quantite);
    Q_INVOKABLE bool modifierProduit(int id, const QString &nom, double quantite);
    Q_INVOKABLE bool supprimerProduit(int id);
    Q_INVOKABLE bool reduireStockPourPlat(int idPlat, double quantiteCommandee);

private:
    void chargerStock();

    QVector<QVariantMap> m_stock;
};

#endif // STOCK_H
