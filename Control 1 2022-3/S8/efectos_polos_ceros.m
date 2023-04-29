clc
clear 
close all

h=tf(1,[1 2])*tf(1,[1 1])*tf(1,[1 0.5])
pzmap(h)
figure
rlocus(h)

k=11.5;
hcl=feedback(k*h,1)
figure
step(hcl)
figure
pzmap(hcl)

hz=tf([1 .75],[1 2])*tf(1,[1 1])*tf(1,[1 0.5])
figure
rlocus(hz)