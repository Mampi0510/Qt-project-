#ifndef COMMANDE_HPP
#define COMMANDE_HPP

class Commande {
    public:
        void ajouterCommande();
        void modifierCommande();
        void genererFacture();
    protected:
        int id_commande{0};
    private:
        int id_client{0};
        std::string date_commande;
        int total{0};
        void calculTotal();
};
#endif