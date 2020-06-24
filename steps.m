function step=steps(L,W)
%fining common divisors of L and W to find teh possible stepsizes
% starting at 4 since its quite low and as the small values are close 
step(1)=4;
for i =5: min(W, L)
    if mod(W,i)==0 && mod(L,i)==0
        step(end+1)=i;
    end
end

step=fliplr(step);
end