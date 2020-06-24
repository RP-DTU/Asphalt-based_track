function PlottingSleeper = SleeperDifferences(L, W, k, E, t, x, y, h,c, SizeY, SizeX, QSleeper, SleeperDifferencesOnOff, uSleeper,StressdiffSleeper,SpringDeflectionESleeper)


if SleeperDifferencesOnOff == 1       
% Finding the stresses
StressMidLength(1,:) = QSleeper(1).matrix(SizeY/4,:) ; 
StressEdgeLength(1,:) = QSleeper(1).matrix(1,:) ;
StressMidLength(2,:) = QSleeper(2).matrix(SizeY/2,:) ; 
StressEdgeLength(2,:) = QSleeper(2).matrix(1,:) ;
% Finding the compression
CompressionMidLength(1,:) = uSleeper(1).matrix(SizeY/4,:) ; 
CompressionEdgeLength(1,:) = uSleeper(1).matrix(1,:) ;
CompressionMidLength(2,:) = uSleeper(2).matrix(SizeY/2,:) ; 
CompressionEdgeLength(2,:) = uSleeper(2).matrix(1,:) ;

StressMin = min([min(StressEdgeLength(1,:)), min(StressMidLength(1,:)), min(StressEdgeLength(2,:)), min(StressMidLength(2,:))]);
StressMax = max([max(StressEdgeLength(1,:)), max(StressMidLength(1,:)), max(StressEdgeLength(2,:)), max(StressMidLength(2,:))]);
CompressMin = 1.5;
CompressMax = 1.65;

% Plotting
 figure((h-1)*100+45);
    plot(x,StressMidLength(1,:),'-', x,StressMidLength(2,:),'--','LineWidth',2);
    title({['Stress along the middle of the sleeper in length direction'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0 =' num2str(k) 'kPa/mm and c =' num2str(c)]} );
    xlabel('Length [mm]' );
    ylabel('Stress [kPa]' );
    grid on
    lgd = legend('S99','RailOne','location','northeast' );
    title(lgd,'Type' )
    xlim([0, L])
    ylim([StressMin-1, StressMax+2])   
% Stress throughout the edge of the sleeper in the direction of the length
    figure((h-1)*100+46);
    plot(x,StressEdgeLength(1,:), '-', x,StressEdgeLength(2,:), '--' ,'LineWidth',2);
    title({['Stress along the edge of the sleeper in length direction'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0 =' num2str(k) 'kPa/mm and c =' num2str(c)]} );
    xlabel('Length [mm]' );
    ylabel('Stress [kPa]' );
    grid on
    lgd = legend('S99','RailOne','location','northeast' );
    title(lgd,'Type' )
    xlim([0, L])
    ylim([StressMin-1, StressMax+2])
    
%%%%%%%%%%%% Compression     
    figure((h-1)*100+47);
    plot(x,CompressionMidLength(1,:),'-',x,CompressionMidLength(2,:),'--','LineWidth',2);
    title({['Compression of the geotextile'] ['along the middle of the sleeper in length direction'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0 =' num2str(k) 'kPa/mm and c =' num2str(c)]} );
    xlabel('Length [mm]' );
    ylabel('Compression [mm]' );
    grid on
    lgd = legend('S99','RailOne','location','northeast' );
    title(lgd,'Type' )
    xlim([0, L])
    ylim([CompressMin, CompressMax])   
% COmpression throughout the edge of the sleeper in the direction of the length
    figure((h-1)*100+48);
    plot(x,CompressionEdgeLength(1,:), '-', x,CompressionEdgeLength(2,:), '--','LineWidth',2);
    title({['Compression of the geotextile'] ['along the edge of the sleeper in length direction'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0 =' num2str(k) 'kPa/mm and c =' num2str(c)]} );
    xlabel('Length [mm]' );
    ylabel('Compreesion [mm]' );
    grid on
    lgd = legend('S99','RailOne','location','northeast' );
    title(lgd,'Type' )
    xlim([0, L])
    ylim([CompressMin, CompressMax])
  
    % Std for types as a function of E
figure(1001)
plot(E,StressdiffSleeper(1,:),'-', E,StressdiffSleeper(2,:),'--','LineWidth',2);
    title({['Standard deviation'] ['of the stress as a function of E'] ['t =' num2str(t) 'mm and c =' num2str(c)]});
    xlabel('E [MPa]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend('S99','RailOne','location','northeast');
    title(lgd,'type')
    ylim([min(min(StressdiffSleeper)), max(max(StressdiffSleeper))])       

% Compression as a function of E
for i = 1:length(SpringDeflectionESleeper)
    for j = 1:2
   SpringdefMaxE(j,i) = max(max(SpringDeflectionESleeper(j,i).matrix));
    end
end
    figure(1005)
plot(E,SpringdefMaxE(1,:),'-', E,SpringdefMaxE(2,:),'--','LineWidth',2);
     title({['Maximum compression'] ['as a function of Youngs modulus'] ['t =' num2str(t) 'mm and c =' num2str(c)]});
    xlabel('E [MPa]');
    ylabel('Compression [mm]');
    grid on
    lgd = legend('S99','RailOne','location','northeast' );
    title(lgd,'type')
     ylim([CompressMin, CompressMax])
%     
end
 
 
