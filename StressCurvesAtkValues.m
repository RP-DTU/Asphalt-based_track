function mesh = StressCurvesAtkValues(x, y, h, W, L, E, k, c, t, SizeY,SizeX, Q, StressCurvesOnOff)
   

if StressCurvesOnOff == 1

for j = 1:length(k)        
StressMidLength(j,:) = Q(j).matrix(SizeY/2,:) ; 
StressEdgeLength(j,:) = Q(j).matrix(1,:) ;
StressMidWide(j,:) = Q(j).matrix(:,SizeX/2) ;
StressEdgeWide(j,:) = Q(j).matrix(:,1) ;
end
        
        
% StressMaxVector = [max(max(StressEdgeLength)), max(max(StressMidLength)), max(max(StressEdgeWide)), max(max(StressMidWide))];
% StressMinVector = [min(min(StressEdgeLength)), min(min(StressMidLength)), min(min(StressEdgeWide)), min(min(StressMidWide))];
StressMaxVector = [max(max(StressMidLength)),max(max(StressMidWide))];
StressMinVector = [min(min(StressMidLength)),min(min(StressMidWide))];

StressMax = max(StressMaxVector);
StressMin = min(StressMinVector);
 StressMax = 52;
 StressMin = 46;




if length(k) == 4
% Stress throughout the middel of the sleeper in the direction of the length
    figure((h-1)*100+41);
    plot(x,StressMidLength(1,:),'-',x,StressMidLength(2,:),'--',x,StressMidLength(3,:),'-.',x,StressMidLength(4,:),':','LineWidth',2);
    title({['Stress along the middle of the sleeper in length direction'] ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Length [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, L])
    ylim([StressMin, StressMax])   
% Stress throughout the edge of the sleeper in the direction of the length
    figure((h-1)*100+42);
    plot(x,StressEdgeLength(1,:),'-',x,StressEdgeLength(2,:),'--',x,StressEdgeLength(3,:),'-.',x,StressEdgeLength(4,:),':','LineWidth',2);
    title({'Stress along the edge of the sleeper in length direction', ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Length [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, L])
    ylim([StressMin, StressMax])
    
% Stress throughout the middel of the sleeper in the direction of the width
    figure((h-1)*100+43);
    plot(y,StressMidWide(1,:),'-',y,StressMidWide(2,:),'--',y,StressMidWide(3,:),'-.',y,StressMidWide(4,:),':','LineWidth',2);
    title({'Stress along the middle of the sleeper in width direction', ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, W])
    ylim([StressMin, StressMax])
    
% Stress throughout the edge of the sleeper in the direction of the width
    figure((h-1)*100+44);
    plot(y,StressEdgeWide(1,:),'-',y,StressEdgeWide(2,:),'--',y,StressEdgeWide(3,:),'-.',y,StressEdgeWide(4,:),':','LineWidth',2);
    title({'Stress along the edge of the sleeper in width direction', ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, W])
    ylim([StressMin, StressMax])

else 
       
        % Stress throughout the middel of the sleeper in the direction of the length
    figure((h-1)*100+41);
    plot(x,StressMidLength,'LineWidth',2);
    title({['Stress along the middle of the sleeper in length direction'] ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Length [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, L])
    ylim([StressMin, StressMax])   
% Stress throughout the edge of the sleeper in the direction of the length
    figure((h-1)*100+42);
    plot(x,StressEdgeLength,'LineWidth',2);
    title({'Stress along the edge of the sleeper in length direction', ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Length [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, L])
    ylim([StressMin, StressMax])
    
% Stress throughout the middel of the sleeper in the direction of the width
    figure((h-1)*100+43);
    plot(y,StressMidWide,'LineWidth',2);
    title({'Stress along the middle of the sleeper in width direction', ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, W])
    ylim([StressMin, StressMax])
    
% Stress throughout the edge of the sleeper in the direction of the width
    figure((h-1)*100+44);
    plot(y,StressEdgeWide,'LineWidth',2);
    title({'Stress along the edge of the sleeper in width direction', ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(k),'location','northeast');
    title(lgd,'k_0 [kPa/mm]')
    xlim([0, W])
    ylim([StressMin, StressMax])
end
        
end
end


    