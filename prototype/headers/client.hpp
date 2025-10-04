#include <iostream>

class client{
    public:
        void commander();

    protected:
        int id_client{0};
    
    private:
        std::string nom, prenom, telephone;
}