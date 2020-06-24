clc; clear; close all;
%Function: k0 + omega * x / (t-x)
%Test results
t = 7;
xx = [0.224,0.439,0.355,0.636,0.584,0.718,0.643,0.859,0.812,0.978,0.918,1.170,1.093,1.284,1.312,1.683,1.655,2.036,1.967,2.271]';
yy = [0.00668,0.00783,0.00990,0.01173,0.01281,0.01388,0.01546,0.01742,0.01842,0.02040,0.02175,0.02563,0.02740,0.03111,0.03048,0.03565,0.03625,0.03929,0.04066,0.04400]'*1000;

%Calculate the coefficents and stating the A matrix
A = [ones(length(xx),1), xx./(t-xx)];
c = (A'*A) \ (A'*yy);

%Define the function
f = @(x) c(1) + c(2)*(x/(t-x));
 
% Create the line
xline = linspace(0,3,500);
yline = c(1) + c(2).*(xline./(t-xline));

%Plot the line with the points
plot(xx,yy,'+k',xline,yline,'-b','markersize',8,'linewidth',2)
grid on
xlabel('x [mm]');
ylabel('k [kPa/mm]');
title('Datafitting of test results for the compression of the geotextile', 'FontName', 'Times')
legend({'Test results','k_0 + k_0 c x / (t-x)'},'location','northwest')
xlim([0,2.5])
ylim([0,60])
set(gca,'fontsize',14)





