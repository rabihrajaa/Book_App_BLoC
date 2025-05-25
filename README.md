# Book App Flutter (BLoC Version)

Une application Flutter utilisant le pattern BLoC pour rechercher des livres via l'API Google Books et gérer des favoris localement avec SQLite.


## Interfaces de l'application

### Recherche de livres
<img src="page_home.png" alt="Page d'accueil" width="350"/>

### Favoris
<img src="page_favoris.png" alt="Page des favoris" width="350"/>


## Fonctionnalités

- Recherche dynamique via l'API Google Books
- Affichage élégant des résultats en cartes
- Ajout / suppression des favoris (stockage SQLite)
- Architecture basée sur le pattern BLoC
- Persistance locale avec Sqflite


## Fonctionnement du code


### Bloc
- `book_event.dart` : définit les événements (recherche de livres)
- `book_state.dart` : définit les états (chargement, succès, erreur)
- `book_bloc.dart` : contient la logique de traitement des événements

### Composant UI + BLoC : `home_page.dart`
- Champ `TextField` pour entrer un mot-clé
- Bouton déclenchant un événement `SearchBooks`
- `BlocBuilder` pour afficher un `ListView` de `BookCard` selon l'état

### SQLite : `db_service.dart`
- Gère `insertItem`, `deleteItem`, `getItems`, `isSaved`
- Initialise la DB `books.db` avec table `favorites`

### Modèle `Book`
- Représente un livre (id, title, author, thumbnail)
- Fournit `fromJson()` pour API et `toMap()` pour SQLite

### Favoris : `favorites_page.dart`
- Affiche les livres enregistrés avec suppression individuelle
- UI moderne avec header arrondi, image, titre, auteur


## Ressource utilisée

- 📘 [Documentation Google Books API](https://developers.google.com/books/docs/v1/using?hl=fr)


## Packages utilisés

| Package               | Rôle                                 |
|-----------------------|--------------------------------------|
| `flutter_bloc`        | Architecture logique (BLoC)          |
| `equatable`           | Comparaison d'états dans BLoC        |
| `http`                | Appels HTTP vers l'API Google Books |
| `sqflite`             | Stockage local (SQLite)              |
| `path`                | Construction de chemin de fichiers   |

---

