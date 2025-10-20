#include "headers/Facture.h"
#include <QString>


Facture::Facture(QObject *parent):
    QObject(parent),
    idFacture(0),
    commandeId(0),
    clientId(0),
    date(),
    montantNet(0.0){

}
Facture::~Facture(){}
        //setters
        void Facture::setIdFacture(int &IdFacture){
            if(idFacture != IdFacture){
                idFacture = IdFacture;
                emit idFactureChanged();
            }
        }
        void Facture::setCommandeId(int &Id){
            if(commandeId != Id){
                commandeId = Id;
                emit commandeIdChanged();
            }
        }
        void Facture::setClientId(int &IdC){
            if(clientId != IdC){
                clientId = IdC;
                emit clientIdChanged();
            }
        }
        void Facture::setDate(QDateTime &Date){
            date = QDateTime::currentDateTime();
            emit dateChanged();
        }
        void Facture::setMontantNet(double &Montant){
            if(montantNet != Montant){
                montantNet = Montant;
                emit montantNetChanged();
            }
        }


        //getters
        int Facture::getIdFacture()const{
            return idFacture;
        }
        int Facture::getCommandeId()const{
            return commandeId;
        }
        int Facture::getClientId()const{
            return clientId;
        }
        QDateTime Facture::getDate()const{
            return date;
        }
        double Facture::getMontantNet()const{
            return montantNet;
        }


        void Facture::afficherFacture(){}
        void Facture::calculMontantNet(){}















