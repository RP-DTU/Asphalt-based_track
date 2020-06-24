function plotting = VariousThickness(X, Y, x, y, k, E, t, c, ThicknessSTD, VariousthinknessOnOff)

if VariousthinknessOnOff == 1
% for i = 1:length(t)
%    STDt(i,:) = ThicknessSTD(:,i);
%    STDk(i,:) = ThicknessSTD(i,:);
% end
%     
% Function of t
figure(1006)
plot(t,ThicknessSTD);
    title({['Standard deviation of the stress distribution as a function of t'] ['E =' num2str(E) 'MPa and c =' num2str(c)]});
    xlabel('t [mm]');
    ylabel('Standard deviation [-]');
    grid on
    lgd = legend(string(k),'location','eastoutside');
    title(lgd,'k_0 [kPa/mm]')
    %ylim([StressMin, StressMax])
    
    
    % Function of k
    figure(1007)
plot(k,ThicknessSTD);
    title({['Standard deviation of the stress distribution as a function of k'] ['E =' num2str(E) 'MPa and c =' num2str(c)]});
    xlabel('k_0 [kPa/mm]');
    ylabel('\sigma [kPa]');
    grid on
    lgd = legend(string(t),'location','eastoutside');
    title(lgd,'t [mm]')
    %ylim([StressMin, StressMax])
    
    
figure(1008)
% Reshape vectors
tarray = repelem(log10(t),length(k));
karrayfirst = repmat(k,length(t));
karray = karrayfirst(1,:);
ThicknessSTD = reshape(ThicknessSTD,1,numel(ThicknessSTD));

% Find the difference
diff = max(ThicknessSTD) - min(ThicknessSTD);

% Make the colormap and plot it
cm = colormap(cool(ceil(diff)));
hold all
for k1 = 1:numel(ThicknessSTD)
    sh(k1) = stem3(tarray(k1), karray(k1), ThicknessSTD(k1));
    cm_idx = max( ThicknessSTD(k1) - min(ThicknessSTD), 1 );
    set(sh(k1), 'Color',cm(round(cm_idx),:), 'MarkerFaceColor',cm(round(cm_idx),:), 'MarkerEdgeColor',cm(round(cm_idx),:));
end
hold off

% Set options 
    %colorbar
    %caxis([min(Stressdiff) max(Stressdiff)]);
    view(-37.5, 30)
    grid on
    title({['Standard deviation of the stress'] ['E =' num2str(E) 'MPa and c=' num2str(c)]});
    xlabel('t [mm]');
    ylabel('k_0 [MPa/mm]');
    zlabel('\sigma [kPa]')
    
    
end
 
 