clc
close all
clear

%proceso
a=1.151;
b=0.1774;
c=0.739;
d=0.921;
g=tf([a b],[1 c d 0]);
step(g,'k')
g_cl=feedback(g,1);
hold on
[p z]=pzmap(g);

%deseado
Ts=10;
so=10/100;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);
g_dn=tf(wn^2*[1/0.1541 1],[1 2*e*wn wn^2]);
figure

step(g_d,'r')
% hold on
% step(g_dn,'-k')
legend('Sin compensar','sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)

%-----------controlador algebraico----
pol_d=[1 2*e*wn wn^2];
pol_a=conv(pol_d,[1 4]);
pol_a=conv(pol_a,[1 5]);
pol_a=conv(pol_a,[1 6]);

A=[1 zeros(1,5);
   c 1 zeros(1,4);
   d c 1 a 0 0;
   0 d c b a 0;
   0 0 d 0 b a;
   zeros(1,5) b];
B=pol_a';
x = inv(A)*B;
p2=x(1);
p1=x(2);
p0=x(3);
q2=x(4);
q1=x(5);
q0=x(6);
%--------compensado----
g_c=tf([q2 q1 q0],[p2 p1 p0]);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(0.2*sis_cl,'k')
hold on
step(0.2*g_d,'r')
legend('Compensado algebraico','Deseado')
title('Controlador algebraico')
[p z]=pzmap(sis_cl)
%-----------controlador algebraico----

%-----------controlador algebraico cancelando N(s)----
pol_d=[1 2*e*wn wn^2];
pol_a=conv(pol_d,[1 10]);
pol_a=conv(pol_a,[1 10]);
pol_a=conv(pol_a,[1 10]);

A=[1 zeros(1,5);
   c 1 zeros(1,4);
   d c 1 0 0 0;
   0 d c 1 0 0;
   0 0 d 0 1 0;
   zeros(1,5) 1];
B=pol_a';
x = inv(A)*B;
p2_=x(1);
p1_=x(2);
p0_=x(3);
q2_=x(4);
q1_=x(5);
q0_=x(6);
%--------compensado----
g_c=tf([q2_ q1_ q0_],conv([p2_ p1_ p0_],[a b]));
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(0.2*sis_cl,'k')
hold on
step(0.2*g_d,'r')
legend('Compensado algebraico','Deseado')
title('Controlador algebraico cancelando los ceros del lazo abierto')
[p z]=pzmap(sis_cl)
%-----------controlador algebraico cancelando N(s)----

%-------PID-------
Kp=2;
Ti=Kp/4;
Td=3/Kp;
% Td=2*Td;
g_c=tf(Kp*[Ti*Td Ti 1],[Ti 0]);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(0.2*sis_cl,'k')
hold on
step(0.2*g_d,'r')
legend('Compensado pid','Deseado')
title('Controlador PID')
[p z]=pzmap(sis_cl)
%-------PID-------


%----------discretización del controlador algebraico---
Tm=Ts/50;
Tm=Tm/4;
g_c=tf([q2_ q1_ q0_],conv([p2_ p1_ p0_],[a b]));
gc_d=c2d(g_c,Tm,'tustin');
%----------discretización del controlador algebraico---

