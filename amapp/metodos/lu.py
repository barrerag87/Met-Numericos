def lu_con_pasos(A, b):
    n = len(A)
    L = [[0]*n for _ in range(n)]
    U = [[0]*n for _ in range(n)]
    pasos = []

    for i in range(n):
        for k in range(i, n):
            U[i][k] = A[i][k] - sum(L[i][j]*U[j][k] for j in range(i))
        for k in range(i, n):
            L[k][i] = 1 if i == k else (A[k][i] - sum(L[k][j]*U[j][i] for j in range(i))) / U[i][i]
        pasos.append(f"Paso {i+1}:\nL = {L}\nU = {U}")

    y = [0]*n
    for i in range(n):
        y[i] = b[i] - sum(L[i][j]*y[j] for j in range(i))

    x = [0]*n
    for i in range(n-1, -1, -1):
        x[i] = (y[i] - sum(U[i][j]*x[j] for j in range(i+1, n))) / U[i][i]

    pasos.append(f"Solución final: x = {x}")
    return pasos