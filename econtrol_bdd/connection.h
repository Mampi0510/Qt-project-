#ifndef CONNECTION_H
#define CONNECTION_H

#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>

static bool my_connection(){
    QSqlDatabase bdd = QSqlDatabase::addDatabase("QMySQL");
    bdd.setHostName("localhost");
    bdd.setUserName("root");
    bdd.setDatabaseName("econtrol_db");
    bdd.setPassword("");
    bdd.setPort(3306);

    if(bdd.open()){
        return true;
    }else{
        return false;
    }
}

#endif // CONNECTION_H
