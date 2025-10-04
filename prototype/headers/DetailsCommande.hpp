#ifndef DETAILSCOMMANDE_HPP
#define DETAILSCOMMANDE_HPP

class detailsCommande {
    public:
        void afficherDetails();
    private:
        int id_commande{0};
        int id_plat{0};
        int quantite{0};
        double prix_unitaire{0.};        
};


#endif