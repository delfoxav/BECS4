% Lecture: BECS4: Optimisation Methods
% work: Optimization of a chemical reaction on a catalytic bed
% date: 25.04.2022
% authors: Ospice Koudou % Xavier Delfosse

function f = yield_function(x, tamb)
%% Yield Function to optimize for BECS4 project
% Have a look at readme.md to know what the different parameters are
% tamb = ambiant temperature

% Checks input parameter
if ~isnumeric(x)
    error("Double expected but %s was given ",class(x))
end

if ~isnumeric(tamb)
    error("Double expected but %s was given ",class(tamb))
end


if length(x)~=3
    error("Input parameter must have a size of 3, %d was given",length(x))
end
    f=  91.99 + 2.81*x(1) + -1.099*x(2) +2.81*x(3) - 7.99*x(1)^2 - 16.64*x(2)^2 -7.99*x(3)^2 - 5.34*x(1)*x(2) - 5.34*x(2)*x(3);
end
