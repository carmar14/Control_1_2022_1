clc
clear
close all

Kp= 7;
Ti=1;
Td=1;
k=1;
tao=1;
h=tf(k,[tao 1]);
hn=h*h*h;
%rlocus(hn)

