#ifndef COMMANDE_H
#define COMMANDE_H

#include <QObject>
#include <QDateTime>
#include <QString>
#include <connection.h>

class Commande: public QObject{
    Q_OBJECT

    Q_PROPERTY(int idCommande READ getIdCommande WRITE setIdCommande NOTIFY idCommandeChanged)
    Q_PROPERTY(int clientId READ getClientId WRITE setClientId NOTIFY clientIdChanged)
    Q_PROPERTY(QDateTime date READ getDate WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(int total READ getTotal WRITE setTotal NOTIFY totalChanged)

    public:
        explicit Commande(QObject *parent = nullptr);
        ~Commande();

        //setters
        void setIdCommande(int &IdCommande);
        void setClientId(int &ClientId);
        void setDate(QDateTime &date);
        void setTotal(int &Total);

        //getters
        int getIdCommande() const;
        int getClientId() const;
        QDateTime getDate() const;
        int getTotal() const;

        Q_INVOKABLE void ajouterCommande();
        Q_INVOKABLE void modifierCommande();
        Q_INVOKABLE void supprimerCommande();
    public slots:
        void calculerTotal();

    signals:
        void idCommandeChanged();
        void clientIdChanged();
        void dateChanged();
        void totalChanged();

    private:
        int idCommande;
        int clientId;
        QDateTime date; //date commande
        int total; //total commande

};

#endif // COMMANDE_H
