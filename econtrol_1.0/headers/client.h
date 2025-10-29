#ifndef CLIENT_H
#define CLIENT_H

#include <QAbstractListModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariantMap>
#include <QDebug>

class Client : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ClientRoles {
        IdRole = Qt::UserRole + 1,
        NomRole,
        PrenomRole,
        TelephoneRole
    };
    Q_ENUM(ClientRoles)

    explicit Client(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // CRUD
    Q_INVOKABLE QVariantMap get(int index) const;
    Q_INVOKABLE void chargerClients();
    Q_INVOKABLE bool ajouterClient(const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool modifierClient(int id, const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool supprimerClient(int id);

private:
    QList<QVariantMap> m_clients;
};

#endif // CLIENT_H
