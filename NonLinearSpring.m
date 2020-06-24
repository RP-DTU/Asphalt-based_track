function [Spring,deform] = NonLinearSpring(q, k0, ohm, t)

%Solve a system of non linear equations

%Write the equations up
% k * x = q;
% k0 + ohm * x / (t-x) = k;

% forloop for each springhead
for i = 1:size(q,2)
    for j = 1:size(q,1)
% Define a function of the equations equal to 0

% Solve for x
if 0 <= -(-k0*t + sqrt(k0^2*t^2 - 2*k0*q(j,i)*t + 4*ohm*q(j,i)*t + q(j,i)^2) - q(j,i))/(2*(k0 - ohm)) <= t
deform(j,i) = -(-k0*t + sqrt(k0^2*t^2 - 2*k0*q(j,i)*t + 4*ohm*q(j,i)*t + q(j,i)^2) - q(j,i))/(2*(k0 - ohm));   

elseif 0 <= (k0*t + q(j,i) + sqrt(k0^2*t^2 - 2*k0*q(j,i)*t + 4*ohm*q(j,i)*t + q(j,i)^2))/(2*(k0 - ohm)) <= t
deform(j,i) = (k0*t + q(j,i) + sqrt(k0^2*t^2 - 2*k0*q(j,i)*t + 4*ohm*q(j,i)*t + q(j,i)^2))/(2*(k0 - ohm));

else
%Numerical solution of interception
f = @(x) k0 + ohm * x / (t-x) - q(j,i)/x;
df = @(x) q(j,i)/x^2 + ohm/(t - x) + ohm*x/(t - x)^2;
% Create the initial point within the geotextile
x0 = 1/20 * t;
nmax = 15;
x = Newton(f,df,x0,nmax);
deform(j,i) = x(end);
end


% solve for k
Spring(j,i) = q(j,i)/deform(j,i);
    end 
end


% Numerical solution of the interception
% f = @(x) k0 + ohm * x / (t-x) - q(j,i)/x;
% df = @(x) q(j,i)/x^2 + ohm/(t - x) + ohm*x/(t - x)^2;
% % Create the initial point within the geotextile
% x0 = 1/20 * t;
% nmax = 15;
% x = Newton(f,df,x0,nmax);
% deform(j,i) = x(end);