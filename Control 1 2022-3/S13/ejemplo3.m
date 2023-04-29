clc
close all
clear

%proceso
g=tf(4,[1 -6 0]);
step(g,'k')
g_cl=feedback(g,1);
figure
step(g_cl,'r')
%deseado
Ts=8;
so=0.4;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);
figure
step(g_d,'r')
legend('Deseado')
[P Z]=pzmap(g_d)

pol_d=[1 2*e*wn wn^2];
%--------controlador----
Kp=3.189/4;
Td=7/(4*Kp);
gc=tf([Kp*Td Kp],1);


%------------
sis_ol=gc*g;
sis_cl= feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado','Deseado')

figure
pzmap(sis_cl)

%-----------lugar geometrico---
figure
rlocus(g)
figure
rlocus(sis_ol)


%--------pid------------
pol_a = conv(pol_d,[1 50]);%[1 100]);
b= pol_a(2);
c= pol_a(3);
d= pol_a(4);
Kp=c/4;%25.79;%10.1888/4;%53.189/4;
Td=(b+6)/(4*Kp);%1.0369;%(8+6)/(4*Kp);%57/(4*Kp);
Ti=4*Kp/d;%0.013006;%4*Kp/(22.3217); %4*Kp/(159.45);
g_c=tf([Kp*Td*Ti Kp*Ti Kp],[Ti 0]);


%------------
sis_ol=g_c*g;
sis_cl= feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado PID','Deseado')

figure
pzmap(sis_cl)

%-----------lugar geometrico---
figure
rlocus(g)
figure
rlocus(sis_ol)

