clc
close all
clear

%------proceso------
g=tf(25,[1 1 -2]);

%-----deseado-------
hd=tf(1,[2 1]) % sistema que se estabiliza a los 8 segundos
%-----controlador pid----
Kp=4.48;
Td=0.1741;
Ti=2.24;
gc=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);

sis_ol=g*gc;
sis_cl=feedback(sis_ol,1);
step(sis_cl,'k')

%-----controlador algebraico sin error----
q2=151.8;
q1=526.64;
q0=200;
p2=1;
p1=39;
p0=583;
g_ca=tf([q2 q1 q0],[p2 p1 p0 0]);
sis_ol=g*g_ca;
sis_cl_=feedback(sis_ol,1);
hold
step(sis_cl_,'r')
step(hd,'b')
legend('PID','Algebraico','deseado')

%-------discretización------
Ts=0.1;  %Tm=0.5
Tm=Ts/10;
gcd=c2d(gc,Tm,'tustin');
gcda=c2d(g_ca,Tm);
gd=c2d(g,Tm,'zoh');

siscld=feedback(gcda*gd,1);
figure
step(siscld,'b')
hold on
siscld_=feedback(gcd*gd,1);
step(siscld_,'r')
legend('Algebraico','PID')

figure
subplot(1,2,1)
step(sis_cl_,'r')
hold on
step(siscld,'b')
legend('Algebraico Continuo','Alg. Discreto')

subplot(1,2,2)
step(sis_cl,'r')
hold on
step(siscld_,'b')
legend('PID Continuo','PID Discreto')
t=0:Tm:20;
%accion de control u(k)
 uk = 0;
%accion de control pasada u(k-1)
 uk1 = 0;
%accion de control pasada u(k-2)
 uk2 = 0;
%accion de control pasada u(k-3)
 uk3 = 0;
%erro actual e(k)
 ek = 0;
%error pasado e(k-1)
 ek1 = 0;
%error pasado e(k-2)
 ek2 = 0;
%error pasado e(k-3)
 ek3 = 0;

%salida de la planta y(k)
 yk = 0;
 yk1= 0;
 yk2= 0;
 
 %-----parametros del controlador-------
 a = 1.268;
 b =-2.492;
 c = 1.225;
 d = -2.629;
 e = 2.306;
 f = -0.6771;
 
 rk =1;
for i=1:length(t)
  yk = 0.001246*uk1 + 0.001242*uk2+1.99*yk1-0.99*yk2; %zoh Tm=0.1
  y_k(i) = yk;
  ek = rk - yk;
  %---------calcular acción de control---
  
  uk= a*ek1+b*ek2+c*ek3-d*uk1-e*uk2-f*uk3;
%   uk=round(uk,10);  
  %---------actualizo valores-----------
  uk3=uk2;
  uk2=uk1;
  uk1 = uk;
  ek3 = ek2;
  ek2 = ek1;
  ek1 = ek;
  yk2=yk1;
  yk1=yk;
end

hold on
plot(t,y_k,'k')
ylim([0,max(y_k)])