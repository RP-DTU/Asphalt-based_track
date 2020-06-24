clc; clear; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Initial values    %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Properties for the sleeper - changes when meshstudy is on
L = 2500; % [mm]
W = [300 600] ; % [mm]

% Stepsize within the sleeper
stepsize = 10; % [mm]

% Properties for the half-space 
E = 200; % [MPa]
nu = 0.35; % [-]
TrackModulus = 50e6; %[Pa] Rail modulus

% Force applied total for 20t axle load
Load = [200e3]; % [N]

% Springcoeffient
k = 5.9; % [kPa/mm]
c = 15; %Factor of resistance
t = [7]; %[mm] Thickness of geotextile

% Number of Iteration 
iterations =  30;
StepByStepFactor = 0.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%    Choice of plots    %%%%%%%%%%%%%%%
%%%%%%%%%    On = 1 , Off = 0   %%%%%%%%%%%%%%%

% Set Surrounding pavement on/off
SurPavementOn = 0;

% Set Stress on/off
StressOnOff = 0;

%Set deflection on/off
DeflectionOnOff = 0;

% Set Heatmap on/off
HeatmapOnOff = 0;

% Set Curves of the stress throughout the middle and edge of the sleeper at
StressCurvesOnOff = 0;

% Make a 3d plot of the deflection of the springs
DeflectionSpringOnOff = 0;

% Make a Heatmap of the deflection of the springs
HeatmapSpringOnOff = 0;

% Set Curves of the deflection of the springs throughout the middle and edge of the sleeper
DeflectionCurveSpringOnOff = 0;

% Plot curves of the compression throughtout the middle of the sleeper with
% verious E modulus
CompressionCurveSpringEModulus = 0;

% Various resistent values
StressVariousResistentOnOff = 0;

% Spring-bed coefficient curve
SpringBedMapOnOff = 0;

% Various thinkness with different spring-bed values
VariousthinknessOnOff = 0;

% Collect all points in a 3d plot with E,k and difference in max-min stress
% along with stressdifference as a function of k and E
CollectAllOnOff = 0;

% Plot convergence of iterations
ConvergenceStudyOnOff = 0;

%plot mesh convergence. Change stepsize
ConverStepOnOff = 0;

% Plot sleepersizes against eachother
SleeperDifferencesOnOff = 0;

% Plot influence of the force
ForceInfluenceOnOff = 0;

% Mesh of influence of resistance and k0
CollectOfCandkOnoff = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Calculation  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
if ConverStepOnOff == 1
    %for meshconvergence - common divisors of L and W
    stepsize=steps(L,W); %[mm]
end 

for b = 1:length(W) %Forloop for each of the sleepers
for r = 1:length(Load) %Forloop for a new axle force
    
%calculating worst force on sleeper
force(r)=SleeperForce(Load(r),W(b),TrackModulus)*1000; %mN

for p = 1:length(t) % For loop for thickness of geotextile
for h = 1:length(E) % For loop for Young's modulus
for j = 1:length(k) % For loop for spring coefficient
for m = 1:length(c) % For loop for Spring resistance
for n = 1:length(stepsize) % For loop for stepsize
    
    % Setting up matrix for graph and calculations
    xx{n} = (0+stepsize(n)/2:stepsize(n):L-stepsize(n)/2);
    yy {n}= (0+stepsize(n)/2:stepsize(n):W(b)-stepsize(n)/2);
    y=yy{n};
    x=xx{n};
    SizeX = length(x);
    SizeY = length(y);
    [X,Y] = meshgrid(x,y);
    
    % Defining the first loadcase
    q = force(r)/(W(b)*L) * ones(SizeY,SizeX); % kPa
    omega(j) = k(j) * c(m); %Resistant defining
    IMax=[];
    
    %First iteration
    deflection = deflectionPavement2(stepsize(n), q, nu, E(h) ,X ,Y , SizeX, SizeY);
    %NeW(b) stress for first iteration
    Average = mean(mean(deflection));
    udiff = Average - deflection;
    StressSpring = StepByStepFactor * (udiff * k(j));
    q = StressSpring + q;
    % Redesign spring coefficient for first iteration
    [Spring,SpringDef] = NonLinearSpring(q, k(j), omega(j), t(p));
    
    % Stress and deflection calculations - newx iterations
    for i = 1:iterations
    deflection = deflectionPavement2(stepsize(n), q, nu, E(h) ,X ,Y , SizeX, SizeY);
    [q, Spring, SpringDef] = forcedistribution(Spring, k(j), omega(j), t(p), deflection, q, i, StepByStepFactor);
    IMax(i)= std2(q);
    end
    
    %Final deflection-step
    deflection = deflectionPavement2(stepsize(n), q, nu, E(h) ,X ,Y , SizeX, SizeY);
    
    % Calculate the surrounding deflection
    [deflectionSurrounding,XPavement,YPavement] = SurroundingPavement(stepsize(n), q, E(h),nu, X, Y, deflection);

    % Calculating the tolerance and stress values at each k value
    if ConverStepOnOff==0
    Stressdiff(j,h) = std2(q); %Package "Image Processing Toolbox"
    OmegaStep(m) = std2(q); % Package "Image Processing Toolbox"
    ThicknessSTD(p,j) = std2(q); % std of thickness
    StressdiffSleeper(b,h) = std2(q); %std for RailOne and standard sleeper
    MaxSpring(m,j) = max(max(Spring)); %Maximum spring coefficient as a influence of k0 and resistance
    Stressdiffcandk(m,j) = std2(q); %std for different k0 and c
    StressdiffForcek(r,j) = std2(q); % std fir different forces and k
    StressdiffForceE(r,h) = std2(q); % std fir different forces and E
    MaxSpringForcek(r,j) = max(max(SpringDef)); % Maximum compression
    MaxSpringForceE(r,h) = max(max(SpringDef)); % maximum compression
    end 
    
    %Save the calculations in order to have the right axis values in the plot
    QSleeper(b,h).matrix = q; %Differences in Sleeper
    Q(j,m).matrix = q; % Stress
    QForce(r,j).matrix = q; %Stress with difference forces
    uSleeper(b,h).matrix = SpringDef; %Compression in different sleeper
    Def(j).matrix =  deflection; %deflection of the pavement 
    DefPavement(j).matrix = deflectionSurrounding; %deflection of the surrounding pavement
    IMaxk(j,:)=IMax;% Convergence
    SpringCoefficient(h,j).matrix = Spring; %Spring Coefficent
    SpringDeflection(j).matrix = SpringDef; %Spring deflection
    SpringDeflectionk(h,j).matrix = SpringDef; %Spring deflection for k
    SpringDeflectionE(h,j).matrix = SpringDef; %Spring deflection for E
    SpringDeflectionForce(r,h).matrix = SpringDef; %Spring deflection for force
    SpringDeflectionESleeper(b,h).matrix = SpringDef; %Spring deflection for E for different sleepers
    StepStressMin(j,n)= min(min(q)); %meshConvergence, minimum stress
    StepStressMax(j,n)= max(max(q)); %meshConvergence, maximum stress
    StepStd(j,n) = std2(q); %Mesh convergence, std.
    StressEdge {n}= q(:,1) ; %meshConvergence, edge
    
end
%plotting stresses along edge for different stepsizes
plotOfSteps(ConverStepOnOff, StressEdge, yy,W(b), stepsize,E,k)
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   Plotting convergence study   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ConvergenceStudyOnOff == 1
    ConvergenceStudy(ConvergenceStudyOnOff, iterations,IMaxk,E(h),k);
end

if ConverStepOnOff==1
    ConverStep(ConverStepOnOff,E,k, stepsize,StepStressMax, StepStressMin, StepStd);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Plotting stress, deflection and heatmaps  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
StressDefHeat(k, E, omega, h, L, W(b), x, y, X, Y, c, t(p), XPavement, YPavement, SurPavementOn, StressOnOff, DeflectionOnOff, HeatmapOnOff, Q, Def, DefPavement)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Plotting spring-bed coefficient  %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SpringbedPlot(SpringCoefficient, k,E, h, L, W(b), c, X, Y, t(p), SpringBedMapOnOff) 

if ConverStepOnOff==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Plotting 2d stress curves     %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StressCurvesAtkValues(x, y, h, W(b), L, E, k, c, t(p), SizeY,SizeX, Q,StressCurvesOnOff)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Plotting Various resistent values  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StressVariousResistent(x, y, h, W(b), L, E, k, c, Q, SpringCoefficient,StressVariousResistentOnOff, OmegaStep, t(p),MaxSpring,CollectOfCandkOnoff,Stressdiffcandk)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Plotting spring information   %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DeformSpringPlot(X, Y, x, y, SizeY ,SizeX , h, k, E, L, t(p), W(b), c, SpringDeflection, DeflectionSpringOnOff, HeatmapSpringOnOff, DeflectionCurveSpringOnOff)

DeformationMidLength(h,:) = SpringDeflectionk(j).matrix(SizeY/2,:);
end


end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if CompressionCurveSpringEModulus == 1
    % Deformation throughout the middle of the sleeper in the direction of the length
    figure((h-1)*100+75);
    hold on 
    plot(x,DeformationMidLength,'LineWidth',1);
    title({['Compression of the spring-bed'], ['along the middle of the sleeper in lenght direction'], ['t =' num2str(t(p)) 'mm, k=', num2str(k), 'MPa and c =' num2str(c)]}, 'FontName', 'Times');
    xlabel('Length / [mm]', 'FontName', 'Times');
    ylabel('Compression / [mm]', 'FontName', 'Times');
    grid on
    lgd = legend(string(E),'location','eastoutside', 'FontName', 'Times');
    title(lgd,'E / [MPa]', 'FontName', 'Times')
    xlim([0, L])
    ylim([0, t]) 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting a collection of all diff in stresses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if CollectAllOnOff == 1
CollectAllPoints(E, k, Stressdiff,t,c)
StressFunctionkAndE(E, k, Stressdiff, t, c, SpringCoefficient, SpringDeflectionk, SpringDeflectionE)
end
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         % Various Thinkness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VariousThickness(X, Y, x, y, k, E, t, c, ThicknessSTD, VariousthinknessOnOff)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         % Difference in stress for sleeper
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SleeperDifferences(L, W, k, E, t, x, y, h,c, SizeY, SizeX, QSleeper, SleeperDifferencesOnOff, uSleeper,StressdiffSleeper,SpringDeflectionESleeper)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         % Force influence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ForceInfluenceOnOff == 1
ForceInfluence(L, W, k, E, t, x, y, h,c, SizeY, SizeX, Load, QForce, SpringDeflectionForce, StressdiffForcek,  StressdiffForceE, MaxSpringForcek, MaxSpringForceE)
end
toc