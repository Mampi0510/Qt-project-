# Gestion Restaurant - Application Qt 🍽️

Application de gestion de restaurant développée en Qt avec intégration MySQL. Ce guide explique comment utiliser l'application.

---

## 📋 Table des matières

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Démarrage de l'application](#démarrage-de-lapplication)
4. [Guide d'utilisation](#guide-dutilisation)
5. [Fonctionnalités](#fonctionnalités)
6. [Dépannage](#dépannage)

---

## 🔧 Installation

### Prérequis système

- **Qt Framework** (5.15+)
- **MySQL Server** (5.7+)
- **C++ Compiler** (GCC, MSVC, ou Clang)
- **CMake** (3.16+) ou **QMake**

### Étape 1 : Cloner le projet

```bash
git clone https://github.com/Mampi0510/Qt-project-.git
cd Qt-project-
```

### Étape 2 : Installer les dépendances

#### Sur Ubuntu/Debian :
```bash
sudo apt-get update
sudo apt-get install qt5-qmake qt5-default libqt5mysql5
sudo apt-get install mysql-server mysql-client
```

#### Sur Windows :
- Télécharger et installer [Qt Creator](https://www.qt.io/)
- Installer [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)

#### Sur macOS :
```bash
brew install qt mysql cmake
```

### Étape 3 : Compiler l'application

**Avec CMake :**
```bash
mkdir build
cd build
cmake ..
make
```

**Avec QMake :**
```bash
qmake
make
```

---

## ⚙️ Configuration

### Configuration de la base de données

Avant de lancer l'application, configurez la connexion MySQL :

1. **Créer la base de données :**
```bash
mysql -u root -p < database/schema.sql
```

2. **Fichier de configuration** (`config/db_config.ini`) :
```ini
[Database]
host=localhost
port=3306
user=root
password=votre_motdepasse
database=restaurant_db
```

3. **Vérifier la connexion :**
```bash
mysql -h localhost -u root -p restaurant_db
```

---

## 🚀 Démarrage de l'application

### Lancer l'application

```bash
./build/RestaurantManager
```

ou depuis Qt Creator :
- Ouvrir le projet (.pro ou CMakeLists.txt)
- Cliquer sur "Run" (Ctrl+R)

### Interface de connexion

1. **Page de login** (première utilisation) :
   - Nom d'utilisateur : `admin`
   - Mot de passe : `admin`
   - Cliquer sur **"Connexion"**

2. **Créer un nouveau compte** :
   - Cliquer sur **"Créer un compte"**
   - Remplir les champs (nom, email, mot de passe)
   - Valider

---

## 📱 Guide d'utilisation

### 1️⃣ Accueil - Tableau de bord

- **Vue d'ensemble** : Nombre de commandes du jour, revenus, clients actifs
- **Boutons rapides** :
  - 📝 Nouvelle commande
  - 👥 Gestion des clients
  - 📊 Statistiques
  - ⚙️ Paramètres

### 2️⃣ Prendre une commande

**Chemin :** Menu → Commandes → Nouvelle commande

1. **Sélectionner le client** :
   - Cliquer sur le champ "Client"
   - Chercher ou créer un client
   - Le client apparaît en haut à droite

2. **Ajouter des plats** :
   - Cliquer sur **"+ Ajouter un plat"**
   - Sélectionner dans le catalogue :
     - Entrées 🥗
     - Plats principaux 🍖
     - Desserts 🍰
     - Boissons 🥤
   - Indiquer la quantité
   - Cliquer sur **"Ajouter"**

3. **Modifier une commande** :
   - Cliquer sur un plat pour modifier la quantité
   - Cliquer sur ❌ pour supprimer
   - Le total se met à jour automatiquement

4. **Valider la commande** :
   - Vérifier le récapitulatif
   - Sélectionner le mode de paiement :
     - 💳 Carte bancaire
     - 💵 Espèces
     - 📱 Mobile payment
   - Cliquer sur **"Confirmer la commande"**

### 3️⃣ Gestion des clients

**Chemin :** Menu → Clients

- **Voir tous les clients** : Liste avec contact et historique
- **Ajouter un client** :
  - Cliquer sur **"+ Nouveau client"**
  - Remplir : Nom, Prénom, Téléphone, Email
  - Cliquer sur **"Enregistrer"**
- **Consulter l'historique** : Cliquer sur un client pour voir ses commandes
- **Modifier un client** : Cliquer sur ✏️ pour éditer
- **Supprimer un client** : Cliquer sur 🗑️

### 4️⃣ Gestion du menu

**Chemin :** Menu → Catalogue → Gestion du menu

- **Ajouter un plat** :
  - Cliquer sur **"+ Ajouter un plat"**
  - Remplir : Nom, Catégorie, Prix, Ingrédients, Image
  - Cliquer sur **"Enregistrer"**

- **Modifier un plat** :
  - Cliquer sur ✏️ sur le plat
  - Modifier les informations
  - Cliquer sur **"Mettre à jour"**

- **Désactiver un plat** :
  - Cliquer sur le plat
  - Cliquer sur **"Désactiver"** (le plat ne s'affiche plus mais reste en base)

### 5️⃣ Statistiques et rapports

**Chemin :** Menu → Rapports → Statistiques

- **Ventes du jour** : Montant total, nombre de commandes
- **Top 5 plats** : Les plus vendus
- **Revenus par semaine** : Graphique en colonnes
- **Clientèle** : Nombre de clients uniques, clients fidèles
- **Exporter les rapports** :
  - Cliquer sur **"📥 Télécharger en PDF"**
  - Cliquer sur **"📊 Exporter en CSV"**

### 6️⃣ Historique des commandes

**Chemin :** Menu → Commandes → Historique

- **Filtrer les commandes** :
  - Par date (De ... À ...)
  - Par client
  - Par statut (Confirmée, En cours, Livrée, Annulée)

- **Consulter une commande** :
  - Cliquer sur une ligne pour voir les détails
  - Voir les plats, le montant, la date, le client

- **Actions** :
  - 🖨️ Imprimer le reçu
  - ❌ Annuler la commande
  - 🔄 Dupliquer la commande

### 7️⃣ Gestion des utilisateurs

**Chemin :** Menu → Paramètres → Utilisateurs (Admin uniquement)

- **Ajouter un utilisateur** :
  - Cliquer sur **"+ Nouveau utilisateur"**
  - Remplir : Nom, Email, Rôle (Admin, Serveur, Cuisinier)
  - Attribuer un mot de passe temporaire
  - Cliquer sur **"Créer"**

- **Modifier les droits d'accès** :
  - Sélectionner un utilisateur
  - Cliquer sur ✏️
  - Modifier le rôle
  - Cliquer sur **"Mettre à jour"**

---

## ✨ Fonctionnalités principales

### Commandes
- ✅ Création rapide de commandes
- ✅ Modification avant confirmation
- ✅ Historique complet
- ✅ Impression des reçus
- ✅ Annulation avec motif

### Clients
- ✅ Base de données des clients
- ✅ Historique des achats
- ✅ Notes personnelles
- ✅ Gestion des préférences

### Menu
- ✅ Catalogue dynamique
- ✅ Catégories (Entrées, Plats, Desserts, Boissons)
- ✅ Gestion des prix
- ✅ Photos des plats
- ✅ Gestion des ingrédients

### Rapports
- ✅ Statistiques en temps réel
- ✅ Graphiques intuitifs
- ✅ Export PDF/CSV
- ✅ Rapports personnalisés

### Sécurité
- ✅ Authentification utilisateur
- ✅ Gestion des rôles
- ✅ Logs d'activité
- ✅ Chiffrement des données sensibles

---

## 🐛 Dépannage

### "Erreur de connexion à la base de données"

**Solution :**
1. Vérifier que MySQL est démarré :
```bash
sudo service mysql status
```

2. Vérifier les identifiants dans `config/db_config.ini`

3. Relancer l'application

### "Port 3306 déjà utilisé"

```bash
# Trouver le processus qui utilise le port
lsof -i :3306

# Terminer le processus
kill -9 <PID>
```

### "Application ne démarre pas après compilation"

1. Nettoyer et recompiler :
```bash
rm -rf build
mkdir build && cd build
cmake ..
make
```

2. Vérifier les dépendances Qt :
```bash
ldd ./RestaurantManager | grep "not found"
```

### "Les tables MySQL n'existent pas"

Importer le schéma :
```bash
mysql -u root -p restaurant_db < database/schema.sql
```

### "Erreur de permission d'accès"

- Vérifier l'utilisateur MySQL avec les bonnes permissions
- Exécuter en tant qu'administrateur si nécessaire

---

## 📞 Support et contact

- **Développeur principal** : Mampiadana
- **GitHub** : [Mampi0510/Qt-project-](https://github.com/Mampi0510/Qt-project-)

---

## 📝 Notes importantes

- **Sauvegarde** : Les données sont automatiquement sauvegardées dans MySQL
- **Accès multi-utilisateurs** : L'application supporte plusieurs utilisateurs connectés simultanément
- **Rapports** : Les statistiques se mettent à jour en temps réel
- **Maintenance** : Vérifier les logs d'erreur dans `logs/app.log`

---

## 🎓 Version

**Version actuelle** : 1.0.0  
**Date de mise à jour** : Novembre 2025  

---

**Dernière mise à jour** : 2025-11-06
