#ifndef CLIENT_HPP
#define CLIENT_HPP 

#include <string>
#include <vector>

class Commande; // forward declaration

class Client {
public:
    //Constructeurs
    Client() = default;
    //Surcharge du constructeur
    Client(int id_client, const std::string& nom, const std::string& prenom, const std::string& telephone);

    // Getters
    int getIdClient() const;
    std::string getNom() const;
    std::string getPrenom() const;
    std::string getTelephone() const;

    // Setters 
    void setNom(const std::string& nom);
    void setPrenom(const std::string& prenom);
    void setTelephone(const std::string& telephone);

    int commander(const std::vector<int>& items);

protected:
    int id_client {0};
private:
    std::string nom;
    std::string prenom;
    std::string telephone;
};

#endif