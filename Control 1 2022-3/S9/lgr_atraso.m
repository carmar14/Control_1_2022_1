clc
clear 
close all

%------sistema en lazo abierto---
den = conv ([1 0],[1 1]);
den = conv(den,[1 2]);

g = tf(1.06,den);
step(g)

%------cerrar-----
gcl=feedback(g,1);
figure
step(gcl)
figure
pzmap(gcl)

[P z] = pzmap(gcl);

wn=abs(P(2));
e=-real(P(2))/wn;

so=exp(-e*pi/sqrt(1-e^2));
ts=4/(e*wn);

%-----lgr---
figure
rlocus(g)

%------constante error actual
Kva=0.53;
K=5;
factor=K/Kva;
p=0.005;
z=p*10; %p*factor;
%----polo deseado---
s1= P(2);
%-----verificamos cond. angulo----
den_=s1*(s1+1)*(s1+2);
ang_ = rad2deg(angle(1.06/den_)); %angulo sin controlador
ang = rad2deg(angle(1.06*(s1+z)/(den_*(s1+p)))); %angulo con controlador

%---nuevo lgr---
gc=tf([1 z],[1 p]);
figure
rlocus(g)
hold on
rlocus(gc*g,'--')

%---encontrar k de gc----
k=1.05;%0.81;
gc = k *gc;

%-----simulacion en lazo cerrado
sis_cl=feedback(gc*g,1);
figure
step(sis_cl,'k')
hold on
step(gcl,'--r')
legend('Compensado','Sin compensar')
figure
pzmap(sis_cl)


