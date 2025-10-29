#ifndef PLAT_H
#define PLAT_H

#include <QAbstractListModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariantMap>
#include <QDebug>

class Plat : public QAbstractListModel
{
    Q_OBJECT

public:
    enum PlatRoles {
        IdRole = Qt::UserRole + 1,
        NomRole,
        PrixRole,
        CategorieRole
    };
    Q_ENUM(PlatRoles)

    explicit Plat(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QVariantMap get(int index) const;
    Q_INVOKABLE void chargerPlats();
    Q_INVOKABLE bool ajouterPlat(const QString &nom, double prix, const QString &categorie);
    Q_INVOKABLE bool modifierPlat(int id, const QString &nom, double prix, const QString &categorie);
    Q_INVOKABLE bool supprimerPlat(int id);

private:
    QList<QVariantMap> m_plats;
};

#endif // PLAT_H
