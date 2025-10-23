#ifndef PLATCONTROLLER_H
#define PLATCONTROLLER_H
#include <QObject>
#include <QVariantList>
#include "headers/plat.h"
#include <connection.h>

class PlatController : public QObject {
    Q_OBJECT
public:
    explicit PlatController(QObject *parent = nullptr);
    Q_INVOKABLE bool ajouterPlat(const QString &nom_plat, const QString &prix, const QString &categorie);
    //Q_INVOKABLE bool modifierPlat(int id, const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool supprimerPlat(int id);
    Q_INVOKABLE QVariantList getAllPlats();
};

#endif // PLATCONTROLLER_H
