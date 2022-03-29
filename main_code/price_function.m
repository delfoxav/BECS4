function f = price_function(x,y,z)
%% Function to optimize for BECS4 project
% Have a look at readme.md to know what the different parameters are
    f= 87.6 + 6.41*x + 2.53*y + 9.29*z + 3.39*x^2 - 16.64*y^2 -4.84*z^2 - 3.43*x*y - 3.63*y*z
end
