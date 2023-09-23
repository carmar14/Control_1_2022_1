clc
clear
close all

z= 2;
p=4;
K=4;

%comparador
R1=10e3;
R2=R1;
R3=R1;
R4=R1;

%controlador con primera configuración
C1=10e-6;
C2=C1;
R1c=1/(z*C1);%30.67e3;
R2c=1/(p*C2);%16.31e3;
R3c=10e3;
R4c=K*R3c;%50.061e3;


%controlador con segunda configuración
C=10e-6;
R1c2=12.5e3;
R2c2=0.5/C;
R3c2=10e3;
R4c2=10e3;
