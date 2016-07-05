%%%function voronoi(im, ptos, acelerador)

clc, clear all, close all

   %--------------------  ConFIG  -------------------------------%

    im = imread('Figuras/fig1mod.jpg'); % fichero mapa

    robot = 8;   % tamaño robot en pixeles
    border = 2;  % borde para añadir imagen
    modo = 1;    % modo =1 basico, Diagrama de voronoi, 
                 % =0 Muestra zonas donde no cabe el robot.

   %-------------------------------------------------------------%
             
im = im(:,:,1); %Me quedo una sola componente
im = [zeros(length(im),border)'; im; zeros(length(im),border)']; %añadimos bordes top/bot
im = [zeros(length(im(:,1)),border), im, zeros(length(im(:,1)),border)]; %laterales

figure
imshow(im)

imf = not(im <= 240); %imágen B/W
figure, imshow(imf)

v = corner(imf, 'QualityLevel', 0.3) % Array con los vértices detectados 
hold on, plot(v(:,1), v(:,2), '*r') 


% Combinaciones vértices
k = 1;
for i=1:length(v) % recorremos v en 2 posiciones diferentes
    for j=1:length(v)
        if i<j % para no repetir pares
            comb(k,:) = [v(i,:), v(j,:)]; % par de vértices
            k = k+1;
        end
    end
end
comb %muestra combinaciones


[B,L,N,A] = bwboundaries(imf);  %extraemos información de contornos   
B = cell2mat(B); % cambio a matriz para tratar los datos
figure, plot(B(:,2), B(:,1), '*')     

% Selección de bordes de un mismo polígono
l = 1;
for k = 1:length(comb(:,1))
   
    %Se tratará de buscar soluciones cercanas a 0 sustituyendo valores
    %relevantes de los resultados de bounds en la ecuación de la recta que
    %define cada par de vértices. Con ello aseguraremos que un par de
    %vértices es un borde de un obstáculo.
    
    [comb(k,:), k]
    
    y2 = comb(k,4); y1 = comb(k,2);  
    x2 = comb(k,3); x1 = comb(k,1);

    p = abs(y2/x2);
    
    BM = B(B(:,2)>=(min(x1,x2)-2), :);
    BM = BM(BM(:,2)<=(max(x1,x2)+2), :); 
    BM = BM(BM(:,1)>=(min(y1,y2)-2), :);
    BM = BM(BM(:,1)<=(max(y1,y2)+2), :);
        
    %equación de la recta
    % (y1-y2) * X + (x2-x1) * Y + (x1*y2-x2*y1) = 0
    test = (y1-y2)*BM(:,2) + (x2-x1)*BM(:,1) + (x1*y2-x2*y1); 
       
    coincidencias = sum(abs(test)<=1)

    i = x1;
    j = y1;

    if coincidencias >= 5
        s(l).pi = [x1,y1]'
        s(l).pf = [x2,y2]'
        l = l+1;
    end
       
%     end
    %for 
    %pause
end


[Nx,Ny]=size(im);
Ns = length(s)

Color = zeros(size(im));
size(Color)


for i=1:Nx
    for j=1:Ny
        if (imf(i,j)>0)
            for k=1:Ns
                dis(k) = distancia(j,i,s(k));
            end
            
           [val1, pos1] = min(dis); dis(pos1) = []; %borde más cercano, lo saco del array
           [val2, pos2] = min(dis); dis(pos2) = []; %segundo borde más cercano
           [val3, pos3] = min(dis); %tercer borde, por si lineas 1 y 2 intersectaran y vieramos el mismo punto
           
           switch modo
               case 1,
                    Color(i,j) = pos1;
               otherwise,
                   if ((val2+val1)>(robot*1.5)) %cabe el robot? 
                       Color(i,j) = pos1; 
                   elseif (sum(s(pos1).pi ~= s(pos2).pf) && ...
                           sum(s(pos1).pi ~= s(pos2).pi) && ...
                           sum(s(pos1).pf ~= s(pos2).pf) && ...
                           sum(s(pos1).pf ~= s(pos2).pi))
                       %caemos aquí en caso de que las 2 paredes más cercanas sean
                       %diferntes, ademas de que el robot no cabe.
                   else 
                       %las paredes compartían el punto a estudiar (vértice)
                       if ((val3+val1)>(robot*1.5))
                            Color(i,j) = pos1; %valoramos una tercera pared más cercana
                       else
                       end
                   end
            end
           
        end
    end
end 


%figure, pcolor(flip(Color)); 
figure, contourf(flip(Color));
hold on 

