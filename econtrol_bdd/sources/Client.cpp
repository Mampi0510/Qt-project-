#include "headers/Client.h"
#include <QString>

Client::Client(QObject *parent)
    : QObject(parent),
    idClient(0),
    nom(""),
    prenom(""),
    telephone("")
{
}

Client::~Client() {} // ✅ Définition du destructeur

// --- SETTERS ---
void Client::setIdClient(int id) {
    if (idClient != id) {
        idClient = id;
        emit idClientChanged();
    }
}

void Client::setNom(const QString &Nom) {
    if (nom != Nom) {
        nom = Nom;
        emit nomChanged();
    }
}

void Client::setPrenom(const QString &Prenom) {
    if (prenom != Prenom) {
        prenom = Prenom;
        emit prenomChanged();
    }
}

void Client::setTelephone(const QString &Telephone) {
    if (telephone != Telephone) {
        telephone = Telephone;
        emit telephoneChanged();
    }
}

// --- GETTERS ---
int Client::getIdClient() const {
    return idClient;
}

QString Client::getNom() const {
    return nom;
}

QString Client::getPrenom() const {
    return prenom;
}

QString Client::getTelephone() const {
    return telephone;
}

// --- Méthodes de gestion (à implémenter plus tard) ---
void Client::ajouterClient() {}
void Client::modifierClient() {}
void Client::supprimerClient() {}
