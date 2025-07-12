def gauss_eliminacion_con_pasos(A, b):
    n = len(A)
    a = [A[i] + [b[i]] for i in range(n)]
    pasos = []
    for i in range(n):
        for j in range(i+1, n):
            ratio = a[j][i] / a[i][i]
            for k in range(n+1):
                a[j][k] -= ratio * a[i][k]
        pasos.append(f"Paso {i+1}:\n" + "\n".join(str(row) for row in a))

    x = [0]*n
    for i in range(n-1, -1, -1):
        x[i] = a[i][n]
        for j in range(i+1, n):
            x[i] -= a[i][j]*x[j]
        x[i] /= a[i][i]
    pasos.append(f"Solución: {x}")
    return pasos