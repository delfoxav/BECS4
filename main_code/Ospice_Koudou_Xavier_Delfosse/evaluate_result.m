function value = evaluate_result(lowerLimits, higherLimits, genes, func)

 tmp = zeros(size(lowerLimits));
    values = zeros(size(lowerLimits));
    disp(x1)
    for i = 1: x1
        for j = 1: length(genes)
            tmp(j) = bin2dec(num2str(P(i,1:genes(j)))); % convert the bin set back to decimal number
            values(j) = lowerLimits(j) + tmp(j) *(higherLimits(j) - lowerLimits(j))/(2^(genes(j))-1); % scale the number in the value range
        end
        H(1,i) = func(values);
    end
    value = H;