#ifndef CLIENT_HPP
#define CLIENT_HPP 

#include <string>
#include <vector>
#include <utility>
#include <stdexcept>

class Commande; // forward declaration

class Client {
public:
    Client() = default;
    Client(int id, const std::string& nom, const std::string& prenom, const std::string& telephone);

    // Accesseurs
    int getId() const;
    std::string getNom() const;
    std::string getPrenom() const;
    std::string getTelephone() const;

    // Mutateurs
    void setNom(const std::string& n);
    void setPrenom(const std::string& p);
    // Validation simple du téléphone : accepte chiffres, espaces, +, -, parenthèses
    // Lance std::invalid_argument si invalide
    void setTelephone(const std::string& t);

    // Passer une commande : vector< pair<id_plat, quantite> >
    // Retourne l'identifiant de la commande créée
    int commander(const std::vector<std::pair<int,int>>& items);

protected:
    int id_client {0};
private:
    std::string nom;
    std::string prenom;
    std::string telephone;
};

#endif