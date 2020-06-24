function [StressNew,kCorrect, SpringDef] = forcedistribution(k, kOriginal, ohm, t, deflection, StressOld,i, StepByStepFactor)
    
    % Calculating 
    SpringDef = StressOld ./ k;
    SpringHeadDef = StepByStepFactor .* (deflection + SpringDef); % 0.1 factor for minimizing the step iteration
    
    Average = mean(mean(SpringHeadDef));
    udiff = Average - SpringHeadDef;
    
    StressSpring = udiff .* k;
    StressNew = StressSpring + StressOld;
    
    % Correction of spring-bed coefficient
    [Spring,SpringDef] = NonLinearSpring(StressNew, kOriginal, ohm, t);
    kCorrect = Spring; 
    
    %list for convergence
    %IMax(i)= abs(max(max(SpringHeadDef)) - min(min(SpringHeadDef))) * 1/StepByStepFactor; 
    
end