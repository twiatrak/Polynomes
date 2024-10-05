# Documentation de la bibliothèque de fonctions polynomiales en R

Cette bibliothèque fournit un ensemble complet de fonctions pour manipuler des polynômes en R. Les polynômes peuvent être représentés sous deux formes :
1. Forme creuse : une liste de paires (coefficient, puissance)
2. Forme dense : un vecteur où l'indice représente la puissance

## Fonctions de base

### is_poly0(p)
Vérifie si un polynôme est nul (égal à zéro).
- **Entrée** : p - un polynôme
- **Sortie** : TRUE si le polynôme est nul, FALSE sinon
- **Exemple** : `is_poly0(list(c(0, 0)))` renvoie TRUE

### degre(p)
Calcule le degré du polynôme.
- **Entrée** : p - un polynôme
- **Sortie** : le degré du polynôme (entier)
- **Exemple** : Pour x^2 + 2x + 1, renvoie 2

### poly2str(p)
Convertit un polynôme en une chaîne de caractères lisible.
- **Entrée** : p - un polynôme en forme creuse
- **Sortie** : une chaîne représentant le polynôme
- **Exemple** : `poly2str(list(c(1, 2), c(2, 0)))` renvoie "1*x^2 + 2*x^0"

## Fonctions de conversion

### make_poly(p)
Crée une représentation creuse d'un polynôme à partir d'une liste de coefficients.
- **Entrée** : p - un vecteur de coefficients
- **Sortie** : le polynôme en forme creuse
- **Exemple** : `make_poly(c(1, 0, 2))` renvoie list(c(1, 0), c(2, 2))

### TransformCreuse(p)
Convertit un polynôme de la forme creuse vers la forme dense.
- **Entrée** : p - un polynôme en forme creuse
- **Sortie** : le polynôme en forme dense
- **Exemple** : `TransformCreuse(list(c(1, 2), c(2, 0)))` renvoie c(2, 0, 1)

## Opérations arithmétiques

### mult_ext(p, s)
Multiplie un polynôme par un scalaire.
- **Entrée** : 
  - p - un polynôme
  - s - un scalaire
- **Sortie** : le polynôme multiplié par s
- **Exemple** : `mult_ext(list(c(1, 1)), 2)` renvoie list(c(2, 1))

### add(p, q) et addC(p1, p2)
Additionne deux polynômes.
- **Entrée** : deux polynômes
- **Sortie** : leur somme
- Note : addC gère spécifiquement l'addition en forme creuse

### sub(p, q) et subC(p1, p2)
Soustrait deux polynômes.
- **Entrée** : deux polynômes
- **Sortie** : leur différence
- Note : subC gère spécifiquement la soustraction en forme creuse

### mult(p1, p2)
Multiplie deux polynômes.
- **Entrée** : deux polynômes
- **Sortie** : leur produit
- Utilise MultMonom et MultPoly en interne

## Évaluation et calcul

### PolyValC(p, x)
Évalue un polynôme pour une valeur donnée.
- **Entrée** : 
  - p - un polynôme
  - x - la valeur à évaluer
- **Sortie** : la valeur du polynôme en x

### Horner(p, a)
Évalue un polynôme efficacement utilisant la méthode de Horner.
- **Entrée** : 
  - p - un polynôme
  - a - la valeur à évaluer
- **Sortie** : la valeur du polynôme en a
- Note : généralement plus rapide que PolyValC pour les grands polynômes

### Primitive(p)
Calcule la primitive du polynôme.
- **Entrée** : p - un polynôme
- **Sortie** : la primitive du polynôme
- Note : ajoute une constante d'intégration nulle

### Deriv(p)
Calcule la dérivée du polynôme.
- **Entrée** : p - un polynôme
- **Sortie** : la dérivée du polynôme

## Fonctions utilitaires

### RandPoly(n, coefs)
Génère un polynôme aléatoire.
- **Entrée** : 
  - n - le degré du polynôme
  - coefs - vecteur de coefficients possibles
- **Sortie** : un polynôme aléatoire

### SortPoly(p)
Trie les termes d'un polynôme par degré décroissant.
- **Entrée** : p - un polynôme
- **Sortie** : le polynôme avec ses termes triés

### dessiner(p, x)
Trace le graphe du polynôme, de sa primitive et de sa dérivée.
- **Entrée** : 
  - p - un polynôme
  - x - vecteur de valeurs x pour le tracé
- **Sortie** : un graphique avec trois courbes

## Exemples d'utilisation

```r
# Créer un polynôme : x^2 - 2x + 1
p1 <- list(c(1, 2), c(-2, 1), c(1, 0))

# Évaluer en x = 2
valeur <- PolyValC(p1, 2)

# Calculer la dérivée
derivee <- Deriv(p1)

# Tracer le polynôme
x <- seq(-2, 2, by = 0.1)
dessiner(p1, x)
```

## Notes d'optimisation

- La forme creuse est plus efficace pour les polynômes avec beaucoup de coefficients nuls
- La méthode de Horner est plus rapide pour l'évaluation des grands polynômes
- Les opérations conservent automatiquement la forme la plus appropriée
