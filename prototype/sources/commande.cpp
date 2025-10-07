#include "commande.h"
#include <iostream>
#include <string>

#include "../headers/commande.hpp"
#include <chrono>
#include <ctime>

// Constructeur initialisant le client et les items
Commande::Commande(int idClient, const std::vector<std::pair<int,int>>& items)
    : id_client(idClient), items(items)
{
    // id_commande simple basé sur l'heure pour la démo
    auto now = std::chrono::system_clock::now();
    auto secs = std::chrono::duration_cast<std::chrono::seconds>(now.time_since_epoch()).count();
    id_commande = static_cast<int>(secs % 1000000);
    // date_commande en chaîne
    std::time_t t = std::chrono::system_clock::to_time_t(now);
    date_commande = std::ctime(&t);
    calculTotal();
}

int Commande::getId() const { return id_commande; }
int Commande::getClientId() const { return id_client; }
int Commande::getTotal() const { return total; }

void Commande::ajouterCommande() {
    std::cout << "Ajout d'une nouvelle commande id=" << id_commande << " pour client " << id_client << std::endl;
}

void Commande::modifierCommande() {
    std::cout << "Modification de la commande id=" << id_commande << std::endl;
    // Pour la démo, recalculer le total après modification
    calculTotal();
}

void Commande::genererFacture() {
    std::cout << "Génération de la facture pour la commande id=" << id_commande << ", montant=" << total << std::endl;
}

void Commande::calculTotal() {
    // Simulation simple : chaque plat coûte 10 unités * (id_plat % 5 + 1) pour variation
    int t = 0;
    for (auto &it : items) {
        int id_plat = it.first;
        int quantite = it.second;
        int prix = 10 * ((id_plat % 5) + 1);
        t += prix * quantite;
    }
    total = t;
}
