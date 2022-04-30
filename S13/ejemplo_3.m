clc
clear
close all

% %----------control PD----------
g=tf(4,[1 -6 0])

%deseado
Ts=8;
so=40/100;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);

%g_d=tf(3,[1 1 3]);
%legend('Sin compensar','Deseado')
[P Z]=pzmap(g_d)

Kp=3.189/4;
Td=7/(4*Kp); %7/3;
g_c=tf([Kp*Td Kp],1);

g_ol=g_c*g;
g_cl=feedback(g_ol,1);
[p z]=pzmap(g_cl)
figure
step(g_cl,'b');
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control PD $G(s)=\frac{4}{s(s-6)}$','interpreter','latex')


%----------control PID----------
pol_a=conv([1 1 3.189],[1 50]);
Kp=53.189/4;
Ti=4*Kp/159.45;
Td=57/(4*Kp);
g_c=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);

g_ol=g_c*g;
g_cl=feedback(g_ol,1);
[p z]=pzmap(g_cl)
figure
step(g_cl,'b');
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control PID $G(s)=\frac{4}{s(s-6)}$','interpreter','latex')

% %----------control PID----------

% %----------control algebraico----------
g=tf(4,[1 -6 0])
%g_d=tf(3,[1 1 3]);
%hold on
figure
step(g_d,'r')
%legend('Sin compensar','Deseado')
[P Z]=pzmap(g_d)

den_a=conv([1 1 3],[1 5])

A=[1 0 -6 0;
   0 4 0 0;
   0 0 1 0;
   -6 0 0 4];
B=[6 15 1 8]';
x=inv(A)*B;
p0=x(1);
q0=x(2);
p1=x(3);
q1=x(4);
g_c=tf([q1 q0],[p1 p0]);

g_ol=g_c*g;
g_cl=feedback(g_ol,1);
[p z]=pzmap(g_cl)
figure
step(g_cl,'b');
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control algebraico $G(s)=\frac{4}{s(s-6)}$','interpreter','latex')
%----------control algebraico----------