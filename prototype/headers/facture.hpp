#ifndef FACTURE_HPP 
#define FACTURE_HPP

class facture{
    public:
        void imprimer();
    private:
        int id_commande{0};
        int id_client{0};
        std::string dateFacture;
        double montantNet;
        void calculMontantNet();

};

#endif 