
function deflection = deflectionPavement2(stepsize, q, nu, E,X,Y, SizeX,SizeY)
% Calculate the deflection at each point using following folumars
%Def = q*a*(1-nu^2)/E * ln(1+sqrt(2))/pi
%Def = q*a^2*(1-nu^2)/E * 1/r

def = zeros(SizeY,SizeX);

% For each
for i = 1:SizeX
    for j = 1:SizeY 
                        def(j,i) = def(j,i) + (4*q(j,i)/1000*stepsize*(1-nu^2)/E )* (log(1+sqrt(2))/pi); %m
% For eachother
        for k = 1:SizeX
            for h = 1:SizeY
                if i ~= k || j ~= h
                        r = sqrt( (X(h,k) - X(j,i))^2 + (Y(h,k) - Y(j,i))^2 ); %m
                        def(j,i) = def(j,i) + q(h,k)/1000*stepsize^2*(1-nu^2)/(E*pi*r); %m
                end
            end
        end
    end
end

deflection = def;

end