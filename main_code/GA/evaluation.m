function value = evaluation(P, lowerLimits, higherLimits, bits, func)
    % P = population
    % lowerLimits = vector of the lower bound on each variable
    % higherLimits = vector of the higher bound on each variable
    % bits = vector of bits used for each variable
    % func = function to optimize
    [x1, y1] = size(P);
    H = zeros(1,x1);
    tmp = zeros(size(lowerLimits));
    values = zeros(size(lowerLimits));
    disp(x1)
    for i = 1: x1
        for j = 1: length(bits)
            tmp(j) = bin2dec(num2str(P(i,1:bits(j))));
            values(j) = lowerLimits(j) + tmp(j) *(higherLimits(j) - lowerLimits(j))/(2^(bits(j))-1);
        end
        H(1,i) = func(values);
    end
    value = H;