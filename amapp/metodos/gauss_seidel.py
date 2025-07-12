def gauss_seidel_con_pasos(A, b, tol=1e-10, max_iter=100):
    n = len(A)
    x = [0]*n
    pasos = []
    for it in range(max_iter):
        x_new = x[:]
        for i in range(n):
            s1 = sum(A[i][j]*x_new[j] for j in range(i))
            s2 = sum(A[i][j]*x[j] for j in range(i+1, n))
            x_new[i] = (b[i] - s1 - s2) / A[i][i]
        pasos.append(f"Iteración {it+1}: {x_new}")
        if max(abs(x_new[i]-x[i]) for i in range(n)) < tol:
            break
        x = x_new
    pasos.append(f"Solución final: x = {x}")
    return pasos