clear
close all
clc

%--------------primer orden-------------
k=1;
tao=4;
spo=tf(k,[tao 1]);
subplot(3,1,1)
step(spo)

za = tf([-0.0001*tao 1],1);
% h=za*spo;
% figure
% pzmap(h)
subplot(3,1,2)
% hold on
step(spo*za)

% figure
% step(spo,'k')
% hold on
% step(spo*za,'--r')
% figure
% pzmap(spo*za)

pa = tf(1,[10*tao 1]);
% h=pa*spo;
% figure
% pzmap(h)
subplot(3,1,3)
step(spo,'k')
hold on
step(spo*pa,'--r')

figure
pzmap(spo*pa)

%--------------segundo orden-------------
e=0.3;
wn=2;
k=-3;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 
figure
%subplot(3,1,1)
step(sso,'k')

wn = 1;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 
hold on
step(sso,'r')

wn = 3;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 

step(sso,'b')
figure
pzmap(sso)
figure
za = tf([-1/5 1],1);  % probar con 10%, 5% 2%
pzmap(sso*za)
%subplot(3,1,2)
figure
step(sso,'k')
hold on
step(sso*za, '.r')

figure
step(sso,'b');
hold on
step(sso*za,'--r')
legend('original', 'con cero')

figure 
pzmap(sso,'b')
hold on
pzmap(sso*za,'r')
legend('original', 'con cero')

pa = tf(1,[1/0.0006 1]);
figure
pzmap(sso*pa)
figure
%subplot(3,1,3)
step(sso)
hold on
step(sso*pa, '.r')

figure
pzmap(sso*za)



e1=0.6;
wn1=2;
h1=tf(wn1^2,[1 2*e1*wn1 wn1^2]);
e2=0.6;
wn2=1;
h2=tf(wn2^2,[1 2*e2*wn2 wn2^2]);
figure
step(h1,'k');
hold on
step(h1*h2,'.r');

figure

pzmap(h1*h2)

e1=0.2;
wn1=2;
h1=tf(wn1^2,[1 2*e1*wn1 wn1^2]);
tao = 1/0.6;
h2=tf(1,[tao 1]);
figure
step(h1,'k');
hold on
step(h1*h2,'.r');

figure

pzmap(h1*h2)




