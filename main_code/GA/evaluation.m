function value = evaluation(P, lowerLimits, higherLimits, genes, func)
%% Evaluation of the Genetic algoritm results
% return the values corresponding to the individuals of the populations
    % P = population
    % lowerLimits = vector of the lower bound on each variable
    % higherLimits = vector of the higher bound on each variable
    % genes = vector of genes used for each variable
    % func = function to optimize
    [x1, y1] = size(P);
    H = zeros(1,x1);
    tmp = zeros(size(lowerLimits));
    values = zeros(size(lowerLimits));
    for i = 1: x1
        for j = 1: length(genes)
            tmp(j) = bin2dec(num2str(P(i,1:genes(j)))); % convert the bin set back to decimal number
            values(j) = lowerLimits(j) + tmp(j) *(higherLimits(j) - lowerLimits(j))/(2^(genes(j))-1); % scale the number in the value range
        end
        H(1,i) = func(values);
    end
    value = H;