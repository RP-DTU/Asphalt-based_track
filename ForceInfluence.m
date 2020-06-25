function mesh = ForceInfluence(L, W, k, E, t, x, y, h,c, SizeY, SizeX, Load, QForce, SpringDeflectionForce, StressdiffForcek,  StressdiffForceE, MaxSpringForcek, MaxSpringForceE)

for i = 1:length(Load)
% Finding the stresses
StressMidLength(i,:) = QForce(i,1).matrix(SizeY/2,:) ; 
StressMidWide(i,:) = QForce(i,1).matrix(:,SizeX/2) ;
% Finding the compression
CompressionMidLength(i,:) = SpringDeflectionForce(i,1).matrix(SizeY/2,:) ; 
CompressionWideMid(i,:) = SpringDeflectionForce(i,1).matrix(:,SizeX/2) ;
end

for i = 1:length(Load)
StressMin(i) = min([min(StressMidLength(i,:)),min(StressMidWide(i,:))]);
StressMax(i) = max([max(StressMidLength(i,:)),max(StressMidWide(i,:))]);
CompressMin(i) = min([min(CompressionMidLength(i,:)),min(CompressionWideMid(i,:))]);
CompressMax(i) = max([max(CompressionMidLength(i,:)),max(CompressionWideMid(i,:))]);
end

StressMin = min(StressMin);
StressMax = max(StressMax);
CompressMin = min(CompressMin);
CompressMax = max(CompressMax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(Load) == 3
figure((h-1)*100+45);
    plot(x,StressMidLength(1,:),'-', x,StressMidLength(2,:),'--',x,StressMidLength(3,:),':','LineWidth',2);
    title({['Stress along the middle of the sleeper in length direction'] ['E = ', num2str(E(h)), ' MPa and k_0 = ' num2str(k) ' kPa/mm']} );
    xlabel('Length [mm]' );
    ylabel('Stress [kPa]' );
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    xlim([0, L])
    ylim([StressMin-1, StressMax+2])
    
% Stress throughout the edge of the sleeper in the direction of the length
     figure((h-1)*100+43);
    plot(y,StressMidWide(1,:),'-',y,StressMidWide(2,:),'--',y,StressMidWide(3,:),':','LineWidth',2);
    title({'Stress along the middle of the sleeper in width direction', ['E = ', num2str(E(h)), ' MPa and k_0 = ' num2str(k) ' kPa/mm']} );
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    xlim([0, W])
    ylim([StressMin-1, StressMax+2])
    
    
%%%%%%%%%%%% Compression     
    figure((h-1)*100+47);
    plot(x,CompressionMidLength(1,:),'-',x,CompressionMidLength(2,:),'--',x,CompressionMidLength(3,:),':','LineWidth',2);
    title({['Compression of the geotextile'] ['along the middle of the sleeper in length direction'] ['E = ', num2str(E(h)), ' MPa and k_0 = ' num2str(k) ' kPa/mm']} );
    xlabel('Length [mm]' );
    ylabel('Compression [mm]' );
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    xlim([0, L])
    ylim([CompressMin-0.1, CompressMax+0.1])
    
    
     figure((h-1)*100+48);
    plot(y,CompressionWideMid(1,:), '-', y,CompressionWideMid(2,:),'--', y,CompressionWideMid(3,:), ':','LineWidth',2);
    title({['Compression of the geotextile'] ['along the edge of the sleeper in length direction'] ['E = ', num2str(E(h)), ' MPa and k_0 = ' num2str(k) ' kPa/mm']} );
    xlabel('Length [mm]' );
    ylabel('Compreesion [mm]' );
    grid on
    lgd = legend(string(Load/1000),'location','best' );
    title(lgd,'Load [kN]')
    xlim([0, W])
    ylim([CompressMin-0.1, CompressMax+0.1])
    
elseif length(Load) == 4
figure((h-1)*100+45);
    plot(x,StressMidLength(1,:),'-', x,StressMidLength(2,:),'--',x,StressMidLength(3,:),':',x,StressMidLength(4,:),'-.','LineWidth',2);
    title({['Stress along the middle of the sleeper in length direction'] ['E = ', num2str(E(h)), ' MPa and k_0 = ' num2str(k) ' kPa/mm']} );
    xlabel('Length [mm]' );
    ylabel('Stress [kPa]' );
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    xlim([0, L])
    ylim([StressMin-1, StressMax+2])
    
% Stress throughout the edge of the sleeper in the direction of the length
%      figure((h-1)*100+43);
%     plot(y,StressMidWide(1,:),'-',y,StressMidWide(2,:),'--',y,StressMidWide(3,:),':',y,StressMidWide(4,:),'-.','LineWidth',2);
%     title({'Stress along the middle of the sleeper in width direction', ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0 =' num2str(k) 'kPa/mm and c =' num2str(c)]} );
%     xlabel('Width [mm]');
%     ylabel('Stress [kPa]');
%     grid on
%     lgd = legend(string(Load/1000),'location','northeast' );
%     title(lgd,'Load [kN]')
%     xlim([0, W])
%     ylim([StressMin-1, StressMax+2])
    
    
%%%%%%%%%%%% Compression     
    figure((h-1)*100+47);
    plot(x,CompressionMidLength(1,:),'-',x,CompressionMidLength(2,:),'--',x,CompressionMidLength(3,:),':',x,CompressionMidLength(4,:),'-.','LineWidth',2);
    title({['Compression of the geotextile'] ['along the middle of the sleeper in length direction'] ['E = ', num2str(E(h)), ' MPa and k_0 = ' num2str(k) ' kPa/mm']} );
    xlabel('Length [mm]' );
    ylabel('Compression [mm]' );
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    xlim([0, L])
    ylim([CompressMin-0.1, CompressMax+0.1])
    
    
%      figure((h-1)*100+48);
%     plot(y,CompressionWideMid(1,:), '-', y,CompressionWideMid(2,:),'--', y,CompressionWideMid(3,:), ':',y,CompressionWideMid(4,:), '-.','LineWidth',2);
%     title({['Compression of the geotextile'] ['along the edge of the sleeper in length direction'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0 =' num2str(k) 'kPa/mm and c =' num2str(c)]} );
%     xlabel('Length [mm]' );
%     ylabel('Compreesion [mm]' );
%     grid on
%     lgd = legend(string(Load/1000),'location','best' );
%     title(lgd,'Load [kN]')
%     xlim([0, W])
%     ylim([CompressMin-0.1, CompressMax+0.1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Collect all plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%
if length(k) == 1
figure(1001)
semilogy(E,StressdiffForceE(1,:),'-', E,StressdiffForceE(2,:),'--', E,StressdiffForceE(3,:),':', E,StressdiffForceE(4,:),'-.','LineWidth',2);
    title({['Standard deviation'] ['of the stress distribution as a function of E'] ['k_0 = ' num2str(k) ' kPa/mm']});
    xlabel('E [MPa]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    %ylim([min(min(StressdiffForceE)), StressMax])


%Compression as a function of E
figure(1005)
plot(E,MaxSpringForceE(1,:),'-', E,MaxSpringForceE(2,:),'--', E,MaxSpringForceE(3,:),':',E,MaxSpringForceE(4,:),'-.','LineWidth',2);
     title({['Maximum compression'] ['as a function of Youngs modulus'] ['k_0 = ' num2str(k) ' kPa/mm']});
    xlabel('E [MPa]');
    ylabel('Compression [mm]');
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    ylim([0, 7])
end
if length(E) == 1
    figure(1002)
semilogy(k,StressdiffForcek(1,:),'-',k,StressdiffForcek(2,:),'--',k,StressdiffForcek(3,:), ':',k,StressdiffForcek(4,:), '-.','LineWidth',2);
     title({['Standard deviation'] ['of the stress distribution as a function of k_0'] ['E = ' num2str(E) ' MPa']});
    xlabel('k_0 [kPa/mm]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    %ylim([StressMin, StressMax])
    

figure(1003)
plot(k,MaxSpringForcek(1,:),'-', k,MaxSpringForcek(2,:),'--', k,MaxSpringForcek(3,:),':',k,MaxSpringForcek(4,:),'-.','LineWidth',2);
     title({['Maximum compression'] ['as a function of k_0'] ['E = ' num2str(E) ' MPa']});
    xlabel('k_0 [kPa/mm]');
    ylabel('Compression [mm]');
    grid on
    lgd = legend(string(Load/10000),'location','northeast' );
    title(lgd,'Axle load [t]')
    ylim([0, t(1)])
end


end







