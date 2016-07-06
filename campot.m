clc, clear all, close all

% Calculo de campos de potenciales de un mapa.
% Todo a manota.
% Tamaño mapa 241 X 342
Circ = [90+35, 159+28, 32]; %Circulo: x, y, radio.

meta = [255,196]; % x y 

 im = imread('Figuras/Fig31.jpg'); % fichero mapa
 im = im(:,:,1);
 imf1 = not(im <= 240); %imágen B/W
 
  im = imread('Figuras/Fig32.jpg'); % fichero mapa
 im = im(:,:,1);
 imf2 = not(im <= 240); %imágen B/W
 
  im = imread('Figuras/Fig33.jpg'); % fichero mapa
 im = im(:,:,1);
 imf3 = not(im <= 240); %imágen B/W
 %figure, imshow(imf)

%puntos segmentos que definen los rectángulos.
rec(1).pi = [40, 44]';
rec(1).pf = [190, 44]';
rec(2).pi = [40, 44]';
rec(2).pf = [40, 79]';
rec(3).pi = [40, 79]';
rec(3).pf = [190,79]';
rec(4).pi = [190,44]';
rec(4).pf = [190,79]';

rec2(1).pi = [220,104]';
rec2(1).pf = [220,177]';
rec2(2).pi = [220,104]';
rec2(2).pf = [306,104]';
rec2(3).pi = [220,177]';
rec2(3).pf = [306,177]';
rec2(4).pi = [306,177]';
rec2(4).pf = [306,104]';

% Matrix a evaluar
M = zeros(241,342); 

% matriz distancias obstaculos y meta
for i=1:342
    for j=1:241
  %      if (imf(j,i)>0)
        for k=1:4
            if (imf1(j,i)>0)
            dist1(k) = distancia(i,j,rec(k));
            end
            if (imf2(j,i)>0)
            dist2(k) = distancia(i,j,rec2(k));
            end
        end
            [val1, pos1] = min(dist1);DIS(j,i,1) = val1;
            [val2, pos2] = min(dist2);DIS(j,i,2) = val2;
            if imf3(j,i) > 0
            dist3 = abs(sqrt((i-Circ(1))^2+(j-Circ(2))^2)-33);
            end
            DIS(j,i,3) = dist3;
            distM = sqrt((i-meta(1))^2+(j-meta(2))^2);
            DIS(j,i,4) = distM;
        
    end
end


