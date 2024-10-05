# Bibliothèque de fonctions pour la manipulation de polynômes en R

# Vérifie si un polynôme est nul (égal à zéro)
is_poly0 <- function(p) {
  all(p == 0)
}

# Retourne le degré du polynôme
degre <- function(p) {
  length(p) - 1
}

# Convertit un polynôme en chaîne de caractères lisible
poly2str <- function(p) {
  if (length(p) > 0) {
    res <- paste0(p[[1]][1],"*","x^",p[[1]][2])
    for (i in 2:length(p)) {
      terme <- paste0(p[[i]][1],"*","x^",p[[i]][2])
      res <- paste(res,"+",terme)
    }
    return(res)
  }
  else return("")
}

# Multiplie un polynôme par un scalaire
mult_ext <- function(p, s) {
  lapply(p, function(terme) c(terme[1] * s, terme[2]))
}

# Crée une représentation interne d'un polynôme à partir d'une liste de coefficients
make_poly <- function(p) {
  pol <- list()
  for (i in 1:length(p)) {
    if (p[i] != 0) {
      pol <- append(pol, list(c(p[i],i-1)))
      
    }
  }
  return(pol)
}

# Génère un polynôme aléatoire
RandPoly <- function(n, coefs) {
  make_poly(sample(coefs, n, replace = TRUE))
}

# Trie les termes d'un polynôme par degré décroissant
SortPoly <- function(p) {
  if (length(p) == 0) return(list())
  
  degres <- sapply(p, `[`, 2)
  p[order(degres, decreasing = TRUE)]
}

# Convertit un polynôme en forme creuse (sparse)
TransformCreuse <- function(p) {
  if (length(p) == 0) return(numeric(0))
  
  p <- SortPoly(p)
  result <- numeric(p[[1]][2] + 1)
  
  for (terme in p) {
    result[terme[2] + 1] <- terme[1]
  }
  result
}

# Addition de polynômes
add <- function(p, q) {
  result <- numeric(max(length(p), length(q)))
  result[1:length(p)] <- result[1:length(p)] + p
  result[1:length(q)] <- result[1:length(q)] + q
  make_poly(result)
}

# Soustraction de polynômes
sub <- function(p, q) {
  add(p, -q)
}

# Évalue un polynôme pour une valeur x donnée
PolyValC <- function(p, x) {
  sum(sapply(p, function(terme) terme[1] * x^terme[2]))
}

# Calcule la primitive d'un polynôme
Primitive <- function(p) {
  p <- SortPoly(p)
  lapply(p, function(terme) c(terme[1] / (terme[2] + 1), terme[2] + 1))
}

# Calcule la dérivée d'un polynôme
Deriv <- function(p) {
  p <- SortPoly(p)
  res <- lapply(p, function(terme) {
    if (terme[2] > 0) c(terme[1] * terme[2], terme[2] - 1)
  })
  res[!sapply(res, is.null)]
}

# Multiplication de deux monômes
MultMonom <- function(m1, m2) {
  list(c(m1[1] * m2[1], m1[2] + m2[2]))
}

# Multiplication d'un monôme par un polynôme
MultPoly <- function(m, p) {
  lapply(p, function(terme) MultMonom(m, terme)[[1]])
}

# Addition de polynômes en forme creuse
addC <- function(p1, p2) {
  add(TransformCreuse(p1), TransformCreuse(p2))
}

# Soustraction de polynômes en forme creuse
subC <- function(p1, p2) {
  sub(TransformCreuse(p1), TransformCreuse(p2))
}

# Multiplication de deux polynômes
mult <- function(p1, p2) {
  if (length(p1) == 0 || length(p2) == 0) return(list())
  
  Reduce(addC, lapply(p1, function(terme) MultPoly(terme, p2)))
}

# Évaluation efficace d'un polynôme utilisant la méthode de Horner
Horner <- function(p, a) {
  if (length(p) == 0) return(0)
  
  p <- SortPoly(p)
  result <- p[[1]][1]
  
  for (i in 2:length(p)) {
    result <- result * a^(p[[i-1]][2] - p[[i]][2]) + p[[i]][1]
  }
  
  if (length(p) > 0) {
    result <- result * a^p[[length(p)]][2]
  }
  
  result
}

# Dessine le polynôme, sa primitive et sa dérivée
dessiner <- function(p, x) {
  y <- sapply(x, function(xi) Horner(p, xi))
  yP <- sapply(x, function(xi) Horner(Primitive(p), xi))
  yD <- sapply(x, function(xi) Horner(Deriv(p), xi))
  
  plot(x, y, type = "l", col = "blue", 
       main = "Polynôme, Primitive et Dérivée",
       xlab = "x", ylab = "y")
  lines(x, yP, col = "green")
  lines(x, yD, col = "red")
  legend("topright", 
         legend = c("Polynôme", "Primitive", "Dérivée"),
         col = c("blue", "green", "red"),
         lty = 1)
}
