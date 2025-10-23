#ifndef GESTIONDATA_H
#define GESTIONDATA_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QDateTime>

class DatabaseManager : public QObject {
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

    // proprietes clients
    Q_INVOKABLE QVariantList getClients();
    Q_INVOKABLE bool addClient(const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool updateClient(int id, const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool deleteClient(int id);

    // proprietes commandes
    Q_INVOKABLE QVariantList getCommandes();
    Q_INVOKABLE bool addCommande(const QVariant &date_commande,const double total, int id_client);
    Q_INVOKABLE bool updateCommande(int id, const QDateTime &date_commande,const double total, int id_client);
    Q_INVOKABLE bool deleteCommande(int id);

    //proprietes plats
    Q_INVOKABLE QVariantList getPlats();
    Q_INVOKABLE bool addPlat(const QString &nom_plat, const float prix, const QString &categorie);
    Q_INVOKABLE bool updatePlat(int id,const QString &nom_plat, const float prix, const QString &categorie);
    Q_INVOKABLE bool deletePlat(int id);

    signals:
        void clientsChanged();
        void platsChanged();
        void commandesChanged();


private:
    QSqlDatabase gd;
    bool connectToDatabase();
};

#endif // GESTIONDATA_H
