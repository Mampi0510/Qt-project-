#ifndef FACTURE_H
#define FACTURE_H

#include <QObject>
#include <qdatetime.h>
#include <QString>
#include <connection.h>


class Facture: public QObject{
    Q_OBJECT

    Q_PROPERTY(int  idFacture READ getIdFacture WRITE setIdFacture NOTIFY idFactureChanged)
    Q_PROPERTY(int  commandeId READ getCommandeId WRITE setCommandeId NOTIFY commandeIdChanged)
    Q_PROPERTY(int  clientId READ getClientId WRITE setClientId NOTIFY clientIdChanged)
    Q_PROPERTY(QDateTime date READ getDate WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(double montantNet READ getMontantNet WRITE setMontantNet NOTIFY montantNetChanged)

    public:
        explicit Facture(QObject *parent = nullptr);
        ~Facture();

        //setters
        void setIdFacture(int &IdFacture);
        void setCommandeId(int &CommandeId);
        void setClientId(int &ClientId);
        void setDate(QDateTime &Date);
        void setMontantNet(double &MontantNet);

        //getters
        int getIdFacture() const;
        int getCommandeId() const;
        int getClientId() const;
        QDateTime getDate() const;
        double getMontantNet() const;

        Q_INVOKABLE void afficherFacture();

    public slots:
        void calculMontantNet();
    signals:
        void idFactureChanged();
        void commandeIdChanged();
        void clientIdChanged();
        void dateChanged();
        void montantNetChanged();
    private:
        int idFacture;
        int commandeId;
        int clientId;
        QDateTime date;
        double montantNet;
};

#endif
