function  NumberIterations = ConvergenceStudy(ConvergenceStudyOnOf,iterations,IMaxk,E,k)

if ConvergenceStudyOnOf == 1
        for j = 1:length(k)
            % plot the convergence study
            figure()
            plot([1:iterations],IMaxk(j,:));
            title({['Iteration convergence study'] ['E = ', num2str(E), ' MPa and k_0 = ', num2str(k(j)),' kPa/mm']});
            xlabel('Iterations [-]');
            ylabel('\sigma [kPa]');
            grid on
            grid minor
        end
    end
end
