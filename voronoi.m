%function voronoi(im, ptos, acelerador)
clc, clear all, close all

im = imread('Figuras/fig1mod2.jpg');

border = 2;

 im = im(:,:,1); %Me quedo una sola componente
% im = [zeros(length(im),border)'; im; zeros(length(im),border)']; %bordes top/bot
% im = [zeros(length(im(:,1)),border), im, zeros(length(im(:,1)),border)]; %laterales


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

% Combinaciones vértices
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
% Selección de bordes de un mismo polígono
for k = 1:length(comb(:,1))
   
    [comb(k,:), k]
    
    y2 = comb(k,4)
    y1 = comb(k,2)
    
    x2 = comb(k,3)
    x1 = comb(k,1)
    
    dy = y2-y1
    dx = x2-x1
    p = dy/dx

    if dx < 0
        swap = x1; x1 = x2; x2 = swap;
        swap = y1; y1 = y2; y2 = swap;
        dx = abs(dx);
    end
    
    count1 = 0;
    count2 = 0;
        
    i = x1;
    j = y1;
    stop = 0;
    
    if abs(p)<0.01
        R = 'Horiz'
    elseif abs(p)>90
        R = 'Vertz'
    else
       %if p<1
           while stop == 0
               %[imf(floor(i),floor(j-2))]
               try
                   nx = round(i)
                   ny = round(j)
                   count1 = imf(round(j),round(i-2)) + count1;
                   count2 = imf(round(j),round(i+2)) + count2;
               catch me
                   stop = 1;
               end
               
               if dy < 0  %&& dx < 0
                   i = i+p;
                   j = j+(1/p);
                  % j = j-(1/p);
               elseif dy > 0 %&& dx > 0
                   i = i+p;
                   j = j+(1/p);
          %     elseif dy < 0 && dx > 0
%                   i = i+p;
%                   j = j-(1/p);
               elseif dy > 0 && dx < 0
                  i = i-1/p;
                  j = j+p;
               end
                   
                   
               if round(i) == x2 || round(j) == y2 
                   stop = 1;
               end
                   
           end
           
           [count1,count2]
           if count1 == 0 || count2 == 0
               s(l,:) = comb(k,:);
               l = l+1;
           else
               R = 'Nope'
           end 
       %else 
           
      % end
       
    end
    %for 
    pause
end

%s


% 
% for i=1:length(v1)
%     v1aux = v1; v1aux(i) = [];
%     for j=1:length(v1aux)
%   
%         s(i).pi = v1(i);
%         s(i).pf = v1aux(j);
%         
%     end
% end
%         
      


% [Nx,Ny]=size(im);
% Ns = length(s)
% 
% Color = zeros(size(im));
% size(Color)
% 
% hola = 0;
% for i=1:Nx
%     for j=1:Ny
%         if (imf(i,j)>0)
%             for k=1:Ns
%                 d(k) = distancia(i,j,s(k));
%             end
%            [val1, pos1] = min(d);
%            Color(i,j) = pos1;
%         end
%     end
% end 
% 
% 
% %c = contourf(Color);
% figure, contourf(flip(Color))
