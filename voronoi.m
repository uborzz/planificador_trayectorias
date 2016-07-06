%%%function voronoi(im, ptos, acelerador)

clc, clear all, close all

   %--------------------  ConFIG  -------------------------------%

    im = imread('Figuras/fig1mod.jpg'); % fichero mapa

    robot = 12;   % tama�o robot en pixeles
    border = 2;  % borde para a�adir imagen
    modo = 1;    % modo =1 basico, Diagrama de voronoi, 
                 % =0 Muestra zonas donde no cabe el robot.
    ajuste1 = 0.2;   % maximo desvio error para punto C recta
    ajuste2 = 0.3;   % porcentaje puntos dentro recta para validar

   %-------------------------------------------------------------%
             
im = im(:,:,1); %Me quedo una sola componente
im = [zeros(length(im),border)'; im; zeros(length(im),border)']; %a�adimos bordes top/bot
im = [zeros(length(im(:,1)),border), im, zeros(length(im(:,1)),border)]; %laterales

figure
imshow(im)

imf = not(im <= 240); %im�gen B/W
figure, imshow(imf)

v = corner(imf, 'QualityLevel', 0.3) % Array con los v�rtices detectados 
hold on, plot(v(:,1), v(:,2), '*r') 


% Combinaciones v�rtices
k = 1;
for i=1:length(v) % recorremos v en 2 posiciones diferentes
    for j=1:length(v)
        if i<j % para no repetir pares
            comb(k,:) = [v(i,:), v(j,:)]; % par de v�rtices
            k = k+1;
        end
    end
end
comb %muestra combinaciones


[B,L,N,A] = bwboundaries(imf);  %extraemos informaci�n de contornos   
B = cell2mat(B); % cambio a matriz para tratar los datos
figure, plot(B(:,2), B(:,1), '*')     

% Selecci�n de bordes de un mismo pol�gono
l = 1;
for k = 1:length(comb(:,1))
   
    %Se tratar� de buscar soluciones cercanas a 0 sustituyendo valores
    %relevantes de los resultados de bounds en la ecuaci�n de la recta que
    %define cada par de v�rtices. Con ello aseguraremos que un par de
    %v�rtices es un borde de un obst�culo.
    
    [comb(k,:), k]
    
    y2 = comb(k,4); y1 = comb(k,2);  
    x2 = comb(k,3); x1 = comb(k,1);

    p = abs(y2/x2);
    
    BM = B(B(:,2)>=(min(x1,x2)-2), :);
    BM = BM(BM(:,2)<=(max(x1,x2)+2), :); 
    BM = BM(BM(:,1)>=(min(y1,y2)-2), :);
    BM = BM(BM(:,1)<=(max(y1,y2)+2), :);
        
    % Valoraci�n del segmento=pared mediante lo cerca que est�n los puntos
    % del boundaries de �l. Conviente quitar puntos muy cercanos a los
    % v�rtices para pendientes muy inclinadas u horizotales, 
    % pero de momento queda as�.
    
    ss.pi = [x1,y1]'; % Estructura para funci�n distancia
    ss.pf = [x2,y2]';

    Ns = length(BM);

    clear distrecta;
    for q=1:Ns  % Valoramos todos los puntos del bound respecto a la recta.
        distrecta(q) = distancia(BM(q,2),BM(q,1),ss);
    end
    
    % Para distancia menor a 0.2p contamos los resultados, adem�s, se
    % requiere una cantidad de resultados seg�n la distancia de esa recta
    coincidencias = sum(abs(distrecta)<=ajuste1) 
    if coincidencias >= (max(abs((x1-x2)),abs((y1-y2)))*ajuste2) 
        s(l) = ss;
        l = l+1;
    end
    %pause
end

%Pintamos el mapa aplicando Voronoi
[Nx,Ny]=size(im); % est�n los nombres al rev�s U-.-
Ns = length(s)

Color = zeros(size(im)); %inicializaci�n

for i=1:Nx
    for j=1:Ny
        if (imf(i,j)>0)
                clear dis;
            for k=1:Ns
                dis(k) = distancia(j,i,s(k)); 
            end
            
           [val1, pos1] = min(dis); dis(pos1) = []; %borde m�s cercano, lo saco del array
           [val2, pos2] = min(dis); dis(pos2) = []; %segundo borde m�s cercano
           [val3, pos3] = min(dis); %tercer borde, por si lineas 1 y 2 intersectaran y vieramos el mismo punto
           
           switch modo
               case 1,
                    Color(i,j) = pos1*2+4; %Algunos colores salen muy parecidos con contourf
               otherwise,
                   if ((val2+val1)>(robot*1.5)) %cabe el robot? 
                       Color(i,j) = pos1+3; 
                   elseif (sum(s(pos1).pi ~= s(pos2).pf) && ...
                           sum(s(pos1).pi ~= s(pos2).pi) && ...
                           sum(s(pos1).pf ~= s(pos2).pf) && ...
                           sum(s(pos1).pf ~= s(pos2).pi))
                       %caemos aqu� en caso de que las 2 paredes m�s cercanas sean
                       %diferntes, ademas de que el robot no cabe.
                   else 
                       %las paredes compart�an el punto a estudiar (v�rtice)
                       if ((val3+val1)>(robot))
                            Color(i,j) = pos1; %valoramos una tercera pared m�s cercana
                       else
                       end
                   end
            end
           
        end
    end
end 


figure, pcolor(flip(Color)); 
figure, contourf(flip(Color));
hold on 

