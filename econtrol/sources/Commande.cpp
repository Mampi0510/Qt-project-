#include "headers/Commande.h"
#include <QString>



Commande::Commande(QObject *parent):
    QObject(parent),
    idCommande(0),
    clientId(0),
    date(),
    total(0){

}
Commande::~Commande(){}

    //setters
    void Commande::setIdCommande(int &Id){
        if(idCommande != Id){
            idCommande = Id;
            emit idCommandeChanged();
        }
    }
    void Commande::setClientId(int &IdC){
        if(clientId != IdC){
            clientId = IdC;
            emit clientIdChanged();
        }
    }
    void Commande::setDate(QDateTime &Date){
        date = QDateTime::currentDateTime();
        emit dateChanged();
    }
    void Commande::setTotal(int &Total){
        if(total != Total){
            total = Total;
            emit totalChanged();
        }
    }

    //getters
    int Commande::getIdCommande()const{
        return idCommande;
    }
    int Commande::getClientId()const{
        return clientId;
    }
    QDateTime Commande::getDate()const{
        return date;
    }
    int Commande::getTotal()const{
        return total;
    }

    void Commande::ajouterCommande(){}
    void Commande::modifierCommande(){}
    void Commande::supprimerCommande(){}

    void Commande::calculerTotal(){}
