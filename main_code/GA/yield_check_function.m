function f = yield_function(x)
%% Checks if the yield is higher than 60%
% Have a look at readme.md to know what the different parameters are

% Checks input parameter
if ~isnumeric(x)
    error("Double expected but %s was given ",class(x))
end

if length(x)~=3
    error("Input parameter must have a size of 3, %d was given",length(x))
end
    f=  91.99 + 2.81*x(1) + -1.099*x(2) +2.81*x(3) - 7.99*x(1)^2 - 16.64*x(2)^2 -7.99*x(3)^2 - 5.34*x(1)*x(2) - 5.34*x(2)*x(3);
end
