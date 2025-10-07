#include "detailsCommande.h"
#include <iostream>
#include <string>

void detailsCommande::afficherDetails(int idCommande, int idPlat, int quantite, double prixUnitaire) {
    std::cout << "Affichage des détails de la commande." << std::endl;
    std::cout << "ID Commande: " << idCommande << ", ID Plat: " << idPlat 
              << ", Quantité: " << quantite << ", Prix Unitaire: " << prixUnitaire << std::endl;    
}