# Gauss-Seidel method implementation in R

gauss_seidel <- function(A, b, x0 = NULL, tol = 1e-6, max_iter = 100) {
  n <- nrow(A)
  if (is.null(x0)) x0 <- rep(0, n)
  x <- x0
  cat("Iteración 0:", x, "\n")
  for (k in 1:max_iter) {
    x_old <- x
    for (i in 1:n) {
      s1 <- if (i > 1) sum(A[i, 1:(i-1)] * x[1:(i-1)]) else 0
      s2 <- if (i < n) sum(A[i, (i+1):n] * x_old[(i+1):n]) else 0
      x[i] <- (b[i] - s1 - s2) / A[i, i]
    }
    cat("Iteración", k, ":", round(x, 6), "\n")
    if (sqrt(sum((x - x_old)^2)) < tol) break
  }
  return(x)
}

# -------------------
# Pruebas del método
# -------------------

# Sistema 1
A1 <- matrix(c(4, 1, 2,
               3, 5, 1,
               1, 1, 3), nrow = 3, byrow = TRUE)
b1 <- c(4, 7, 3)
sol1 <- gauss_seidel(A1, b1)
cat("Solución sistema 1:", sol1, "\n")
cat("Solución exacta:", round(solve(A1, b1), 6), "\n\n")

# Sistema 2
A2 <- diag(3)
b2 <- c(1, 2, 3)
sol2 <- gauss_seidel(A2, b2)
cat("Solución sistema 2:", sol2, "\n")
cat("Solución exacta:", b2, "\n\n")

# Sistema 3 - matriz no diagonal dominante (puede no converger)
A3 <- matrix(c(2, 3,
               5, 7), nrow = 2, byrow = TRUE)
b3 <- c(8, 19)
sol3 <- gauss_seidel(A3, b3, max_iter = 10)
cat("Solución sistema 3 tras 10 iteraciones:", sol3, "\n")
cat("Solución exacta:", round(solve(A3, b3), 6), "\n")
