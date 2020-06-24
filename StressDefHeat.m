function plot = StressDefHeat(k, E, ohm, h, L, W, x, y, X, Y, c,t, XPavement, YPavement, SurPavementOn, StressOnOff, DeflectionOnOff, HeatmapOnOff, Q, Def, DefPavement)

%Predefined values off max and min stress and deflection
%Done in [mm]
    for i = 1:length(k)
    Stress_max(i) = max(max(Q(i).matrix));
    Stress_min(i) = min(min(Q(i).matrix)) ;
    Deflection_max(i) = max(max(Def(i).matrix)) ;
    Deflection_min(i) = min(min(Def(i).matrix)) ;
    end
    
    %stressmax = max(Stress_max);
    %stressmin = min(Stress_min);
    stressmax = 51;
    stressmin = 44;
    deflectionmax = max(Deflection_max);
    deflectionmin = min(Deflection_min);
    
    % Plot for each value of k
    for i = 1:length(k)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%    Stress        %%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Plot the stresses under the half space
    if StressOnOff == 1
    figure((h-1)*100+i);
    mesh(X,Y,Q(i).matrix);
    title({['Stress distribution in the spring-bed'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0=' num2str(k(i)), 'kPa/mm and c =' num2str(c)]});
    xlabel('Length [mm]');
    ylabel('Width [mm]');
    zlabel('Stress [kPa]');
    xlim([0, L]);
    ylim([0, W]);
    zlim([stressmin, stressmax]);   
    if W == 300
    pbaspect([4 1 1]);
    else
    pbaspect([2 1 1]);  
    end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%   Deformation    %%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     % Plot the deflection off the half space 
    if DeflectionOnOff == 1
    if SurPavementOn == 1
    figure((h-1)*100+10+i);
    mesh(XPavement,YPavement,DefPavement(i).matrix);
    set(gca, 'ZDir','reverse')
    title({['Compression of half-space under and around the sleeper'] ['E=', num2str(E(h) ), 'MPa, t =' num2str(t) 'mm, k_0=' num2str(k(i)), 'kPa/mm and c =' num2str(c)]});
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
    else    
    figure((h-1)*100+10+i)
    mesh(X,Y,Def(i).matrix);
    set(gca, 'ZDir','reverse');
    title({['Compression of the half-space under sleeper'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0=' num2str(k(i)), 'kPa/mm and c =' num2str(c)]});
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
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%    Heatmap       %%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %Make heatmap of the stress
    if HeatmapOnOff == 1
        
        if E(h) == 2000
           cline = [10:0.1:100];
        elseif E(h) == 20000
            cline = [10:0.01:100];
        else 
            cline = [10:1:100];
        end
        
    figure((h-1)*100+20+i);
    contourf(x,y,Q(i).matrix,cline,'ShowText','on')
    caxis([stressmin,stressmax])
    colorbar
    title({['Heatmap of the stress in the spring-bed [kPa]'] ['E=', num2str(E(h)), 'MPa, t =' num2str(t) 'mm, k_0=' num2str(k(i)), 'kPa/mm and c =' num2str(c)]});
    xlabel('Length [mm]');
    ylabel('Width [mm]');
    if W == 300
    pbaspect([4 1 1]);
    else
    pbaspect([2 1 1]);  
    end
    end
    
    end