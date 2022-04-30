clc
close all
clear

%proceso
den=conv([1 50],[1 51]);
den=conv(den,[1 0]);
g=tf(50,den);
% step(g,'k')
g_cl=feedback(g,1);


%deseado
s1=-5-5*i;
s2=-5+5*i;
pol_d=conv([1 -s1],[1 -s2]);
g_d=tf(pol_d(3),pol_d);

step(g_cl,'b')
hold on
step(g_d,'r')
legend('sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)


pol_a=conv(pol_d,[1 91]);

%------controlador----
K_p=4550/50;
T_d=(960-2550)/(50*K_p);
g_c=tf([K_p*T_d K_p],1);

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control PD $G(s)=\frac{50}{s(s+50)(s+51)}$','interpreter','latex')

[p z]=pzmap(sis_cl)
