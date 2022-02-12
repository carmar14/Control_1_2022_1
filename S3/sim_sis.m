clc
clear
close all

%--------spo----------
k=-1;
tao=[0.5 1 2];
% h=[];
figure
for i=1:3
    h(i)=tf(k,[tao(i) 1]);
    
    pzmap(h(i))
    hold on
end

legend('sis1','sis2','sis3')
figure
for i=1:3
    step(-2.3*h(i))
    hold on
end
legend('sis1','sis2','sis3')


%-----------sso---------

%----------sobreamortiguado--------
k=1;
wn=2;
e=[2 3 4];
figure
for i=1:3
    h(i)=tf(k*wn^2,[1 2*e(i)*wn wn^2]);
    
    pzmap(h(i))
    hold on
end

legend('sis1','sis2','sis3')
figure
for i=1:3
    step(h(i))
    hold on
end
legend('sis1','sis2','sis3')
%----------sobreamortiguado--------

%-----------critico--------------
wn=[2 3 4];
e=1;
figure
for i=1:3
    h(i)=tf(k*wn(i)^2,[1 2*e*wn(i) wn(i)^2]);
    
    pzmap(h(i))
    hold on
end

legend('sis1','sis2','sis3')
figure
for i=1:3
    step(h(i))
    hold on
end
legend('sis1','sis2','sis3')
%-----------critico--------------


%----------subamortiguado--------

wn=2;
e=[0.1 0.5 0.9];
figure
for i=1:3
    h(i)=tf(k*wn^2,[1 2*e(i)*wn wn^2]);
    
    pzmap(h(i))
    hold on
end

legend('sis1','sis2','sis3')
figure
for i=1:3
    step(h(i))
    hold on
end
legend('sis1','sis2','sis3')
%----------subamortiguado--------


%----------subamortiguado--------

wn=[1 2 3];
e=0;
figure
for i=1:3
    h(i)=tf(k*wn(i)^2,[1 2*e*wn(i) wn(i)^2]);
    
    pzmap(h(i))
    hold on
end

legend('sis1','sis2','sis3')
figure
for i=1:3
    step(h(i))
    hold on
end
legend('sis1','sis2','sis3')
%----------marginal--------


