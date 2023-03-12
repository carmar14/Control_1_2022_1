clc
close all
clear

h=tf(1,[1 2 1 0]);
K=-0.0001;
hcl=feedback(K*h,1);

step(hcl)
figure
pzmap(hcl)