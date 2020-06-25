function DeformationSpringPlot = DeformSpringPlot(X, Y, x, y, SizeY, SizeX, h, k, E, L, t, W, c, SpringDeflection, DeflectionSpringOnOff, HeatmapSpringOnOff, DeflectionCurveSpringOnOff)




% Find the deflection of the springs in verious direction along the sleeper
for j = 1:length(k)
DeformationMidLength(j,:) = SpringDeflection(j).matrix(SizeY/2,:) ; 
DeformationsEdgeLength(j,:) = SpringDeflection(j).matrix(1,:) ;
DeformationMidWide(j,:) = SpringDeflection(j).matrix(:,SizeX/2) ;
DeformationEdgeWide(j,:) = SpringDeflection(j).matrix(:,1) ;
end


DeflectionMaxVector = [max(max(DeformationMidLength)),max(max(DeformationMidWide))];
DeflectionMinVector = [min(min(DeformationMidLength)),min(min(DeformationMidWide))];

deflectionmax = max(DeflectionMaxVector);
deflectionmin = min(DeflectionMinVector);
% % Deformantion of springs
  deflectionmin = 1.5;
  deflectionmax = 1.6;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%   Deformation    %%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(k)
     % Plot the deflection off the  springbed
    if DeflectionSpringOnOff == 1
    figure((h-1)*100+50+i)
    mesh(X,Y,SpringDeflection(i).matrix);
    title({['Compression of spring-bed'] ['E = ' num2str(E(h)) ' MPa and k_0 = ' num2str(k(i)) ' kPa/mm']});
    xlabel('Length [mm]');
    ylabel('Width [mm]');
    zlabel('Compression [mm]');
    xlim([0, L]);
    ylim([0, W]);
    zlim([deflectionmin, deflectionmax]);
    if W == 300
    pbaspect([4 1 1]);
    else
    pbaspect([2 1 1]);          
    end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%    Heatmap       %%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %Make heatmap of the deformation
    if HeatmapSpringOnOff == 1
        
        if E(h) == 2000
           cline = [0:0.002:t];
        elseif E(h) == 20000
            cline = [0:0.0002:t];
        else 
            cline = [0:0.02:t];
        end
        
    figure((h-1)*100+60+i);
    contourf(X(1,:),Y(:,1),SpringDeflection(i).matrix,cline,'ShowText','on')
    caxis([deflectionmin, deflectionmax])
    colorbar
    title({'Heatmap of the spring-bed compression [mm]', ['E = ' num2str(E(h)) ' MPa and k_0 = ' num2str(k(i)) ' kPa/mm']});
    xlabel('Length [mm]');
    ylabel('Width [mm]');
    if W == 300
    pbaspect([4 1 1]);
    else
    pbaspect([2 1 1]);
    end       
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%    2d deformation plot   %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if DeflectionCurveSpringOnOff == 1
    % Deformation throughout the middel of the sleeper in the direction of the length
    figure((h-1)*100+71);
    plot(x,DeformationMidLength(1,:),'-',x,DeformationMidLength(2,:),'--',x,DeformationMidLength(3,:),'-.',x,DeformationMidLength(4,:),':','LineWidth',2);
    title({['Compression of the spring-bed']  ['along the middle of the sleeper in lenght direction'] ['E = ' num2str(E(h)) ' MPa']});
    xlabel('Length [mm]');
    ylabel('Compression [mm]');
    grid on
    lgd = legend(string(k),'location','northeast' );
    title(lgd,'k_0 [kPa/mm]' )
    xlim([0, L])
    ylim([0,7])
    %ylim([deflectionmin-0.1, deflectionmax+0.1])   

    % Deformation throughout the edge of the sleeper in the direction of the length
    figure((h-1)*100+72);
    plot(x,DeformationsEdgeLength(1,:),'-',x,DeformationsEdgeLength(2,:),'--',x,DeformationsEdgeLength(3,:),'-.',x,DeformationsEdgeLength(4,:),':','LineWidth',2);
    title({['Compression of the spring-bed'] ['along the edge of the sleeper in length direction'] ['E = ' num2str(E(h)) ' MPa']} );
    xlabel('Length [mm]' );
    ylabel('Compression [mm]' );
    grid on
    lgd = legend(string(k),'location','northeast' );
    title(lgd,'k_0 [kPa/mm]' )
    xlim([0, L])
     %ylim([deflectionmin-0.1, deflectionmax+0.1]) 
    ylim([0,7])

    % Deformation throughout the middel of the sleeper in the direction of the width
    figure((h-1)*100+73);
    plot(y,DeformationMidWide(1,:), '-',y,DeformationMidWide(2,:), '--',y,DeformationMidWide(3,:), '-.',y,DeformationMidWide(4,:), ':','LineWidth',2);
    title({['Compression of the spring-bed']  ['along the middle of the sleeper in width direction'] ['E = ' num2str(E(h)) ' MPa']} );
    xlabel('Width [mm]' );
    ylabel('Compression [mm]' );
    grid on
    lgd = legend(string(k),'location','northeast' );
    title(lgd,'k_0 [kPa/mm]' )
    xlim([0, W])
     %ylim([deflectionmin-0.1, deflectionmax+0.1]) 
    ylim([0,7])

    %Deformation throughout the edge of the sleeper in the direction of the width
    figure((h-1)*100+74);
    plot(y,DeformationEdgeWide(1,:),'-',y,DeformationEdgeWide(2,:),'--',y,DeformationEdgeWide(3,:),'-.',y,DeformationEdgeWide(4,:),':','LineWidth',2);
    title({['Compression of the spring-bed']  ['along the edge of the sleeper in width direction'] ['E = ' num2str(E(h)) ' MPa']} );
    xlabel('Width [mm]' );
    ylabel('Compression [mm]' );
    grid on
    lgd = legend(string(k),'location','northeast' );
    title(lgd,'k_0 [kPa/mm]' )
    xlim([0, W])
     %ylim([deflectionmin-0.1, deflectionmax+0.1]) 
     ylim([0,7])
    end
end

    end

