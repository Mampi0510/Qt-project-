#ifndef DETAILSCOMMANDE_HPP
#define DETAILSCOMMANDE_HPP

class DetailsCommande {
    public:
        //constructeur
        DetailsCommande();
        //Suracharge du constructeur
        DetailsCommande(int idCommande, int idPlat, int quantite, double prixUnitaire);
        //Getters
        int getIdCommande() const;
        int getIdPlat() const;
        int getQuantite() const;
        int getPrixUnitaire() const;
        
        void afficherDetails();
    private:
        int id_commande{0};
        int id_plat{0};
        int quantite{0};
        double prix_unitaire{0.};        
};


#endif