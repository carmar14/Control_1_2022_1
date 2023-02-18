clc
clear
close all

%-------parametros del sistema---
R1=10e3;
R2=1e3;
R3=2.2e3;
L=1e-3;
C=10e-6;

%h1=tf([R1*L*C R1*C*(R2+R3) R1],[C*L*(R2+R1) R2*R3*C+L+R1*C*(R2+R3) R3+R1]);
h1=tf([R2*L*C R2*R3*C+L R3],[L*C*(R1+R2) R2*R3*C+L+C*R1*(R2+R3) R3+R1]);
%h2=tf([C*L*(R2+R1) R2*R3*C+L R3],[R1*L*C R1*C*(R2+R3) R1]);
h2=tf(R3,[L R3]);
H=h1*h2;
step(H) %revisarlo
figure
pzmap(H) %revisarlo

[p z]=pzmap(H)