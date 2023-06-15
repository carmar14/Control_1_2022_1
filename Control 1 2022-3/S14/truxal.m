clc
clear
close all

%-----deseado----
hd=tf(123.2,[1 9.99 123.2])
step(hd,'.r')

Gp=tf(100,[1 10 0])
H=tf(1,[1 2])
N= tf(123.2,1);
D=tf([1 9.99 123.2],1);
gc=N/(Gp*(D-N*H));


% num=conv([1 2 0],[1 10])
% den=100*[1 101 321.2 123.2];
% gc=tf(123.2*num,den);

sis_ol=gc*Gp;
sis_cl=feedback(sis_ol,H);%tf(1,[1 2]));
hold on
step(sis_cl,'--b')
legend('Deseado','Compensado')
figure
pzmap(sis_cl)

