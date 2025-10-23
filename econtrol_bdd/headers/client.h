#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QString>

class Client : public QObject {
    Q_OBJECT

    Q_PROPERTY(int idClient READ getIdClient WRITE setIdClient NOTIFY idClientChanged)
    Q_PROPERTY(QString nom READ getNom WRITE setNom NOTIFY nomChanged)
    Q_PROPERTY(QString prenom READ getPrenom WRITE setPrenom NOTIFY prenomChanged)
    Q_PROPERTY(QString telephone READ getTelephone WRITE setTelephone NOTIFY telephoneChanged)

public:
    explicit Client(QObject *parent = nullptr);
    ~Client(); //Déclaration du destructeur

    // Getters & Setters
    int getIdClient() const;
    QString getNom() const;
    QString getPrenom() const;
    QString getTelephone() const;

    void setIdClient(int id);
    void setNom(const QString &nom);
    void setPrenom(const QString &prenom);
    void setTelephone(const QString &telephone);

signals:
    void idClientChanged();
    void nomChanged();
    void prenomChanged();
    void telephoneChanged();

private:
    int idClient;
    QString nom;
    QString prenom;
    QString telephone;
};

#endif // CLIENT_H
