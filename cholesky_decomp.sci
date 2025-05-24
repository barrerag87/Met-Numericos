function L = cholesky_decomp(A)
    [n, m] = size(A);
    if n <> m then
        error("La matriz debe ser cuadrada");
    end

    L = zeros(n, n);

    for i = 1:n
        for j = 1:i
            suma = 0;
            for k = 1:j-1
                suma = suma + L(i,k) * L(j,k);
            end

            if i == j then
                val = A(i,i) - suma;
                if val <= 0 then
                    error("La matriz no es definida positiva");
                end
                L(i,j) = sqrt(val);
            else
                L(i,j) = (A(i,j) - suma) / L(j,j);
            end
        end
    end
endfunction

A = [25 15 -5; 15 18 0; -5 0 11];
L = cholesky_decomp(A)
