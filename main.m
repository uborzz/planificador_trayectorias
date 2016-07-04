clear all, close all, clc

im = imread('Figuras/fig1mod.jpg');

border = 2;

im = im(:,:,1); %Me quedo una sola componente
im = [zeros(length(im),border)'; im; zeros(length(im),border)']; %bordes top/bot
im = [zeros(length(im(:,1)),border), im, zeros(length(im(:,1)),border)]; %laterales


figure
imshow(im)
%hold on

imf = not( im <= 240);
v = corner(imf, 'QualityLevel', 0.25);


hold on
%imshow(imf)
plot(v(:,1), v(:,2), '*r');


voronoi(imf, 3, 1)