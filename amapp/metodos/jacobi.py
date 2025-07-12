def jacobi_con_pasos(A, b, tol=1e-10, max_iter=100):
    n = len(A)
    x = [0]*n
    pasos = []
    for it in range(max_iter):
        x_new = [0]*n
        for i in range(n):
            s = sum(A[i][j]*x[j] for j in range(n) if j != i)
            x_new[i] = (b[i] - s) / A[i][i]
        pasos.append(f"Iteración {it+1}: {x_new}")
        if max(abs(x_new[i]-x[i]) for i in range(n)) < tol:
            break
        x = x_new
    pasos.append(f"Solución final: x = {x}")
    return pasos