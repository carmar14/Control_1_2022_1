%
clear all
clc

k= -1.130;
wn = 4.97;
zita = 0.2;

num = [k*wn^2];
den = [1,2*zita*wn,wn^2];
H=tf(num,den)

figure(1)
step(4.5*H)
hold on

Polo_A=tf(90,[1,90]);
H_Pa=H*Polo_A;

Cero_A=tf([1,60],60);
H_f=H_Pa*Cero_A

step(4.5*H_f)
legend("H(s)", "H(s) con polo y cero adicional")
hold off

figure(2)
pzmap(H_f)