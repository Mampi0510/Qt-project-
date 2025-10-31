#ifndef GESTIONDATA_H
#define GESTIONDATA_H

#include <QObject>
#include <QSqlDatabase>
#include "headers/DetailsCommandes.h"
#include "headers/Client.h"
#include "headers/Commande.h"
#include "headers/Plat.h"
#include "headers/Stock.h"
#include "headers/Facture.h"

class GestionData : public QObject
{
    Q_OBJECT

public:
    static GestionData* instance();

    bool connectToDatabase();
    bool isDatabaseConnected() const { return gd.isOpen(); }
    QSqlDatabase getDatabase() const { return gd; }


    Plat* platModel();
    Client* clientsModel();
    Commande* ordersModel();
    Facture* factureModel();
    Stock* stockModel();

    DetailsCommande* detailsCommandeModel() const { return m_ordersModel->detailsModel(); }

signals:
    void databaseConnected();
    void databaseError(const QString &error);

private:
    GestionData(QObject *parent = nullptr);
    ~GestionData();

    void initializeModels();

    static GestionData* m_instance;
    QSqlDatabase gd;

    Plat* m_platModel;
    Client* m_clientsModel;
    Commande* m_ordersModel;
    Facture* m_factureModel;
    Stock* m_stockModel;

    bool m_modelsInitialized;
};

#endif // GESTIONDATA_H
