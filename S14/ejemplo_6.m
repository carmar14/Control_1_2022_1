clc
close all
clear

%---------proceso--------
g=tf(25,[1 1 -2]);

step(g,'b')

%----------ecuacion deseada----
den = conv([1 8],[1 80]);
den = conv(den,[1 90]);

%--------controlador-----
A=[0 0 1 0;
   0 0 1 1;
   25 0 -2 1;
   0 25 0 -2];
B=[1 178 8560 57600]';
x=inv(A)*B;

q1 = x(1);
q0 = x(2);
p1 = x(3);
p0 = x(4);

gc = tf([q1 q0],[p1 p0]);
sis_ol = gc*g;
sis_cl = feedback(sis_ol,1);
figure
step(2*sis_cl,'k')


%----------sin error en estado estacionario

den = conv([1 8],[1 80]);
den = conv(den,[1 80]);
den = conv(den,[1 90]);
den = conv(den,[1 90]);

%--------controlador-----
A=[0 0 0 1 0 0;
   0 0 0 1 1 0;
   0 0 0 -2 1 1;
   25 0 0 0 -2 1;
   0 25 0 0 0 -2;
   0 0 25 0 0 0];
B=[1 348 46020 2794400 71424000 414720000]';
x=inv(A)*B;

q21 = x(1);
q11 = x(2);
q01 = x(3);
p21 = x(4);
p11 = x(5);
p01 = x(6);

gc = tf([q21 q11 q01],[p21 p11 p01 0]);
sis_ol = gc*g;
sis_cl = feedback(sis_ol,1);
figure
step(2*sis_cl,'k')




