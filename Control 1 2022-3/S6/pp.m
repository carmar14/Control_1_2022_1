clc
clear
close all

%---------p 1 G52--------
e=0.2;
wn=5;
k=2.6/-2.3;
h=tf(k*wn^2,[1 2*e*wn wn^2]);
figure
step(-2.3*h,'k')
grid on

%-------aproximacion-----
Ts=4;
so=(3.97-2.6)/2.6;

e_=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn_=4/(Ts*e);
k_=2.6/-2.3;
h_=tf(k_*wn_^2,[1 2*e_*wn_ wn_^2]); %dinamica dominante

tao = 1/(e_*wn_);
taop = 0.05*tao;  %para polos reales despreciables
taoc = 0.06*tao; %para ceros despreciables
h2=tf(1,[taop 1])*tf([taoc 1],1); %polo adicional y cero adicional
hold on
hn=h_*h2; %sistema de tercer orden y un cero
step(-2.3*hn,'.r')
legend('Original','Aprox')
title('Respuesta a r(t)=-2.3 u(t)')

figure
step(4.5*hn,'b')
title('Respuesta a r(t)=4.5 u(t)')

figure
pzmap(hn,'r')

%---------p 1 G52--------

%----------p3 G52---------
h=tf(3,[1 0 2 3 4]);

figure
rlocus(h)
k=2;
hcl = feedback(h*k,1);
figure
step(hcl)
title('Punto 3 G52')
%-----------Punto a-b------
%el sistema no tiene valor de K posible para 
%garantizar estabilidad, siempre da inestable
%-----------Punto a-b------

%-----------Punto c------
%el sistema es inestable en lazo cerrado
%independiente del valor de K
%por lo tanto el ess siempre es infinito
%-----------Punto c------

%----------p3 G52---------

