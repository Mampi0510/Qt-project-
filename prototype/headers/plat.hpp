#include <iostream>

class plat{
    public:
        std::string categorie;
        void ajouterPlat();
        void supprimerPlat();
        void modifierPlat();
    protected:
        int id_plat{0};
    private:
        std::string nom_plat
        double prix;
}