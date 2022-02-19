clear
close all
clc

%--------------primer orden-------------
k=3;
tao=4;
spo=tf(k,[tao 1]);
subplot(3,1,1)
step(spo)

% pa = tf(1,[0.5*tao 1]);
pa = tf(1,[1/0.1 1]);
subplot(3,1,3)
step(spo*pa)


za = tf([-1/100 1],1);
subplot(3,1,2)
step(spo*za)



figure
pzmap(spo*za)

%--------------segundo orden-------------
e=0.3;
wn=2;
k=1;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 
figure
subplot(3,1,1)
step(sso)

pa = tf(1,[5000 1]);
subplot(3,1,3)
step(sso*pa)

za = tf([11],1);  % probar con 10%, 5% 2%
subplot(3,1,2)
step(sso*za)



figure
pzmap(sso*za)


figure
step(sso)
hold on
step(sso*pa)
