clc
clear
close all

h1=tf(1,[1 1]);  %real menor que 0
h2=tf(1,[1 0]);  % integrado puro
h3=tf(1,[1 1 1]); % complejos conjugados real <0
h4=tf(1,[1 0 1]); %imaginario puros

impulse(h1)
figure
impulse(h2)
figure
impulse(h3)
figure
impulse(h4)

h5=tf(1,[1 -1]);  %real > 0
h6=tf(1,[1 -1 1]); % complejos conjugados real >0
figure
impulse(h5)
figure
impulse(h6)

figure
pzmap(h1)
hold on
pzmap(h2)
pzmap(h3)
pzmap(h4)
pzmap(h5)
pzmap(h6)
legend('Re<0','Re=0','C Re<0','Im','Re>0','C Re>0')


h1=c2d(h1,0.1);  %real menor que 0
h2=c2d(h2,0.1);  % integrado puro
h3=c2d(h3,0.1); % complejos conjugados real <0
h4=c2d(h4,0.1); %imaginario puros

figure
impulse(h1)
figure
impulse(h2)
figure
impulse(h3)
figure
impulse(h4)

h5=c2d(h5,0.1);  %real > 0
h6=c2d(h6,0.1); % complejos conjugados real >0
h7=tf(1,[1 0.5],1);
h8=tf(1,[1 1.5],1);
figure
impulse(h5)
figure
impulse(h6)
figure
impulse(h7)
figure
impulse(h8)

figure
pzmap(h1)
hold on
pzmap(h2)
pzmap(h3)
pzmap(h4)
pzmap(h5)
pzmap(h6)
pzmap(h7)
pzmap(h8)
legend('Re<0','Re=0','C Re<0','Im','Re>0','C Re>0','ReD<0','ReD<0 inestable')




% figure
% step(h1)
% figure
% step(h2)
% figure
% step(h3)
% figure
% step(h4)

