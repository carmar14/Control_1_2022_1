clc
clear
close all


%----------definir parametros-----
k=-1;
tao=1;
A= -10;

h=tf(k,[tao 1]);
step(h,'k')
hold on
step(A*h,'r')
legend('Respuesta a u(t)=1', 'Respuesta a u(t)=A')

figure
pzmap(h,'b')

tao = 1:5:15;
figure
for i=1:length(tao)
    h2=tf(k,[tao(i) 1]);
    step(h2)
    hold on
end

legend('\tau = 1 seg','\tau = 6 seg','\tau = 11 seg')



