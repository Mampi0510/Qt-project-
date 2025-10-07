#include "client.h"
#include "commande.h"
#include "DetailsCommande.h"
#include "facture.h"
#include "plat.h"   
#include <iostream>
#include <string>


int main() {
    std::cout << "Système de gestion de commandes de restaurant" << std::endl;
    //Exemple simple d'utilisation des classes
    client c;
    c.commander();

    commande cmd;
    cmd.ajouterCommande();

    detailsCommande dc;
    dc.afficherDetails();

    facture f;
    f.imprimer();

    plat p;
    p.ajouterPlat();
    
    return 0;
}