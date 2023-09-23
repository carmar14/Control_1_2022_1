clc
clear
close all

%------primer punto-----
%-----1a-------
Ts=35;
so=(1.2-0.8)/0.8;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
k=0.8/2;
g_d=tf(k*wn^2,[1 2*e*wn wn^2]);
step(2*g_d,'.')
[p z]=pzmap(g_d);
taop = -1/real(10*p(1));
taoc = -1/real(20*p(1));
g_3=g_d*tf([taoc 1],1)*tf([taoc 1],1)*tf(1,[taop 1]);
hold on
step(2*g_3,'r');

%-----1b-----
h=g_3;
gcl=feedback(h,1);
figure
step(gcl)

%-------3------
g=tf(1,[1 0 5 2 1]);
figure
rlocus(g)
