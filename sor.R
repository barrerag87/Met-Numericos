# Successive Over-Relaxation (SOR) method implementation in R

sor <- function(A, b, omega = 1.0, x0 = NULL, tol = 1e-6, max_iter = 100) {
  n <- nrow(A)
  if (is.null(x0)) x0 <- rep(0, n)
  x <- x0
  cat("Iteración 0:", x, "\n")
  for (k in 1:max_iter) {
    x_old <- x
    for (i in 1:n) {
      s1 <- if (i > 1) sum(A[i, 1:(i-1)] * x[1:(i-1)]) else 0
      s2 <- if (i < n) sum(A[i, (i+1):n] * x_old[(i+1):n]) else 0
      x[i] <- (1 - omega) * x_old[i] + (omega / A[i, i]) * (b[i] - s1 - s2)
    }
    cat("Iteración", k, ":", round(x, 6), "\n")
    if (sqrt(sum((x - x_old)^2)) < tol) break
  }
  return(x)
}

# -----------------
# Ejemplos de uso
# -----------------

# Sistema de prueba 1
A1 <- matrix(c(4, 1, 2,
               3, 5, 1,
               1, 1, 3), nrow = 3, byrow = TRUE)
b1 <- c(4, 7, 3)
sol1 <- sor(A1, b1, omega = 1.1)
cat("Solución sistema 1:", sol1, "\n")
cat("Solución exacta:", round(solve(A1, b1), 6), "\n\n")

# Sistema de prueba 2
A2 <- diag(3)
b2 <- c(1, 2, 3)
sol2 <- sor(A2, b2, omega = 1.2)
cat("Solución sistema 2:", sol2, "\n")
cat("Solución exacta:", b2, "\n")
