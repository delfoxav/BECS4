function value = evaluate_result(lowerLimits, higherLimits, genes, func)

 a = 0;
 b = 1;
 tmp = zeros(size(lowerLimits));
    values = zeros(size(lowerLimits));
    for i = 1: x1
        for j = 1: length(genes)
            
            a = a + genes(j)
            tmp(j) = bin2dec(num2str(P(i,b:a))); % convert the bin set back to decimal number
            values(j) = lowerLimits(1) + tmp(j) *(higherLimits(j) - lowerLimits(j))/(2^(genes(j))-1); % scale the number in the value range
            b = a+1;
        end
        H(1,i) = func(values);
    end
    value = H;