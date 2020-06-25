function plot = CollectAllPoints(E, k, Stressdiff,t,c)

figure(1000)
% Reshape vectors
Earray = repelem(E,length(k));
karrayfirst = repmat(k,length(E));
karray = karrayfirst(1,:);
Stressdiff = reshape(Stressdiff,1,numel(Stressdiff));
Stressdiff = Stressdiff * 1000;
% Find the difference
diff = max(Stressdiff) - min(Stressdiff);

% Make the colormap and plot it
cm = colormap(cool(round(diff)));
hold all
for k1 = 1:numel(Stressdiff)
    sh(k1) = stem3(Earray(k1), karray(k1), Stressdiff(k1));
    cm_idx = max( Stressdiff(k1) - min(Stressdiff), 1 );
    set(sh(k1), 'Color',cm(round(cm_idx),:), 'MarkerFaceColor',cm(round(cm_idx),:), 'MarkerEdgeColor',cm(round(cm_idx),:));
end
hold off

% Set options 
    colorbar
    caxis([min(Stressdiff) max(Stressdiff)]);
    view(-37.5, 30)
    grid on
    title({['Standard deviation of the stress']});
    xlabel('E [MPa]');
    ylabel('k_0 [kPa/mm]');
    zlabel('\sigma [kPa]');

end