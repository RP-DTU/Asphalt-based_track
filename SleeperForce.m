function Force=SleeperForce(Load,W,RailModulus)
    %real formula
    %s*Load*beta*exp(-beta*x)/2 ) *cos(beta*x)+sin(beta*x)
    % as the worst case sleeper is for x=0 the formula is reduced
    
    s=W/1000; %m
    E=200e9; %Pa
    I=3.04e-5; %m^4
    
    beta = ( RailModulus / (4*E*I)) ^ (1/4);  %1/m
    Force = (s*Load*beta/2 ); %N
    
end