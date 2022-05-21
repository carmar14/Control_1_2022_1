clc
close all
clear

%proceso
m=0.11;
R=0.015;
d=0.03;
g=9.8;
L=1;
J=9.99e-6;

g=-m*g*d/(L*(J/R^2+m))*tf(1,[1 0 0]);
step(g,'k')
g_cl=feedback(g,1);
hold on
[p z]=pzmap(g);

%deseado
Ts=3;
so=5/100;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);
figure

step(g_d,'r')
% hold on
% step(g_dn,'-k')
% legend('Sin compensar','sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)

pol_d=[1 2*e*wn wn^2];
pol_da=conv(pol_d,[1 15]);


%------controlador PID----
K_p=-pol_da(3)/0.2095;
T_i=-0.2095*K_p/pol_da(4);
T_d=-pol_da(2)/(0.2095*K_p);
g_c=tf([K_p*T_i*T_d K_p*T_i K_p],[T_i 0]);

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado PID','Deseado')
title('Controlador pid')
[p z]=pzmap(sis_cl)
%------controlador PID----

%------controlador PD----

a=-m*9.8*d;
b=(L*(J/R^2+m));
c = pol_d(2);
d= pol_d(3);
K_p_=2*d*b/a;
T_d_=3*c*b/(a*K_p);
g_c=tf([K_p_*T_d_ K_p_],1);

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado PD','Deseado')
title('Controlador pd')
[p z]=pzmap(sis_cl)
%------controlador PD----

%-----------controlador algebraico----
q1=-pol_da(3)/0.2095;
q0=-pol_da(4)/0.2095;
p1=1;
p0=pol_da(2);
%--------compensado----
g_c=tf([q1 q0],[p1 p0]);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado algebraico','Deseado')
title('Controlador algebraico')
[p z]=pzmap(sis_cl)
%-----------controlador algebraico----

%-----------controlador adelanto/atraso------
%condicion del angulo
figure
rlocus(g)
s1=-1.3333 + 1.3983i;
n = -.2095;
d = s1^2;
af = angle(n/d)*180/pi;
x=1.3983/tand(7.28);
p1 = 1.3333 +x;
x=1.3983*tand(10);
z1 = 1.3333-x;


% af2=angle((s1+z2)/(s1+p2))*180/pi;
gc1=tf([1 z1],[1 p1]);
x=1.3983/tand(8.2);
p2 = 1.3333 +x;
gc2=tf([1 z1],[1 p2]);

h=gc1*g*gc1*gc2;
figure
rlocus(h);

n=-0.2095*s1^2 - 0.4552*s1 - 0.2474;
d=s1^4 + 24.56*s1^3 + 150.8*s1^2;
af = angle(n/d)*180/pi;
div=abs(n/d);
K=1/div;

p1=pol_da(2);
K=-pol_da(3)/0.2095;
z1=-pol_da(4)/(0.2095*K);
gc1=tf([1 z1],[1 p1]);
figure
rlocus(gc1*g);

%--------compensado----
% g_c=K*gc*g;
sis_ol=K*gc1*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado adelanto/atraso','Deseado')
title('Controlador adelanto/atraso')
[p z]=pzmap(sis_cl)
%-----------controlador adelanto/atraso----


%--------discretizar pid-------
%u(k)-u(k-1)=K_p (e(k)-e(k-1)+T_D  (e(k)-2e(k-1)+e(k-2))/T+T/T_i  e(k))