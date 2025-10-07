#ifndef CLIENT_HPP
#define CLIENT_HPP 


class client {
    public:
        void commander();
    protected:
        int id_client {0};
    private:
        std::string nom;
        std::string prenom;
        std::string telephone;
};

#endif