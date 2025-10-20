#ifndef PLAT_H
#define PLAT_H

#include <QObject>
#include <QString>


class Plat: public QObject{
    Q_OBJECT
    Q_PROPERTY(int idPlat READ getIdPlat WRITE setIdPlat NOTIFY idPlatChanged)
    Q_PROPERTY(QString nomPlat READ getNomPlat WRITE setNomPlat NOTIFY nomPlatChanged)
    Q_PROPERTY(double prix READ getPrix WRITE setPrix NOTIFY prixChanged)
    Q_PROPERTY(QString categorie READ getCategorie WRITE setCategorie NOTIFY categorieChanged)

    public:
        explicit Plat(QObject *parent = nullptr);
        ~Plat();
        
    //setters
        void setIdPlat(int &IdPlat);
        void setNomPlat(QString &NomPlat);
        void setPrix(double &Prix);
        void setCategorie(QString &Categorie);
    //getters
        int getIdPlat() const;
        QString getNomPlat() const;
        double getPrix() const;
        QString getCategorie() const;

        Q_INVOKABLE void ajouterPlat();
        Q_INVOKABLE void modifierPlat();
        Q_INVOKABLE void supprimerPlat();

    signals:
        void idPlatChanged();
        void nomPlatChanged();
        void prixChanged();
        void categorieChanged();
        
    private:
        int idPlat;
        QString nomPlat;
        double prix;
        QString categorie;
        
};

#endif
