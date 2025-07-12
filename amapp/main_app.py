import tkinter as tk
from tkinter import ttk, messagebox
from utils import leer_matriz
from metodos.gauss import gauss_eliminacion_con_pasos
from metodos.lu import lu_con_pasos
from metodos.jacobi import jacobi_con_pasos
from metodos.gauss_seidel import gauss_seidel_con_pasos

class App:
    def __init__(self, root):
        self.root = root
        self.root.title("Análisis Numérico Modular")

        tk.Label(root, text="Número de ecuaciones:").grid(row=0, column=0)
        self.n_entry = tk.Entry(root, width=5)
        self.n_entry.grid(row=0, column=1)

        tk.Button(root, text="Crear matriz", command=self.crear_matriz).grid(row=0, column=2)

        self.metodo_var = tk.StringVar()
        self.metodo_combo = ttk.Combobox(root, textvariable=self.metodo_var, state="readonly")
        self.metodo_combo["values"] = [
            "Eliminación gaussiana", "Descomposición LU",
            "Jacobi", "Gauss-Seidel"
        ]
        self.metodo_combo.current(0)
        self.metodo_combo.grid(row=1, column=0, columnspan=2, pady=10)

        tk.Button(root, text="Resolver", command=self.resolver).grid(row=1, column=2)

        self.text_resultado = tk.Text(root, height=20, width=80)
        self.text_resultado.grid(row=100, column=0, columnspan=3)

    def crear_matriz(self):
        for widget in getattr(self, "entries", []):
            widget.destroy()
        self.entries = []

        try:
            self.n = int(self.n_entry.get())
        except:
            messagebox.showerror("Error", "n debe ser entero")
            return

        self.matriz_celdas = []
        for i in range(self.n):
            fila = []
            for j in range(self.n + 1):
                e = tk.Entry(self.root, width=8)
                e.grid(row=2 + i, column=j, padx=2, pady=2)
                fila.append(e)
                self.entries.append(e)
            self.matriz_celdas.append(fila)

    def resolver(self):
        try:
            A, b = leer_matriz(self.matriz_celdas)
            metodo = self.metodo_var.get()
            if "gaussiana" in metodo:
                pasos = gauss_eliminacion_con_pasos(A, b)
            elif "LU" in metodo:
                pasos = lu_con_pasos(A, b)
            elif "Jacobi" in metodo:
                pasos = jacobi_con_pasos(A, b)
            elif "Seidel" in metodo:
                pasos = gauss_seidel_con_pasos(A, b)
            else:
                pasos = ["Método no reconocido."]
            self.text_resultado.delete("1.0", tk.END)
            self.text_resultado.insert(tk.END, "\n".join(pasos))
        except Exception as e:
            messagebox.showerror("Error", str(e))

if __name__ == "__main__":
    root = tk.Tk()
    app = App(root)
    root.mainloop()