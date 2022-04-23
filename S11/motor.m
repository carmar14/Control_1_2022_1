clc
close all
clear 

num=430.3;
den=[1 64.09 524.4];
sensor=(1.5/1000)*(1/(2*pi/60));
h=tf(num,den);
step(h)
ylabel('V');


h=tf(num,den)/sensor;
figure
step(h)
ylabel('rad/seg');

h_pos=h*tf(1,[1 0])
figure
step(h_pos)
ylabel('rad');

figure
margin(h_pos)

h_pos_re=feedback(h_pos,1);
figure
step(h_pos_re)

sensor_pos=39*(2*pi/360); %1/(39*(2*pi/360));
h_pos_sen=h_pos*sensor_pos;
figure
step(h_pos_sen)
ylabel('V');

figure
margin(h_pos_sen)

h_pos_re=feedback(h_pos_sen,1);
figure
step(h_pos_re)


