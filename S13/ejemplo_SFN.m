clc
close all
clear

%-------proceso----
g=tf([1 -1],[1 2]);
step(g,'k')
g_cl=feedback(g,1);
hold on

%deseado
Ts=0.5;
tao=Ts/4;

g_d=tf(1,[tao 1]);
hold on
step(g_cl,'b')
step(g_d,'r')
legend('Sin compensar','sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)

pol_d=[1 1/tao];
pol_a=conv(pol_d,[1 80]);

%------controlador----
K_p=-640;
T_i=(88-K_p)/(1-88*K_p);
g_c=tf([K_p*T_i K_p],[T_i 0]);

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado','Deseado')
[p z]=pzmap(sis_cl)
