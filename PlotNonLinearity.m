clc;clear;
k0 = 10;
t = 7;
%q = 0.259; 
f = @(x,c) k0 + k0 * c*x ./ (t-x) ;
c=[1,10,20,30];
x = linspace(0,7,800);

for i=1:length(c)
F(i,:)=f(x,c(i));
end 



%ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
figure()
hold on
plot(x,F(1,:),'-',x,F(2,:),'--',x,F(3,:),'-.',x,F(4,:),':', 'LineWidth', 2.5)
%plot(x,F(5,:),'-',x,F(6,:),'--',x,F(7,:),'-.','LineWidth', 1)
grid minor
grid on
ylim([0,1500])
ylabel('k [kPa/mm]')
xlabel('x [mm]')
title({['Spring-bed coefficient'] ['as a function of the compression'] ['k_0 = ' num2str(k0) ' kPa/mm']})
lgd = legend(string(c),'Location','northwest');
title(lgd, 'c');
hold off

%%%%%%%%%%%%%%%555
%plot different k0
clear;clc;

c=15;
t = 7;
%q = 0.259; 
f1 = @(x,k0) k0 + k0 * c*x ./ (t-x) ;
k0 = [0.01,0.1,1,5.9,10,15];
x = linspace(0,7,800);

for i=1:4
F1(i,:)=f1(x,k0(i));
end 
figure()
plot(x,F1(1,:),'-',x,F1(2,:),'--',x,F1(3,:),'-.',x,F1(4,:),':', 'LineWidth', 2)
grid minor
grid on
ylim([0,1500])
ylabel('k [kPa/mm]')
xlabel('x [mm]')
title({['Spring-bed coefficient as a function of the compression'] ['c = ' num2str(c)]})
lgd = legend(string(k0),'Location','northwest');
title(lgd, 'k_0');
