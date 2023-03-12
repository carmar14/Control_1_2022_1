%P3
clear all
clc

k= -1.130;
wn = 4.97;
zita = 0.2;

num = [k*wn^2];
den = [1,2*zita*wn,wn^2];
H=tf(num,den)

opt = stepDataOptions('InputOffset',0,'StepAmplitude',4.5);
figure(1)
step(H,opt)
hold on

PoloA=tf(70,[1,70]);
H_Pa=H*PoloA;

CeroA=tf([1,90],90);
H_final=H_Pa*CeroA;

step(H_final,opt)
legend("Sistema inicial", "Sistema con polos y ceros adicionales")
hold off

figure(2)
pzmap(H_final)