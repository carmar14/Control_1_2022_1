clc
clear
close all

%---------sistema en lazo abierto---
g=tf(4,[1 2]);
rlocus(g)
%---------sistema en lazo abierto---

%----------polos deseados-----------
s1=-20+20*sqrt(3)*i;
s2=-20-20*sqrt(3)*i;
den=conv([1 -s1],[1 -s2]);
hd=tf(den(3),den);
figure
step(hd)
legend('Sistema deseado')


%---------sistema en lazo abierto con G_c(s)=(s+z)/(s+p)---
%----------Encontrando angulo faltante------
ang = rad2deg(angle(4/(s1*(s1+2))));
angf= 180-ang;
phi=60; %90
theta=phi-angf;
%---------encontrando el cero y el polo---
if phi<=90
    x1=imag(s1)/tand(phi);
    x2=imag(s1)/tand(theta);
    z=x1+abs(real(s1));  %funciona si se ubica el cero por debajo o al lado izquierdo del polo deseado
    p=x2+abs(real(s1));
else
    x1=imag(s1)/tand(180-phi);
    x2=imag(s1)/tand(theta);
    z=abs(real(s1))-x1;
    p=x2+abs(real(s1));
    
end


% z=x1+abs(real(s1));
% p=x2+abs(real(s1));

gc=tf([1 z],[1 p])*tf(1,[1 0]);

ol=gc*g;
figure
rlocus(ol)
%---------sistema en lazo abierto con G_c(s)---


%---------encontrando la ganancia----
num=4*(s1+z);
den=s1*(s1+2)*(s1+p);
%num=4*(s1/3.26+1);
%den=s1*(s1+2)*(s1/6.13+1);
div=abs(num/den);
%K=5.061;
K=1/div;
%---------encontrando la ganancia----

%-------controlador completo----
gc=K*gc;
%-------controlador completo----
sc=gc*g; % sistema completo en lazo abierto
cl=feedback(sc,1) % sistema compensado en lazo cerrado
sis=feedback(g,1); % sistema sin compensador en lazo cerrado
figure
step(cl,'k')
hold on
step(sis,'b')
step(hd,'.r')
title('Respuesta al escalon')
legend('Sistema compensado', 'Sistema no compensado', 'Sistema deseado')

figure
subplot(1,2,1)
pzmap(sis,'b')
title('Sistema no compensado')
subplot(1,2,2)
pzmap(cl,'k')
title('Sistema compensado')
%----------compensador usando operacionales-------
%comparador
R1=10e3;
R2=R1;
R3=R1;
R4=R1;
%------red de adelanto-atraso-----
C1=10e-6;
C2=C1;
R1c=1/(z*C1);
R2c=1/(p*C2);
R3c=10e3;
R4c=K*R3c;

K_c=R4c*C1/(R3c*C2);
z=1/(R1c*C1);
p=1/(R2c*C2);

%----integrador----
Ri=10e3;
Ci=100e-6;

R=10e3;

Gc=tf(K_c*[1 z],[1 p])*tf(1, [Ri*Ci 0]);
s_con=feedback(Gc*g,1)
figure
step(s_con,'k')
hold on
step(sis,'b')

title('Respuesta al escalon-Controlador implementado con operacionales')
legend('Sistema compensado', 'Sistema no compensado')