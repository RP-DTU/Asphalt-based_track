function mesh = StressFunctionkAndE(E, k, Stressdiff, t, c, SpringCoefficient, SpringDeflectionk, SpringDeflectionE)

StressMax = max(max(Stressdiff));
StressMin = min(min(Stressdiff));

if length(k) == 3

for i = 1:length(SpringDeflectionE)
    for j = 1:length(k)
   SpringdefMaxE(i,j) = max(max(SpringDeflectionE(i,j).matrix));
    end
end

%stress as a function of E at different values of k
figure(1001)
semilogy(E,Stressdiff(1,:),'-', E,Stressdiff(2,:),'--', E,Stressdiff(3,:),':','LineWidth',2);
    title({['Standard deviation of the stress'] ['as a function of Young´s modulus']});
    xlabel('E [MPa]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    ylim([StressMin, StressMax])


%Compression as a function of E
figure(1005)
plot(E,SpringdefMaxE(:,1),'-', E,SpringdefMaxE(:,2),'--', E,SpringdefMaxE(:,3),':','LineWidth',2);
     title({['Maximum compression as a function of Young´s modulus']});
    xlabel('E [MPa]');
    ylabel('Compression [mm]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]') 
    ylim([0, t])

else
    
%stress as a function of E at different values of k
figure(1001)
semilogy(E,Stressdiff,'LineWidth',2);
     title({['Standard deviation of the stress'] ['as a function of Young´s modulus']});
    xlabel('E [MPa]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]') 
    ylim([StressMin, StressMax])


%Compression as a function of E
% figure(1005)
% plot(E,SpringdefMaxE'LineWidth',2);
%      title({['Maximum compression as a function of Youngs modulus'] ['t =' num2str(t) 'mm and c =' num2str(c)]});
%     xlabel('E [MPa]');
%     ylabel('Compression [mm]');
%     grid on
%     lgd = legend(string(k),'location','eastoutside');
%     title(lgd,'k_0 [kPa/mm]')
%     ylim([0, t])
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(E) == 3
for i = 1:length(SpringDeflectionk)
    for j = 1:length(E)
   SpringdefMaxk(j,i) = max(max(SpringDeflectionk(j,i).matrix));
    end
end


    
%stress as a function of k at different values of E
figure(1002)
semilogy(k,Stressdiff(:,1),'-',k,Stressdiff(:,2),'--',k,Stressdiff(:,3), ':','LineWidth',2);
     title({['Standard deviation of the stress'] ['as a function of the initial spring-bed coefficient']});
    xlabel('k_0 [kPa/mm]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(E),'location','northeast');
    title(lgd,'E [MPa]') 
    ylim([StressMin, StressMax])
    

figure(1003)
plot(k,SpringdefMaxk(1,:),'-', k,SpringdefMaxk(2,:),'--', k,SpringdefMaxk(3,:),':','LineWidth',2);
     title({['Maximum compression'] ['as a function of the initial spring-bed coefficient']});
    xlabel('k_0 [kPa/mm]');
    ylabel('Compression [mm]');
    grid on
    lgd = legend(string(E),'location','northeast');
    title(lgd,'E [MPa]')
    ylim([0, t(1)])
else 
    figure(1002)
semilogy(k,Stressdiff,'LineWidth',2);
      title({['Standard deviation of the stress as a function of k_0']});
    xlabel('k_0 [kPa/mm]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(E),'location','northeast');
    title(lgd,'E [MPa]')
    ylim([StressMin, StressMax])
    

% figure(1003)
% plot(k,SpringdefMaxk,'LineWidth',2);
%      title({['Maximum compression as a function of k_0'] ['t =' num2str(t) 'mm and c =' num2str(c)]});
%     xlabel('k_0 [kPa/mm]');
%     ylabel('Compression [mm]');
%     grid on
%     lgd = legend(string(E),'location','eastoutside');
%     title(lgd,'E [MPa]')
%  
%     ylim([0, t(1)])
    
end
% Spring-bed cofficent
if length(E) == 1
    for i = 1:length(SpringCoefficient)
        for j = 1:length(E)
   SpringCoeMax(j,i) = max(max(SpringCoefficient(j,i).matrix));
        end
    end

figure(1004)
plot(k,SpringCoeMax(1,:),'-','LineWidth',2);
    title({['Maximum spring-bed coefficient'] ['as a function of initial spring-bed coefficient'] ['E = ' num2str(E) ' MPa and c = ' num2str(c)]});
    xlabel('k_0 [kPa/mm]');
    ylabel('k [kPa/mm]');
    grid on
    %lgd = legend(string(E),'location','northwest');
    %title(lgd,'E [MPa]')
    %ylim([0, 7])
else
% figure(1004)
% plot(k,SpringCoeMax);
%     title({['Final spring-bed coefficient as a function of initial k_0']});
%     xlabel('k_0 [kPa/mm]');
%     ylabel('k [kPa/mm]');
%     grid on
%     lgd = legend(string(E),'location','eastoutside');
%     title(lgd,'E [MPa]')
%     %ylim([0, 7])
end    
    

end