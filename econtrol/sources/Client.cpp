#include "headers/Client.h"
#include <QString>


Client::Client(QObject *parent):
    QObject(parent),
    idClient(0),
    nom(""),
    prenom(""),
    telephone(""){
}
Client::~Client(){}

    //setters
    void Client::setIdClient(int &Id){
        if(idClient != Id)
            idClient = Id;
        emit idClientChanged();
    }
    void Client::setNom(QString &Nom){
        if(nom != Nom){
            nom = Nom;
            emit nomChanged();
        }
    }
    void Client::setPrenom(QString &Prenom){
        if(prenom != Prenom){
            prenom = Prenom;
            emit prenomChanged();
        }
    }
    void Client::setTelephone(QString &Telephone){
        if(telephone != Telephone){
            telephone = Telephone;
            emit telephoneChanged();
        }
    }

    //getters
    int Client::getIdClient() const{
        return idClient;
    }
    QString Client::getNom() const{
        return nom;
    }
    QString Client::getPrenom() const{
        return prenom;
    }
    QString Client::getTelephone() const{
        return telephone;
    }


    void Client::ajouterClient(){}
    void Client::modifierClient(){}
    void Client::supprimerClient(){}
