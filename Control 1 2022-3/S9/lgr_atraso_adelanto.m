clc
clear
close all

%---------sistema en lazo abierto---
g=tf(4,[1 0.5 0]);
%-------sistema en lazo cerrado---
gcl=feedback(g,1);
step(gcl)

figure
rlocus(g)
%---------deseado-----
so=0.163;
Ts=1.6;
Kv=80;

e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
hd=tf(wn^2,[1 2*e*wn wn^2]);
figure
step(gcl,'r')
hold on
step(hd,'b')
legend('lazo cerrado','deseado')
pd=roots([1 2*e*wn wn^2]); %polos deseados

%---------determinar el angulo faltante----
s1= pd(1);
ang = rad2deg(angle(4/(s1*(s1+0.5))));
angf = 180-ang;
phi1= 90;
theta3= phi1-angf;
z1 = -real(s1);
x = imag(s1)/tand(theta3);
p1 = x+z1;

ang = rad2deg(angle(4*(s1+z1)/(s1*(s1+0.5)*(s1+p1))));

gc= tf([1 z1],[1 p1]);
figure
rlocus(gc*g)

%-----determinar k de gc con cond. magnitud----
div = abs(4*(s1+z1)/(s1*(s1+0.5)*(s1+p1)));
k=1/div;

%-----ecnontrar red atraso---

lim = k*4*z1/(0.5*p1); % lim*z2/p2=Kv=80
%z2/p2=80/lim=factor
factor = Kv/lim;
p2=0.0001;
z2= factor*p2;

gc = k*tf([1 z1],[1 p1])*tf([1 z2],[1 p2]);

%-----simular sistema completo
sis_ol= gc*g;
hold on
rlocus(sis_ol,'--');
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'b');
hold on
step(hd,'r')
legend('Sistema controlado','Deseado');

figure
pzmap(sis_cl)
[P Z] = pzmap(sis_cl)
