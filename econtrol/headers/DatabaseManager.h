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

    Q_INVOKABLE bool addClient(const QString &nom, const QString &prenom, const QString &telephone);

private:
    QSqlDatabase db;
    bool connectToDatabase();
};

#endif // DATABASEMANAGER_H
