clc
clear
close all


%----------parametros del sistema-----------

R=10e3;
L=1000e-3;
C=6e-6;

h=tf([R*L 0],[R*L*C L R]);

step(-2*h)
figure
pzmap(h)
