function  StepsizeConver = ConverStep(ConverStepOnOff,E,k, stepsize,StepStressMax, StepStressMin, StepStd)
if ConverStepOnOff ==1
                     
        for j = 1:length(k)
            % plot the convergence study
            figure()
            hold on 
            plot(stepsize,StepStressMin(j,:));
            plot(stepsize,StepStressMin(j,:),'ro');
            title({['Mesh convergence for'] ['E = ', num2str(E), 'MPa and k_0 = ', num2str(k(j)),'kPa/mm']});
            xlabel('a [mm]');
            ylabel('Minimum stress [kPa]');
           % ylim([min(min(StepStress)),max(max(StepStress))])
            xticks([0:10:100]);
            set(gca,'xdir','reverse')
            grid on
            grid minor
            hold off
            
                        % plot the convergence study
            figure()
            hold on 
            plot(stepsize,StepStressMax(j,:));
            plot(stepsize,StepStressMax(j,:),'ro');
            title({['Mesh convergence for'] ['E = ', num2str(E), 'MPa and k_0 = ', num2str(k(j)),'kPa/mm']});
            xlabel('a [mm]');
            ylabel('Maximum stress [kPa]');
           % ylim([min(min(StepStress)),max(max(StepStress))])
            xticks([0:10:100]);
            set(gca,'xdir','reverse')
            grid on
            grid minor
            hold off
            
            figure()
            hold on 
            plot(stepsize,StepStd(j,:));
            plot(stepsize,StepStd(j,:),'ro');
            title({['Mesh convergence for'] ['E = ', num2str(E), 'MPa and k_0 = ', num2str(k(j)),'kPa/mm']});
            xlabel('a [mm]');
            ylabel('\sigma [kPa]');
           % ylim([min(min(StepStress)),max(max(StepStress))])
            xticks([0:10:100]);
            set(gca,'xdir','reverse')
            grid on
            grid minor
            hold off
            
end
end
