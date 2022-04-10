function f = price_function(x)
%% Function to optimize for BECS4 project
% Have a look at readme.md to know what the different parameters are

% Checks input parameter
if ~isnumeric(x)
    error("Double expected but %s was given ",class(x))
end

if length(x)~=3
    error("Input parameter must have a size of 3, %d was given",length(x))
end
    f= 10 * (3-(1-x(1))*3/2) + 0.2*(60-(1-x(2))*30/2) + 22*(3-(1-x(3))*3/2);
end
