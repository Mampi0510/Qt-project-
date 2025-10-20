#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include "connection.h"
class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = 0);

signals:

public slots:
    void requete(QString name, QString lastname, int age);
};

#endif // BACKEND_H
