def leer_matriz(matriz_celdas):
    n = len(matriz_celdas)
    A = []
    b = []
    for fila in matriz_celdas:
        row = [float(e.get()) for e in fila]
        A.append(row[:-1])
        b.append(row[-1])
    return A, b