#include <iostream>

class facture{
    public:
        void afficherFacture();
    private:
        int id_commande{0}, id_client{0};
        std::string date;
        double net_a_payer;

        double calcul_net_a_payer;
}