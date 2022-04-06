function f = price_function(x)
%% Function to optimize for BECS4 project
% Have a look at readme.md to know what the different parameters are
    f= 87.6 + 6.41*x(1) + 2.53*x(2) + 9.29*x(3) + 3.39*x(1)^2 - 16.64*x(2)^2 -4.84*x(3)^2 - 3.43*x(1)*x(2) - 3.63*x(2)*x(3);
end
