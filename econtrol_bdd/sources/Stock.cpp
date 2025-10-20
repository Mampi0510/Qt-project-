#include "headers/Stock.h"
#include <QString>



Stock::Stock(QObject *parent):
    QObject(parent),
    idProduit(0),
    nomProduit(""),
    quantite(0.0){

}
Stock::~Stock(){}
        //setters
        void Stock::setIdProduit(int &Id){
            if(idProduit != Id){
                idProduit = Id;
                emit idProduitChanged();
            }
        }
        void Stock::setNomProduit(QString &Nom){
            if(nomProduit != Nom){
                nomProduit = Nom;
                emit nomProduitChanged();
            }
        }
        void Stock::setQuantite(double &Quantite){
            if(quantite !=  Quantite){
                quantite = Quantite;
                emit quantiteChanged();
            }
        }

        //getters
        int Stock::getIdProduit()const{
            return idProduit;
        }
        QString Stock::getNomProduit()const{
            return nomProduit;
        }
        double Stock::getQuantite()const{
            return quantite;
        }

        void Stock::ajouterProduit(){}
        void Stock::modifierProduit(){}
        void Stock::supprimerProduit(){}












