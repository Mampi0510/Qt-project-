// clientcontroller.h
#ifndef CLIENTCONTROLLER_H
#define CLIENTCONTROLLER_H

#include <QObject>
#include <QVariantList>
#include "headers/client.h"
#include <connection.h>

class ClientController : public QObject {
    Q_OBJECT
public:
    explicit ClientController(QObject *parent = nullptr);

    Q_INVOKABLE bool ajouterClient(const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool modifierClient(int id, const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool supprimerClient(int id);
    Q_INVOKABLE QVariantList getAllClients();

private:

};

#endif // CLIENTCONTROLLER_H
