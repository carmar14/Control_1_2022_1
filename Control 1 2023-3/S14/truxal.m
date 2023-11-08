clc
clear
close all

%-----deseado----
hd=tf(123.2,[1 9.99 123.2])
step(hd,'.r')

gp=tf(100,[1 10 0]);
h=tf(1,[1 2]);
n=123.2;
d=tf([1 99 123.2],1);
gc=n/(gp*(d-n*h));

sis_ol=gc*gp;
sis_cl=feedback(sis_ol,h);
hold on
step(sis_cl,'--k')

% num=conv([1 2 0],[1 10])
% den=100*[1 101 321.2 123.2];
% gc=tf(123.2*num,den);
% 
% sis_ol=gc*tf(100,[1 10 0]);
% sis_cl=feedback(sis_ol,tf(1,[1 2]));
% hold on
% step(sis_cl,'--b')
% 
% figure
% pzmap(sis_cl)

