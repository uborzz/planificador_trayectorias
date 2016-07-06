function M = arrayMat(A, tam)

% ---------------------------------------------------------------
% A = Recibe una matriz (Nx2) (2 arrays).
% tam = Recibe tamaño de una matriz.
% Lo convierte en una matriz de 1 y 0 con =1 las cordenadas 
% indicadas en el array. 
% ----------------------------------------------------------------

M = zeros(tam);
for i=1:length(A(:,1))
    M(A(i,1),A(i,2)) = 1;
end
