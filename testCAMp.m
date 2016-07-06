%%testCAMP

clear MATT, close all
clear B1,
clear B2,
clear B3,
clear recorrido

e = 0.5; n = 0.5; p0 = 100;
%DISfix(DIS<=0.1) = 0.1
DISfix = DIS;
MATT = 0.01*(DISfix(:,:,4)).^2;

%circulo problematico porque no es exactamente igual en dibujo y programa.
d3 = DIS(:,:,3).^-1;
d3(d3>1) = 1;

%surf(flip(DIS(:,:,4).^2./12000+DIS(:,:,1).^-1.*6+DIS(:,:,2).^-1.*6+d3.*6))
%figure, contourf(flip(DIS(:,:,4).^2./12000+DIS(:,:,1).^-1.*4+DIS(:,:,2).^-1.*4+d3.*4))
%A(A>=p0) = 0;




pots = DIS(:,:,4).^2./12000+2.*DIS(:,:,1).^-1+2.*DIS(:,:,2).^-1+d3.*3;
figure, surf(flip(pots))
figure, contourf(flip(pots))

% Vemos recorrido para un punto inicial cualquiera.
pi = [40,30]; %punto inicial cualkiera
meta = [255,196];

stop = 0
pp = pi;
k = 1; recorrido(1,:) = pp;
   
%figure, contour(pots);
   hold on

while stop == 0
    
    [mini, xx] = min(pots([pp(1)-1:pp(1)+1],[pp(2)-1:pp(2)+1]));
    [mini, y] = min(mini);
    x = xx(y)-2; y=y-2;
    pp = [pp(1)+x, pp(2)+y];
    
    k=k+1
    recorrido(k,:) = pp;
    
    
    if (abs(pp(1)-meta(1))<=5 && abs(pp(2)-meta(2))<=5) || k > 4000
        stop = 1
    end
    
end

plot(recorrido(:,2),243-recorrido(:,1), 'r*') 

