function mesh = StressVariousResistent(x, y, h, W, L, E, k, c, Q, SpringCoefficient, StressVariousResistentOnOff, OmegaStep,t, MaxSpring,CollectOfCandkOnoff, Stressdiffcandk)
    
if StressVariousResistentOnOff == 1
SizeY = length(y);
SizeX = length(x);
    
for j = 1:length(c)
StressMidLength(j,:) = Q(1,j).matrix(SizeY/2,:) ; 
StressEdgeLength(j,:) = Q(1,j).matrix(1,:) ;
StressMidWide(j,:) = Q(1,j).matrix(:,SizeX/2) ;
StressEdgeWide(j,:) = Q(1,j).matrix(:,1) ;
end    
    
StressMaxVector = [max(max(StressEdgeLength)), max(max(StressMidLength)), max(max(StressEdgeWide)), max(max(StressMidWide))];
StressMinVector = [min(min(StressEdgeLength)), min(min(StressMidLength)), min(min(StressEdgeWide)), min(min(StressMidWide))];
StressMax = max(StressMaxVector);
StressMin = min(StressMinVector);
if E(1) == 1
% Stress throughout the middel of the sleeper in the direction of the length
    figure((h-1)*100+45);
    plot(x,StressMidLength,'LineWidth',1);
    title({['Stress along the middle of the sleeper in length direction'] ['E=', num2str(E(h)), 'MPa and k0=', num2str(k(1)), 'kPa/mm']});
    xlabel('Length [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(c),'location','eastoutside');
    title(lgd,'c [-]')
    xlim([0, L])
    ylim([StressMin, StressMax])   
% Stress throughout the edge of the sleeper in the direction of the length
    figure((h-1)*100+46);
    plot(x,StressEdgeLength,'LineWidth',1);
    title({'Stress along the edge of the sleeper in length direction', ['E=', num2str(E(h)), 'MPa and k0=', num2str(k(1)), 'kPa/mm']});
    xlabel('Length [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(c),'location','eastoutside');
    title(lgd,'c [-]')
    xlim([0, L])
    ylim([StressMin, StressMax])
    
% Stress throughout the middel of the sleeper in the direction of the width
    figure((h-1)*100+47);
    plot(y,StressMidWide,'LineWidth',1);
    title({'Stress along the middle of the sleeper in width direction', ['E=', num2str(E(h)), 'MPa and k0=', num2str(k(1)), 'kPa/mm']});
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(c),'location','eastoutside');
    title(lgd,'c [-]')
    xlim([0, W])
    ylim([StressMin, StressMax])
    
% Stress throughout the edge of the sleeper in the direction of the width
    figure((h-1)*100+48);
    plot(y,StressEdgeWide,'LineWidth',1);
    title({'Stress along the edge of the sleeper in width direction', ['E=', num2str(E(h)), 'MPa and k0=', num2str(k(1)), 'kPa/mm']});
    xlabel('Width [mm]');
    ylabel('Stress [kPa]');
    grid on
    lgd = legend(string(c),'location','eastoutside');
    title(lgd,'c [-]')
    xlim([0, W])
    ylim([StressMin, StressMax])
end
    
    figure(1005)
plot(c,OmegaStep,'LineWidth',2);
    title({['Standard deviation of the stress distribution as a function of c'], ['E = ' num2str(E(h)) ' MPa and k_0 = ' num2str(k(1)) ' kPa/mm']});
    xlabel('c [-]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend('k = k_0 + c * k_0 * x / (t-x)','location','northwest');
end

if CollectOfCandkOnoff == 1

figure(1001)    
carray = repelem(c,length(c));
karrayfirst = repmat(k,length(c));
karray = karrayfirst(1,:);
MaxSpring = reshape(MaxSpring,1,numel(MaxSpring));
%Stressdiff = Stressdiff * 1000;
% Find the difference
diff = max(MaxSpring) - min(MaxSpring);

% Make the colormap and plot it
cm = colormap(cool(round(diff)));
hold all
for k1 = 1:numel(MaxSpring)
    sh(k1) = stem3(carray(k1), karray(k1), MaxSpring(k1));
    cm_idx = max( MaxSpring(k1) - min(MaxSpring), 1 );
    set(sh(k1), 'Color',cm(round(cm_idx),:), 'MarkerFaceColor',cm(round(cm_idx),:), 'MarkerEdgeColor',cm(round(cm_idx),:));
end
hold off

% Set options 
    colorbar
    caxis([min(MaxSpring) max(MaxSpring)]);
    view(-37.5, 30)
    grid on
    title({['Maximum spring-bed coefficent'] ['E = ' num2str(E) ' MPa']});
    xlabel('c [-]');
    ylabel('k_0 [kPa/mm]');
    zlabel('k [kPa/mm]');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
figure(1000)    
carray = repelem(c,length(c));
karrayfirst = repmat(k,length(c));
karray = karrayfirst(1,:);
Stressdiffcandk = reshape(Stressdiffcandk,1,numel(Stressdiffcandk));
Stressdiffcandk = Stressdiffcandk * 1000;
% Find the difference
diff = max(Stressdiffcandk) - min(Stressdiffcandk);

% Make the colormap and plot it
cm = colormap(cool(round(diff)));
hold all
for k1 = 1:numel(Stressdiffcandk)
    sh(k1) = stem3(carray(k1), karray(k1), Stressdiffcandk(k1));
    cm_idx = max( Stressdiffcandk(k1) - min(Stressdiffcandk), 1 );
    set(sh(k1), 'Color',cm(round(cm_idx),:), 'MarkerFaceColor',cm(round(cm_idx),:), 'MarkerEdgeColor',cm(round(cm_idx),:));
end
hold off

% Set options 
    colorbar
    caxis([min(Stressdiffcandk) max(Stressdiffcandk)]);
    view(-37.5, 30)
    grid on
    title({['Standard deviation'] ['E = ' num2str(E) ' MPa']});
    xlabel('c [-]');
    ylabel('k_0 [kPa/mm]');
    zlabel('\sigma [Pa]');
    
end

end

    