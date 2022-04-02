clc
clear 
close all

Kc=20;
den=conv([1 1],[1 2]);
den=conv(den,[1 0]);
g=tf(Kc,den);
gl=feedback(g,1);
margin(g)
grid on
[Gm,Pm,Wcg,Wcp] = margin(g);

%nueva frecuencia de cruce de ganancia
wg=Wcg;%1.41;
% selecionar un w una decada antes de la frecuencia de cruce de ganancia
% esto es el cero
w=wg*0.1;
T2=1/w;
z2=1/T2;
%phim=MF_deseada+5
MF_d=50;
phi=MF_d+5;
B=(sind(phi)+1)/(1-sind(phi));
p2=1/(B*T2);

%encontrar z_1 y p_1
z1=0.5; %0.6
p1=5; %6
num=conv([1 z1],[1 z2]);
den=conv([1 p1],[1 p2]);
gc=tf(num,den);

s_comp=gc*g;
figure
margin(s_comp)
s_comp_clo=feedback(s_comp,1);
figure
step(s_comp_clo)
title('Respuesta en lazo cerrado del proceso con compensador')

figure
pzmap(s_comp_clo)