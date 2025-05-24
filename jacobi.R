jacobi <- function(A, b, x0 = NULL, tol = 1e-6, max_iter = 100) {
  n <- nrow(A)
  if (is.null(x0)) x0 <- rep(0, n)
  x_new <- x0
  cat("Iteración 0:", x_new, "\n")
  for (k in 1:max_iter) {
    x_old <- x_new
    for (i in 1:n) {
      s <- sum(A[i, -i] * x_old[-i])
      x_new[i] <- (b[i] - s) / A[i, i]
    }
    cat("Iteración", k, ":", round(x_new, 6), "\n")
    if (sqrt(sum((x_new - x_old)^2)) < tol) break
  }
  return(x_new)
}
