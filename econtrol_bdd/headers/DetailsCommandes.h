#ifndef DETAILSCOMMANDES_H
#define DETAILSCOMMANDES_H

#include <QObject>
#include <QString>
#include <connection.h>


class DetailsCommandes: public QObject{
    Q_OBJECT

    Q_PROPERTY(int commandeId READ getCommandeId WRITE setCommandeId NOTIFY commandeIdChanged)
    Q_PROPERTY(int PlatId READ getPlatId WRITE setPlatId NOTIFY platIdChanged)
    Q_PROPERTY(int quantite READ getQuantite WRITE setQuantite NOTIFY quantiteChanged)
    Q_PROPERTY(double prixUnitaire READ getPrixUnitaire WRITE setPrixUnitaire NOTIFY prixUnitaireChanged)

    public:
        explicit DetailsCommandes(QObject *parent = nullptr);
        ~DetailsCommandes();

        //setters
        void setCommandeId(int &CommandeId);
        void setPlatId(int &ClientId);
        void setQuantite(int &Quantite);
        void setPrixUnitaire(double &PrixUnitaire);

        //getters
        int getCommandeId() const;
        int getPlatId() const;
        int getQuantite() const;
        double getPrixUnitaire() const;

        Q_INVOKABLE void afficherDetails();

    signals:
        void commandeIdChanged();
        void platIdChanged();
        void quantiteChanged();
        void prixUnitaireChanged();

    private:
        int commandeId;
        int platId;
        int quantite;
        double prixUnitaire;
};

#endif  // DETAILSCOMMANE_H
