function stepplots=plotOfSteps(  ConverStepOnOff,  StressEdge, yy,W, stepsize,E,k)
if ConverStepOnOff == 1;
    %%% If the lenght of stepsize is unknown and only the color of the
    %%% graph matters - meaning the line type is insignificant. 
    
%     for n = 1:length(stepsize)
%         plot(yy{n},StressEdge{n},'LineWidth',1);
%         hold on 
%         title({'Stress along the edge of the sleeper in width direction', ['E=' num2str(E) 'MPa and k_0=' num2str(k) 'kPa/mm']});
%         xlabel('Width / [mm]');
%         ylabel('Stress / [kPa]');
%         grid on
%         lgd = legend(string(stepsize),'location','eastoutside');
%         title(lgd,'a')
%         xlim([0, W])
%         %ylim([47.5,53]);
%     end
        
        figure()
        hold on 
        plot(yy{1},StressEdge{1},'-',yy{2},StressEdge{2},'--',yy{3},StressEdge{3}, '-.', yy{4},StressEdge{4},':', 'LineWidth',2.5);
        plot(yy{5},StressEdge{5},'-',yy{6},StressEdge{6},'--',yy{7},StressEdge{7}, '-.', 'LineWidth',1);
        title({'Stress along the edge of the sleeper in width direction', ['E=' num2str(E) 'MPa and k_0=' num2str(k) 'kPa/mm']});
        xlabel('Width [mm]');
        ylabel('Stress [kPa]');
        grid on
        lgd = legend(string(stepsize),'location','eastoutside');
        title(lgd,'a [mm]')
        xlim([0, W])
        hold off
        %ylim([47.5,53]);

end
end