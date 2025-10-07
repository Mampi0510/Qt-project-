#ifndef COMMANDE_HPP
#define COMMANDE_HPP

#include <vector>
#include <string>

class Commande {
public:
    //Constructeurs
    Commande() = default;
    //Surcharge du constructeur
    Commande(int idClient, const std::vector<int>& items);

    // Getters
    int getId() const;
    int getClientId() const;
    int getTotal() const;

    void ajouterCommande();
    void modifierCommande();
    void genererFacture();

protected:
    int id_commande{0};
private:
    int id_client{0};
    std::string date_commande;
    int total{0};
    std::vector<int> items;
    void calculTotal();
};

#endif