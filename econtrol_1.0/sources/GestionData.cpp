#include "headers/GestionData.h"
#include <QDebug>
#include <QTimer>  // AJOUTER CETTE LIGNE

GestionData* GestionData::m_instance = nullptr;

GestionData::GestionData(QObject *parent)
    : QObject(parent),
    m_platModel(nullptr),
    m_clientsModel(nullptr),
    m_ordersModel(nullptr),
    m_factureModel(nullptr),
    m_stockModel(nullptr),
    m_modelsInitialized(false)
{

    if (connectToDatabase()) {
        QTimer::singleShot(100, this, &GestionData::initializeModels);
    }
}

GestionData::~GestionData()
{
    if (gd.isOpen()) {
        gd.close();
        qDebug() << "Connexion MySQL fermée.";
    }
}

GestionData* GestionData::instance()
{
    if (!m_instance)
        m_instance = new GestionData();
    return m_instance;
}

void GestionData::initializeModels()
{
    if (m_modelsInitialized) return;

    m_platModel = new Plat(this);
    m_clientsModel = new Client(this);
    m_ordersModel = new Commande(this);
    m_factureModel = new Facture(this);
    m_stockModel = new Stock(this);

    m_modelsInitialized = true;
    qDebug() << "Tous les modèles initialisés";
}

bool GestionData::connectToDatabase()
{
    if (QSqlDatabase::contains("EcontrolConnection")) {
        gd = QSqlDatabase::database("EcontrolConnection");
        if (gd.isOpen()) {
            emit databaseConnected();
            return true;
        }
    } else {
        gd = QSqlDatabase::addDatabase("QMYSQL", "EcontrolConnection");
        gd.setHostName("localhost");
        gd.setPort(3306);
        gd.setDatabaseName("eoy_project");
        gd.setUserName("root");
        gd.setPassword("azerty12");
    }

    if (gd.open()) {
        qDebug() << "Connexion MySQL réussie.";
        emit databaseConnected();
        return true;
    }

    QString error = gd.lastError().text();
    qDebug() << "Erreur connexion MySQL:" << error;
    emit databaseError(error);
    return false;
}


Plat* GestionData::platModel() {
    if (!m_modelsInitialized) initializeModels();
    return m_platModel;
}

Client* GestionData::clientsModel() {
    if (!m_modelsInitialized) initializeModels();
    return m_clientsModel;
}

Commande* GestionData::ordersModel() {
    if (!m_modelsInitialized) initializeModels();
    return m_ordersModel;
}

Facture* GestionData::factureModel() {
    if (!m_modelsInitialized) initializeModels();
    return m_factureModel;
}

Stock* GestionData::stockModel() {
    if (!m_modelsInitialized) initializeModels();
    return m_stockModel;
}
