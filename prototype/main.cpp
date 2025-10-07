#include "headers/client.hpp"
#include "headers/commande.hpp"
#include <iostream>
#include <vector>

int main() {
    std::cout << "Système de gestion de commandes de restaurant - Test" << std::endl;

    // Créer un client
    Client c(1, "Dupont", "Jean", "+33123456789");

    // Préparer une commande : vector<pair<id_plat, quantite>>
    std::vector<std::pair<int,int>> items = { {1,2}, {3,1}, {5,4} };

    try {
        int idCmd = c.commander(items);
        std::cout << "Commande passée avec succès, id = " << idCmd << std::endl;
    } catch (const std::exception& e) {
        std::cerr << "Erreur lors de la commande : " << e.what() << std::endl;
        return 1;
    }

    return 0;
}