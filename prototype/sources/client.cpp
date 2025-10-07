

#include "../headers/client.hpp"
#include "../headers/commande.hpp"
#include <iostream>
#include <string>
#include <regex>


//Initialisation du client
Client::Client(int id, const std::string& n, const std::string& p, const std::string& telephone)
{
    id_client = id;
    nom = n;
    prenom = p;
    setTelephone(telephone);
}

//getters 
int Client::getId() const { return id_client; }
std::string Client::getNom() const { return nom; }
std::string Client::getPrenom() const { return prenom; }
std::string Client::getTelephone() const { return telephone; }

//setters
void Client::setNom(const std::string& n) { nom = n; }
void Client::setPrenom(const std::string& p) { prenom = p; }

void Client::setTelephone(const std::string& t) {
    // Validation simple : autorise chiffres, espaces, +, -, (), et min 6 caractères
    std::regex re("^[0-9+\-() ]{6,}$");
    if (!std::regex_match(t, re)) {
        throw std::invalid_argument("Téléphone invalide : " + t);
    }
    telephone = t;
}

int Client::commander(const std::vector<std::pair<int,int>>& items) {
    if (items.empty()) {
        throw std::invalid_argument("La commande ne peut pas être vide.");
    }

    Commande c(id_client, items);
    c.ajouterCommande();
    // Possibilité de modifier la commande ici (ex: appliquer remises)
    c.genererFacture();

    std::cout << "Commande créée avec id=" << c.getId() << " total=" << c.getTotal() << std::endl;
    return c.getId();
}
