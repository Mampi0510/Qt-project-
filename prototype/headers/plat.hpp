#ifndef PLAT_HPP
#define PALT_HPP

class Plat{
    public:
        //Constructeurs
        Plat();
        //Surcharge du constructeur
        Plat(int idPlat, const std::string& nomPlat, double prix, const std::string& categorie);

        //Getters
        int getIdPlat() const;
        std::string getNomPlat() const;  
        double getPrix() const;
        std::string getCategorie() const;

        //Setters
        void setNomPlat(const std::string& nomPlat);
        void setPrix(double prix);  
        void setCategorie(const std::string& categorie);
        
        std::string categorie;
        void ajouterPlat();
        void supprimerPlat();
        void modifierPlat();
    protected:
        int id_plat{0};
    private:
        std::string nom_plat;
        double prix{0.};
};

#endif