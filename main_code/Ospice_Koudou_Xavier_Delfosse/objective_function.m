% Lecture: BECS4: Optimisation Methods
% work: Optimization of a chemical reaction on a catalytic bed
% date: 25.04.2022
% authors: Ospice Koudou % Xavier Delfosse


function f = objective_function(x, tamb)
%% Function to optimize for BECS4 project
% Have a look at readme.md to know what the different parameters are
% tamb: ambiant temperature

% Checks input parameter
if ~isnumeric(x)
    error("X: Double expected but %s was given ",class(x))
end

if ~isnumeric(tamb)
    error("Tamb: Double expected but %s was given ",class(x))
end

if (tamb >= 30)
    error("tamb has to be lower than 30 °C ")
end

if length(x)~=3
    error("Input parameter must have a size of 3, %d was given",length(x))
end
    f=  91.99 + 2.81*x(1) + -1.099*x(2) +2.81*x(3) - 7.99*x(1)^2 - 16.64*x(2)^2 -7.99*x(3)^2 - 5.34*x(1)*x(2) - 5.34*x(2)*x(3) - (10 * (3-(1-x(1))*3/2) + 0.2*((60-(1-x(2))*30/2)-tamb) + 22*(3-(1-x(3))*3/2));
end
