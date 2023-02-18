clc
clear
close all

%---armonicos esfericos-- eq(2)------
N=8;
%n=0:N;
Ne=50;
delta = pi/Ne;
theta=0:delta:pi;
phi=0:2*delta:2*pi;
m=0;
rv = -0.5:0.0001:0.5;

% for n=0:N
%     a=(-1)^m*sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m))); %an
%     b=-(-1)^m*sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m))); %bn
%     P=legendre(n,cos(theta));
%     Y=sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m))).*P.*exp(imag(m*phi));
%     if n==0
%         Y00=Y;
%         a00=(-1)^m*sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m)));
%         rsh = a00*Y00;
%     end
%     %Yn0= es la primera fila de Y
% %     Yn0(n+1,:)=Y(1,:);
% %     an0(n+1)=a;
% 
% end

n=0;

P=legendre(n,cos(theta));
Y=sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m))).*P.*exp(imag(m*phi));
Y00=Y;
a00=(-1)^m*sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m)));
         

aux=0;
aux2=0;
for n=1:N
    P=legendre(n,cos(theta));
    Y=sqrt((2*n+1).*factorial(n-m)./(4*pi*factorial(n+m))).*P.*exp(imag(m*phi));
    for m=1:n
       %anm=rv(randi(length(rv)));
       %bnm=rv(randi(length(rv)));
       anm=(-1)^m*sqrt((2*n+1)*factorial(n-m)/(4*pi*factorial(n+m))); %an
       an0=sqrt((2*n+1)*factorial(n)/(4*pi*factorial(n)));
       bnm=-(-1)^m*sqrt((2*n+1)*factorial(n-m)/(4*pi*factorial(n+m))); %bn
    
       aux2=aux2+P(m,:).*(anm*cos(m*phi)+bnm*sin(m*phi)); 
    
    end
%     aux=an0(n)*Yn0(n,:)+aux+aux2;
    aux=an0*Y(1,:)+aux+aux2;
end
 
rsh=aux+P(n,:)*an0;
% rsh=aux+Y00*a00;



[phi,theta] = meshgrid(phi,theta);

rad = rsh.*sin(theta);
x = rad.*cos(phi);  % Ecuaciones en coordenadas esfericas
y = rad.*sin(phi);
z = rsh.*cos(theta);

% Grafica de la superficie
clf
surf(x,y,z);
axis tight
light
lighting phong
view(40,30)
camzoom(1.2)

