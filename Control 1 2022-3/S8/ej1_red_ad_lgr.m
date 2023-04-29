clc
clear
close all

%-------sistema en lazo abierto---
h=tf(4,[1 2 0]);
pzmap(h);
figure
step(h)
figure
rlocus(h)
%------sistema en lazo cerrado sin controlador---
hcl=feedback(h,1);  %con K=1
figure
step(hcl,'r')
figure
pzmap(hcl)

%-------------deseado-------

Ts=2;
so=0.163;

e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
hd=tf(wn^2,[1 2*e*wn wn^2]);
figure
step(hcl,'r')
hold on
step(hd,'b')
legend('lazo cerrado','deseado')
pd=roots([1 2*e*wn wn^2]); %polos deseados

%------verificamos condicion del ang, calcular ang faltante---
s1=pd(1);
ang=rad2deg(angle(4/(s1*(s1+2))));

phi1=90 %angulo que aporta el cero
z=-real(s1);
theta3=phi1-30;
x= imag(s1)/tand(theta3)
p = x + z;

g_c= (s1+z)/(s1+p);
ang=rad2deg(angle(4*g_c/(s1*(s1+2))));

%---condicion de magnitud para encontrar K---
k=1/abs(4*g_c/(s1*(s1+2)));

%--------verificamos------
gc=k*tf([1 z],[1 p]); %controlador /compensador de adelanto
figure
rlocus(gc*h/k);
sis_ol= gc*h;
sis_cl = feedback (sis_ol,1);
figure
pzmap(sis_cl);
figure
step(sis_cl,'.b');
hold on
step(hd,'--r')
step(hcl,'--k')
legend('Sistema compensado','Sistema deseado','Sistema sin compensar')
