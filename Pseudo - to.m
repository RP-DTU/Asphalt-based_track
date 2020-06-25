
            %% Initialising values %%

Compute sleeper force using equation (5.3)
OldStress = Force / Area

Define a mesh of squares

     % Calculate the deflection of the half-space 
for i = 1 to length
    for j = 1 to width
        Compute deflection of the considered square using equation (4.1)
        for k = 1 to length
            for h = 1 width
              if i is not k or j is not h
                Compute deflection in that square using equation (4.2)
              end if
            end for
        end for
    end for
end for

    % Compute new stress distribution
AvgDef = mean(deflection of the squares) 
HalfDef = AvgDef  deflection for each square
SquareStress = HalfDef * spring-bed coefficient
NewStress = OldStress + StressSquare

    % Recalculate the spring-bed coefficient in every square
for i = 1 to number of squares in length
    for j = 1 to number of squares in width
        Compute spring-bed coefficient for each square using equation (5.6)
    end for
end for

        %% Finding stress distribution %%
for i = 1 to number of iterations

     % Calculate the deflection of the half-space 
    for i = 1 to length
        for j = 1 to width
            Compute deflection of the considered square using equation (4.1)
            for k = 1 to length
                for h = 1 width
                  if i is not k or j is not h
                    Compute deflection in that square using equation (4.2)
                  end if
                end for
            end for
        end for
    end for

    % Compute the stress distribution
    SpringDef = NewStress / spring-bed coefficient
    TotDef = HalfDef+SpringDef
    AvgDef = mean(TotDef ) 
    HalfDef = AvgDef  - TotDef 
    SquareStress = TotDef  * spring-bed coefficient
    NewStress = NewStress + StressSquare

    % Recalculate the spring-bed coefficient in every square
    for i = 1 to number of squares in length
        for j = 1 to number of squares in width
            Compute spring-bed coefficient for each square using equation (5.6)
        end for
    end for

end for 
