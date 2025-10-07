#ifndef FACTURE_HPP 
#define FACTURE_HPP

class Facture{
    public:
        //Constructeur
        Facture(int idCommande, int idClient, double montant);
        //Getter
        int getIdCommande() const;
        int getIdClient() const;
        double getMontantNet() const;
        void imprimer();
    private:
        int id_commande{0};
        int id_client{0};
        std::string dateFacture;
        double montantNet;
        void calculMontantNet();

};

#endif 