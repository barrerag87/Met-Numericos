# qr_manual:
# descomposición QR por Gram-Schmidt modificado
# entrada  : matriz A (m × n) con m ≥ n
# salida   : lista con Q (m × n, columnas ortonormales) y R (n × n, triangular superior)
qr_manual <- function(A, tol = .Machine$double.eps ^ 0.5) {
  m <- nrow(A)
  n <- ncol(A)
  Q <- matrix(0, m, n)          # inicializa Q
  R <- matrix(0, n, n)          # inicializa R
  
  for (j in seq_len(n)) {
    v <- A[, j]                 # copia de la j-ésima columna
    if (j > 1) {
      for (i in seq_len(j - 1)) {
        R[i, j] <- sum(Q[, i] * v)  # proyección sobre q_i
        v <- v - R[i, j] * Q[, i]   # resta el componente proyectado
      }
    }
    R[j, j] <- sqrt(sum(v * v))     # norma euclídea de v
    if (R[j, j] < tol) stop("matriz con rango deficiente")
    Q[, j] <- v / R[j, j]           # normaliza para obtener q_j
  }
  
  list(Q = Q, R = R)
}

# ejemplo de uso
A <- matrix(c(1, 1, 1,
              1, 2, 3,
              1, 3, 6), 
            nrow = 3, byrow = TRUE)

res <- qr_manual(A)
Q <- res$Q
R <- res$R

cat("Q:\n"); print(Q)
cat("R:\n"); print(R)
cat("verificación (Q %*% R):\n"); print(Q %*% R)
