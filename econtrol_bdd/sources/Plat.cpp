#include "headers/Plat.h"
#include <QString>



Plat::Plat(QObject *parent):
    QObject(parent),
    idPlat(0),
    nomPlat(""),
    prix(0.0),
    categorie(""){

}
Plat::~Plat(){}

    //setters
    void Plat::setIdPlat(int &Id){
        if(idPlat != Id){
            idPlat = Id;
            emit idPlatChanged();
        }
    }
    void Plat::setNomPlat(QString &Nom){
        if(nomPlat != Nom){
            nomPlat = Nom;
            emit nomPlatChanged();
        }
    }
    void Plat::setPrix(double &Prix){
        if(prix != Prix && Prix > 0.0){
            prix =  Prix;
            emit prixChanged();
        }
    }
    void Plat::setCategorie(QString &Categorie){
        if(categorie != Categorie){
            categorie = Categorie;
            emit categorieChanged();
        }
    }

    //getters
    int Plat::getIdPlat()const{
        return idPlat;
    }
    QString Plat::getNomPlat()const{
        return nomPlat;
    }
    double Plat::getPrix()const{
        return prix;
    }
    QString Plat::getCategorie()const{
        return categorie;
    }


    void Plat::ajouterPlat(){}
    void Plat::modifierPlat(){}
    void Plat::supprimerPlat(){}
















