clc
clear
close all

% -----funcion en lazo abierto------
h=tf([1 1],[1 3 0 0]);
step(h);
figure
rlocus(h)

%----------lazo cerrado----
k=2.36;
hcl=feedback(h*k,1);
figure
pzmap(hcl);
figure
step(hcl)

%%-verificar que el polo s1=-0.281+0.935i
s1=-1.5+3i
ang= rad2deg(angle((s1+1)/(s1^2*(s1+3))));
%-----encontrar k por la condicion de magnitud-- 
k=1/abs((s1+1)/(s1^2*(s1+3))); %K=2.36



