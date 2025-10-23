#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <connection.h>
class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = 0);

signals:

public slots:
    void requete(QString name, QString lastname, int age);
    QVariantList getAllData();
    bool deleteData(int id);
    bool updateData(int id, QString nom, QString prenom, int age);
};

#endif // BACKEND_H
