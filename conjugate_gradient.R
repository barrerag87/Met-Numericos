# Conjugate Gradient (CG) method implementation in R

conjugate_gradient <- function(A, b, x0 = NULL, tol = 1e-6, max_iter = 100) {
  n <- nrow(A)
  if (is.null(x0)) x <- rep(0, n) else x <- x0
  r <- b - A %*% x
  p <- r
  rs_old <- sum(r * r)
  cat("Iteración 0:", round(x, 6), "\n")
  for (k in 1:max_iter) {
    Ap <- A %*% p
    alpha <- rs_old / sum(p * Ap)
    x <- x + alpha * p
    r <- r - alpha * Ap
    rs_new <- sum(r * r)
    cat("Iteración", k, ":", round(x, 6), "\n")
    if (sqrt(rs_new) < tol) break
    p <- r + (rs_new / rs_old) * p
    rs_old <- rs_new
  }
  return(x)
}

# -----------------
# Ejemplos de uso
# -----------------

# Sistema de prueba 1 (simétrico definido positivo)
A1 <- matrix(c(4, 1, 2,
               1, 3, 0,
               2, 0, 5), nrow = 3, byrow = TRUE)
b1 <- c(4, 5, 6)
sol1 <- conjugate_gradient(A1, b1)
cat("Solución sistema 1:", sol1, "\n")
cat("Solución exacta:", round(solve(A1, b1), 6), "\n\n")

# Sistema de prueba 2
A2 <- diag(3)
b2 <- c(1, 2, 3)
sol2 <- conjugate_gradient(A2, b2)
cat("Solución sistema 2:", sol2, "\n")
cat("Solución exacta:", b2, "\n")
