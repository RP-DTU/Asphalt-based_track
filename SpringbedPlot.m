function SpringCoefficientPlot = SpringbedPlot(Spring, k,E, h, L, W, c, X, Y,t, SpringBedMapOnOff) 
if SpringBedMapOnOff == 1
 % Plot the deflection off the spring
    for i = 1:length(k)
    figure((h-1)*100+80+i)
    mesh(X,Y,Spring(i).matrix/k(i));
    title({['Spring-bed coefficient after compresssion'] ['E=' num2str(E) 'MPa, t =' num2str(t) 'mm, k_0=' num2str(k(i)) 'kPa/mm and c =' num2str(c)]});
    xlabel('Length [mm]');
    ylabel('Width [mm]');
    zlabel('k [kPa/mm]');
    xlim([0, L]);
    ylim([0, W]);
    %zlim([10, 12]);
    if W == 300
    pbaspect([4 1 1]);
    else
    pbaspect([2 1 1]);          
    end 
    end
end
end