#include "backend.h"
#include "QDebug"
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariantMap>

Backend::Backend(QObject *parent):QObject(parent) {
    my_connection();
}

void Backend::requete(QString name, QString lastname, int age){
    QSqlQuery req;

    if( name!="" && lastname!=""){
        qDebug() << "teerterte" << name;
        req.prepare("INSERT INTO qml_formulaire1(nom, prenom, age) VALUES(:nom, :prenom, :age)");
        req.bindValue(":nom",name);
        req.bindValue(":prenom",lastname);
        req.bindValue(":age",age);
        req.exec();
        qDebug() <<"Renseignements enregistrés";
    }else
        qDebug()<<"Entrer nom et prénom!";
}

QVariantList Backend::getAllData() {
    QVariantList dataList;
    QSqlQuery query("SELECT id, nom, prenom, age FROM qml_formulaire1");

    while (query.next()) {
        QVariantMap record;
        record["id"] = query.value("id").toInt();
        record["nom"] = query.value("nom").toString();
        record["prenom"] = query.value("prenom").toString();
        record["age"] = query.value("age").toInt();
        qDebug() << "age: " << record["age"];
        dataList.append(record);
    }

    return dataList;
}

bool Backend::deleteData(int id) {
    QSqlQuery query;
    query.prepare("DELETE FROM qml_formulaire1 WHERE id = :id");
    query.bindValue(":id", id);
    if (!query.exec()) {
        qDebug() << "Erreur delete:" << query.lastError().text();
        return false;
    }
    return true;
}

bool Backend::updateData(int id, QString nom, QString prenom, int age) {
    QSqlQuery query;
    query.prepare("UPDATE qml_formulaire1 SET nom=:nom, prenom=:prenom, age=:age WHERE id=:id");
    query.bindValue(":id", id);
    query.bindValue(":nom", nom);
    query.bindValue(":prenom", prenom);
    query.bindValue(":age", age);
    if (!query.exec()) {
        qDebug() << "Erreur update:" << query.lastError().text();
        return false;
    }
    return true;
}
