%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Initial values    %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Properties for the sleeper
% L = Length of sleeper 
% W = Width of Sleeper  

% stepsize = The size of the squares in the mesh

% Properties for the half-space 
% E = Youngs Modulus
% nu = Poissons ratio 
% TrackModulus = The track modulus

%Load = Force applied by the train 

% Spring-bed properties
%k = Initial spring-bed coefficient
%c = The resistence of the spring-bed
%t = Thickness of geotextile

%iterations =  Number of iterations
%StepByStepFactor = A factor to lower the change in step in order to keep the model converging

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Calculation  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find the inital values before find the sleeper force
% s = Spacing of the sleepers
% E = Young's modulus of the rail
% I = Moment of inertia of the rail

% Calucating the force acting on the heaviest loaded sleeper according to Hateny
% beta =  (RailModulus / (4*E*I)) ^ (1/4)
% Force = (s*Load*beta/2)

% Make a line starting in the middle of the first sqaure and ending in the
%   middle of the last square with a spacing of stepsize in L
% Make a line starting in the middle of the first sqaure and ending in the
%   middle of the last square with a spacing of stepsize in W
% Make a mesh of the xx and yy.

% Make a grid of the stress by dviding the Force with the L and W 
% Make the resistance as a factor of the initial spring-bed by multiplying
% the initial spring-bed coefficent and the resistance


% Calculate the deflection of the half-space

% Define a matrix of zeroes in the size of the mesh looking at.

% A forloop for each sqaure in the length
% A forloop for each sqaure in the length
%     def(j,i) = def(j,i) + (4*q(j,i)/1000*stepsize*(1-nu^2)/E )* (log(1+sqrt(2))/pi)
% A new forloop for each sqaure in the length
% A new forloop for each sqaure in the length
% if-statement to find the squares away from the given point load and else do
% nothing 
%    Calculate the distance from the middle of the considered square to the point load
%       def(j,i) = def(j,i) + q(h,k)/1000*stepsize^2*(1-nu^2)/(E*pi*r)


% Find the average of the deflection
%    udiff = Average - deflection;
%    StressSpring = StepByStepFactor * (udiff * k(j));
%    q = StressSpring + q;
%    % Redesign spring coefficient for first iteration
%    [Spring,SpringDef] = NonLinearSpring(q, k(j), omega(j), t(p));




