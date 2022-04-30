clc
close all
clear

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


pol_a=conv(pol_d,[1 300]);

%------controlador----
K_p=(3050-2550)/50;
T_i=50*K_p/15000;
T_d=(310-101)/(50*K_p);
g_c=tf([K_p*T_i*T_d K_p*T_i K_p], [T_i]);  %recordar que el integrador viene de la planta

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado','Deseado')
title('Control PID $G(s)=\frac{50}{s(s+50)(s+51)}$','interpreter','latex')

[p z]=pzmap(sis_cl)

%---------proceso----
den=conv([1 50],[1 51]);
den=conv([1 0],den);
g=tf(50,den);
gcl=feedback(g,1);
[po zo]=pzmap(g)

%--------------deseado---------
s1=-5+5*i;
s2=-5-5*i;
pol_d=conv([1 -s1],[1 -s2])
g_d = tf(pol_d(3),pol_d)

%---------calculando angulos de los polos del sistema en s1d para saber angulo faltn-------
t1=90+atand(5/5);
t2=atand(5/45);
t3=atand(5/46);
tt=t1+t2+t3;   %angulo actual para cumplir la condición del angulo
%---------red de atraso---------
%x1=5*tand(30); %base del triangulo del cero
af=180-tt;
phi=t2;
t4=af+phi;
x2=5/tand(t4); %base del triangulo del polo

%z1=5-x1;
z2=50;
p2=x2+5;

%---------econtrando K----
num=50*(s1+z2);
den=s1*(s1+50)*(s1+51)*(s1+p2);
div=abs(num/den);
K=1/div;

%-------encontrando relación para Kv----
%     s*K*50(s+z1)(s+z2)
%Kv= -------------------
%     s(s+p1)(s+p2)(s+50)(s+1)     evaluado en s=0
Kv=50;
%Kv=K*z1*z2/p1*p2----
%K*z1/p1=4.5556
%z2/p2=50/4.5556
factor= 51*p2/(K);
z1=0.02;
p1= z1/factor;

num=s1+z1;
den=s1+p1;
div2=abs(num/den); % verificamos que la magnitud sea
%aprox 1.

%verificamos angulo pequeño
t4=atand((5-p1)/5);
phi2=atand((5-z1)/5);
phi2-t4

%controlador completo
gc=K*tf([1 z1],[1 p1])*tf([1 z2],[1 p2])

%------sistema con controlador
s_con=gc*g;
% figure
% rlocus(s_con)
s_con_cl=feedback(s_con,1)
figure
step(gcl,'k');
hold on
step(g_d, 'r');
step(s_con_cl,'b');
legend('Original en lazo cerrado','Deseado','Sistema con compensador')
figure
step(g_d, 'r');
hold on
step(s_con_cl,'b');
title('Red adelanto/atrado $G(s)=\frac{50}{s(s+50)(s+51)}$','interpreter','latex')
[p z] = pzmap(s_con_cl)