#include "headers/DetailsCommandes.h"
#include <QString>



DetailsCommandes::DetailsCommandes(QObject *parent):
    QObject(parent),
    commandeId(0),
    platId(0),
    quantite(0),
    prixUnitaire(0.0){
    
}
DetailsCommandes::~DetailsCommandes(){}
    //setters
    void DetailsCommandes::setCommandeId(int &Id){
        if(commandeId != Id){
            commandeId = Id;
            emit commandeIdChanged();
        }
    }
    void DetailsCommandes::setPlatId(int &IdC){
        if(platId != IdC){
            platId = IdC;
            emit platIdChanged();
        }
    }
    void DetailsCommandes::setQuantite(int &Quantite){
        if(quantite != Quantite){
            quantite = Quantite;
            emit quantiteChanged();
        }
    }
    void DetailsCommandes::setPrixUnitaire(double &Prix){
        if(prixUnitaire != Prix){
            prixUnitaire = Prix;
            emit prixUnitaireChanged();
        }
    }

    //getters
    int DetailsCommandes::getCommandeId()const{
        return commandeId;
    }
    int DetailsCommandes::getPlatId()const{
        return platId;
    }
    int DetailsCommandes::getQuantite()const{
        return quantite;
    }
    double DetailsCommandes::getPrixUnitaire()const{
        return prixUnitaire;
    }

    void DetailsCommandes::afficherDetails(){}
