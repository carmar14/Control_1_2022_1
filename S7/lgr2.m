clc
clear
close all

%----ol----
h=tf(1,[1 2]);
k=1000;
hcl=feedback(h*k,1);

pzmap(hcl)

figure
rlocus(h)
