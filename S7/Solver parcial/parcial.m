clc
close all
clc

%------punto 1a-----
k=-2;
tao=-0.1;

h=tf(k,[tao 1]); %----open loop
hcl=feedback(h,1); %---close loop---

step(2*hcl);

%------punto 1b--------
k=4/5;
tao=0.1;
tao1=1/200;
tao2=1/220;
tao3=1/230;
h3=tf(k,[tao 1])*tf([tao3 1],conv([tao1 1],[tao2 1]));
hold on
step(5*h3)
legend('1a','1b')

%----------punto 3--------
%conceptual