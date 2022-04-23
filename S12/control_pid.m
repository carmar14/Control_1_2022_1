clc
clear
close all

%proceso
%g=tf(1,[1 3 15])
n=5;
g=tf(1,[1 48 n]) %5
step(g,'k')
g_cl = feedback(g,1);

Ts=1;
so=0.13;

e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);
hold on
step(g_cl,'b')
step(g_d,'r')
legend('Sin compensar','sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)


%-----------control PI----------
Kp=53.94+40*8-n;
Ti=Kp/(53.94*40);
g_c=tf([Kp*Ti Kp],[Ti 0]);

g_ol=g_c*g;
g_cl=feedback(g_ol,1);
[p z]=pzmap(g_cl)
figure
step(g_cl,'b');
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control PI $G(s)=\frac{1}{s^2+48s+5}$','interpreter','latex')
%-----------control PI----------

% 
%----------control PID----------
g=tf(1,[1 3 5])
Kp=53.94+40*8-5;
Ti=Kp/(53.94*40);
Td=(48-3)/Kp;
g_c=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);

g_ol=g_c*g;
g_cl=feedback(g_ol,1);
[p z]=pzmap(g_cl)
figure
step(g_cl,'b');
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control PID $G(s)=\frac{1}{s^2+3s+5}$','interpreter','latex')

%----------control PID----------
% 
% %----------control PD----------
g=tf(4,[1 -6 0])

g_d=tf(3,[1 1 3]);
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
Kp=53/4;
Ti=4*Kp/150;
Td=(51+6)/(4*Kp);
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
g_d=tf(3,[1 1 3]);
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
%----------control algebraico----------
