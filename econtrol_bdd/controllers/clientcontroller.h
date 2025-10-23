#ifndef CLIENTCONTROLLER_H
#define CLIENTCONTROLLER_H

#include <QObject>
#include <QQmlListProperty>
#include <QList>
#include "headers/client.h"
#include <connection.h>

class ClientController : public QObject {
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Client> clients READ getClients NOTIFY clientsChanged)

public:
    explicit ClientController(QObject *parent = nullptr);
    ~ClientController();

    Q_INVOKABLE bool ajouterClient(const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool modifierClient(int id, const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool supprimerClient(int id);
    Q_INVOKABLE void chargerClients(); // charge depuis la BDD
    Q_INVOKABLE QObject* getClientById(int idClient);


    QQmlListProperty<Client> getClients();

signals:
    void clientsChanged();

private:
    QList<Client*> m_clients;
    void clearClients(); // pour nettoyer proprement
};

#endif // CLIENTCONTROLLER_H
