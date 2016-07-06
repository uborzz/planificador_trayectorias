
clc, clear all, close all

   %--------------------  ConFIG  -------------------------------%

    im = imread('Figuras/fig1mod.jpg'); % fichero mapa
    distseg = 12/2 + 8; %radio robot (algo menor xq 12 es el lado) + seguridad.
    
    %-----------------------------------------------------------
    
im = im(:,:,1); %Me quedo una sola componente

Pinicio = [286, 178];
Pfinal = [31, 95];

imf = im <= 240;  %imágen B/W
figure, imshow(imf)

se = strel('square', distseg);
imfd= imdilate(imf,se); %/2 radio
%imdilate(imf,composition)



    % Tomaremos como un punto pues se han añadido distancias de seguridad a
    % los objetos del mapa.
    
    [B,L,N,A] = bwboundaries(imfd); 
   
figure
imshow(imfd); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];

B{2}
for k=1:length(B),
  boundary = B{k};
  cidx = mod(k,length(colors))+1;
  plot(boundary(:,2), boundary(:,1),...
       colors(cidx),'LineWidth',2);
end

cov = convhull(B{1})