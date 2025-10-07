#include "facture.h"
#include <iostream>
#include <string>

void facture::imprimer() {
    std::cout << "Impression de la facture." << std::endl;
    std::cout << "ID Commande: " << id_commande << ", ID Client: " << id_client 
              << ", Montant Net: " << montantNet << std::endl;
}

//Fonction a remplir
void facture::calculMontantNet() {
    std::cout << "Calcul du montant net de la facture." << std::endl;
    
}
