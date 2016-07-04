function d=distancia(x,y,seg)
%funci�n auxiliar que calcula la distancia de un punto de coordenadas x,y a
%un segmento

%proyecto el punto en la l�nea que define el segmento (producto escalar)
proy=(seg.pf-seg.pi)'*([x,y]'-seg.pi)/norm(seg.pf-seg.pi); %posicion del punto m�s cercano respecto a pf
L=norm(seg.pf-seg.pi);  %longitud del segmento

%hay tres casos:
if (proy)<=0
%A) la distancia proyectada es negativa, entonces el punto m�s cercano a la recta
%est� fuera del segmento y el punto m�s cercano en el segmento es pi
pc=seg.pi;

elseif (proy>L)
%B) en este caso estoy el punto m�s cercano a la recta
%est� fuera del segmento y el punto m�s cercano en el segmento es pf
pc=seg.pf;

else
%C)el punto m�s cercano a la recta est� dentro del segmento (caso por
%defecto) primero saco el punto m�s cercano
pc=seg.pi+proy*(seg.pf-seg.pi)/norm(seg.pf-seg.pi);   
end

%ahora calculo la distancia
d=norm([x,y]'-pc);