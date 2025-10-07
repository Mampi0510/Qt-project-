#ifndef COMMANDE_HPP
#define COMMANDE_HPP

#include <vector>
#include <utility>
#include <string>

class Commande {
public:
    Commande() = default;
    Commande(int idClient, const std::vector<std::pair<int,int>>& items);

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
    std::vector<std::pair<int,int>> items; // pair<id_plat, quantite>

    void calculTotal();
};

#endif