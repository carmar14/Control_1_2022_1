clear; clc ;close all
%% Step
num = [-15.14 -908.4];
den = [60 87 804];
funcion_transferencia = tf(num,den);
step(-2.3*funcion_transferencia, 4.5*funcion_transferencia) 
%% Mapa de polos y ceros
pzmap(funcion_transferencia)


