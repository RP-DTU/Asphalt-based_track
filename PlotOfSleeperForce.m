clc; clear;

W=300; %mm
Load = 200e3; % [N]
k =  50e6 ; % [Pa]
s=[0.3, 0.6]; %m
E=200e9; %Pa
I=3.04e-5; %m^4
x=linspace(-5,5,500); %m

beta = (k / (4*E*I)) ^ (1/4);  %1/m
Force(1,:)= ( s(1)*Load*beta*exp(-beta.*abs(x)) ) .*(cos(beta.*abs(x))+sin(beta.*abs(x))) /2; %N
Force(2,:)= ( s(2)*Load*beta*exp(-beta.*abs(x)) ) .*(cos(beta.*abs(x))+sin(beta.*abs(x))) /2; %N
% Force= @(x,beta(j))  (s*Load*beta(j)*exp(-beta(j)*abs(x)) ) *(cos(beta(j)*abs(x))+sin(beta(j)*abs(x)); %N
   figure(1) 
   plot(x,100*Force(1,:) ./ Load,'-',x,100*Force(2,:) ./ Load,'--', 'LineWidth',2);
   grid on
   grid minor
   title({'Force distribution on sleepers'});
   xlabel('x [mm]');
   xticks(-5:1:5);
   ylabel('%');
   lgd = legend(string(s),'location','northeast');
   title(lgd,'s [m]')
   ylim([-5,40])
   set(gca,'fontsize',14)
   
   