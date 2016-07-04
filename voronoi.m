%function voronoi(im, ptos, acelerador)
clc, clear all, close all

im = imread('Figuras/fig1mod.jpg');

border = 2;

 im = im(:,:,1); %Me quedo una sola componente
 im = [zeros(length(im),border)'; im; zeros(length(im),border)']; %bordes top/bot
 im = [zeros(length(im(:,1)),border), im, zeros(length(im(:,1)),border)]; %laterales


figure
imshow(im)
%hold on

imf = not(im <= 240);
figure, imshow(imf)

v = corner(imf, 'QualityLevel', 0.25)
hold on
plot(v(:,1), v(:,2), '*r')
grid on

v1= v;
v2= v;

k=1;

% Combinaciones v�rtices
for i=1:length(v1)
    for j=1:length(v2)
   % while j<=jmax
        if i<j 
            comb(k,:) = [v1(i,:), v2(j,:)];
            k = k+1;
        end
    end
end

comb
l = 1;

       %BW = imread('Figuras/fig1mod.jpg');
       %BW = BW(:,:,1);
       [B,L,N,A] = bwboundaries(imf);
       %imshow(BW); hold on;
            
       a = cell2mat(B);
       
% Selecci�n de bordes de un mismo pol�gono
for k = 1:length(comb(:,1))
   
    [comb(k,:), k]
    
    y2 = comb(k,4);
    y1 = comb(k,2);
    
    x2 = comb(k,3);
    x1 = comb(k,1);
    
    
    %equacion de la recta
    test = (y1-y2)*a(:,2) + (x2-x1)*a(:,1) + (x1*y2-x2*y1); %== 0
    coincidencias = sum(abs(test)<=5)
    dx = x2-x1;
    %p = dy/dx;


    count1 = 0;
    count2 = 0;
        
    i = x1;
    j = y1;
    stop = 0;
    
%     if abs(p)<0.01
%         R = 'Horiz'
%     elseif abs(p)>90
%         R = 'Vertz'
%     else
%        %if p<1

        if coincidencias >= 10
            s(l).pi = [x1,y1]'
            s(l).pf = [x2,y2]'
            l = l+1;
        end
       
%     end
    %for 
    %pause
end


% % % % % % s(1).pi = v(3,:)'
% % % % % % s(1).pf = v(1,:)'
% % % % % % 
% % % % % % s(2).pi = v(2,:)'
% % % % % % s(2).pf = v(3,:)'
% % % % % % 
% % % % % % s(3).pi = v(1,:)'
% % % % % % s(3).pf = v(2,:)'

% % s(4).pi = [3,3]';
% % s(4).pf = [300,3]';
% % 
% % s(5).pi = [3,200]';
% % s(5).pf = [300,200]';
% % 
% % s(6).pi = [3,3]';
% % s(6).pf = [3,200]';
% % 
% % s(7).pi = [300,3]';
% % s(7).pf = [300,200]';

% for i=1:length(v1)
%     v1aux = v1; v1aux(i) = [];
%     for j=1:length(v1aux)
%   
%         s(i).pi = v1(i);
%         s(i).pf = v1aux(j);
%         
%     end
% end
% %         
      


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
           [val1, pos1] = min(dis);
           Color(i,j) = pos1;
        end
    end
end 


%c = contourf(Color);
figure, contourf(flip(Color));
hold on 

