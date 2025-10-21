#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

class DatabaseManager : public QObject {
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList getClients();
    Q_INVOKABLE bool addClient(const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool updateClient(int id, const QString &nom, const QString &prenom, const QString &telephone);
    Q_INVOKABLE bool deleteClient(int id);

    // Signal pour informer QML que la BD a changé
signals:
    void clientsChanged();


private:
    QSqlDatabase db;
    bool connectToDatabase();
};

#endif // DATABASEMANAGER_H
