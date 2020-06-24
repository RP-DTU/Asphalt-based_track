function [deflectionSurrounding,XPavement,YPavement] = SurroundingPavement(stepsize, q, E, nu, X, Y, deflection) 

% Define the original size of the sleeper
SizeX = size(q,2);
SizeY = size(q,1);

% Define the Pavement size
xPavement = (X(1,1):stepsize:3*X(1,end));
yPavement = (Y(1,1):stepsize:6*Y(end,1));
[XPavement,YPavement] = meshgrid(xPavement,yPavement);

% Define the size of the pavement
SizeXPavement = size(XPavement,2);
SizeYPavement = size(YPavement,1);

% Define a matrix of zeros within the pavement
def = zeros(SizeYPavement,SizeXPavement);

% Set the sleeper points under the sleeper as zeros
[Xnew,Ynew] = meshgrid(xPavement,yPavement);
Xnew(SizeY+1:SizeY*2,SizeX+1:2*SizeX) = 0;
Ynew(SizeY+1:SizeY*2,SizeX+1:2*SizeX) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Calculation  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:SizeXPavement
    for j = 1:SizeYPavement 
        if Xnew(j,i) ~= 0 && Ynew(j,i) ~= 0
            for k = 1:SizeX
                for h = 1:SizeY
                            r = sqrt( (XPavement(SizeY+h,SizeX+k) - XPavement(j,i))^2 + (YPavement(SizeY+h,SizeY+k) - YPavement(j,i))^2 ); %m
                            def(j,i) = def(j,i) + q(h,k)*stepsize^2*(1-nu^2)/(E(1)*pi*r); %m
                end
            end
        end
    end
end

% Collect all deformationpoints into one matrix
def(SizeY+1:SizeY*2,SizeX+1:2*SizeX) = deflection;

deflectionSurrounding = def;
