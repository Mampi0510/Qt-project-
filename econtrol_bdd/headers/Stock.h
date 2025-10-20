#ifndef STOCK_H
#define STOCK_H

#include <QObject>
#include <QString>


class Stock: public QObject{
    Q_OBJECT
    Q_PROPERTY(int idProduit READ getIdProduit WRITE setIdProduit NOTIFY idProduitChanged)
    Q_PROPERTY(QString nomProduit READ getNomProduit WRITE setNomProduit NOTIFY nomProduitChanged)
    Q_PROPERTY(double quantite READ getQuantite WRITE setQuantite NOTIFY quantiteChanged)

    public:
        explicit Stock(QObject *parent = nullptr);
        ~Stock();

        //setters
        void setIdProduit(int &IdProduit);
        void setNomProduit(QString &NomProduit);
        void setQuantite(double &Quantite);

        //getters
        int getIdProduit() const;
        QString getNomProduit() const;
        double getQuantite() const;

        Q_INVOKABLE void ajouterProduit();
        Q_INVOKABLE void modifierProduit();
        Q_INVOKABLE void supprimerProduit();

    signals:
        void idProduitChanged();
        void nomProduitChanged();
        void quantiteChanged();

    private:
        int idProduit;
        QString nomProduit;
        double quantite;
};


#endif
